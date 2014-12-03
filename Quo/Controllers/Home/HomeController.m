//
//  HomeController.m
//  Quo
//
//  Created by Ryan Cohen on 10/8/14.
//  Copyright (c) 2014 Taptics. All rights reserved.
//

#import "HomeController.h"
#import "PostController.h"
#import "HomePostCell.h"
#import "Quo.h"

@interface HomeController ()

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UILongPressGestureRecognizer *gestureRecognizer;
@property (nonatomic, strong) NSArray *posts;

- (IBAction)compose:(id)sender;
- (IBAction)settings:(id)sender;

- (void)storePosts:(NSArray *)posts;
- (void)drafts;
- (void)signIn;
- (void)about;
- (void)help;
- (void)signOut;

@end

@implementation HomeController

#pragma mark - Methods

- (IBAction)compose:(id)sender {
    if (![QUOUser currentUser].loggedIn) {
        if ([QUOSlideMenu sharedInstance].isDisplayed) {
            [[QUOSlideMenu sharedInstance] dismiss];
        }
        
        QUOActionSheet *sheet = [[QUOActionSheet alloc] initWithType:QUOActionSheetTypeSignIn forView:self.navigationController.view];
        [sheet show];
    
    } else {
        if ([QUOSlideMenu sharedInstance].isDisplayed) {
            [[QUOSlideMenu sharedInstance] dismiss];
        }
        
        [self performSegueWithIdentifier:@"ToCompose" sender:self];
    }
}

- (IBAction)settings:(id)sender {
    if (![QUOSlideMenu sharedInstance].isDisplayed) {
        [QUOSlideMenu sharedInstance].activeView = self.view;
        [[QUOSlideMenu sharedInstance] show];
        
    } else {
        [[QUOSlideMenu sharedInstance] dismiss];
    }
}

- (void)storePosts:(NSArray *)posts {
    self.posts = [NSArray arrayWithArray:posts];
    
    [self.tableView reloadData];
    // [[QUOBufferView sharedInstance] endBuffer];
}

- (void)drafts {
    [self performSegueWithIdentifier:@"ToDrafts" sender:self];
}

- (void)signIn {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)about {
    [self performSegueWithIdentifier:@"ToAbout" sender:self];
}

- (void)help {
    [self performSegueWithIdentifier:@"ToHelp" sender:self];
}

- (void)signOut {
    [[QUOBufferView sharedInstance] endBuffer];
    [[QUOUser currentUser] logOut];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Table

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"November 2014";
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(17, 18, 320, 20)];
    label.font = [UIFont fontWithName:LATO_FONT size:17.f];
    label.text = [self tableView:tableView titleForHeaderInSection:section];
    label.textColor = [UIColor colorWithRed:139/255.f green:139/255.f  blue:139/255.f  alpha:1.f];
    
    UIView *headerView = [UIView new];
    [headerView addSubview:label];
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"CellId";
    HomePostCell *cell = (HomePostCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[HomePostCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    QUOPost *post = (QUOPost *)[self.posts objectAtIndex:indexPath.row];
    cell.postTitleLabel.text = post.title;
    cell.postAuthorLabel.text = @"Anonymous";
    cell.postPreviewLabel.text = post.text;
    
    return cell;
}

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // [QUOBufferView sharedInstance].activeView = self.navigationController.view;
    // [[QUOBufferView sharedInstance] beginBuffer];
    
    [[Quo sharedClient] getAllPostsWithBlock:^(NSArray *posts) {
        [self storePosts:posts];
    }];
    
    _tableView.backgroundView = nil;
    _tableView.backgroundColor = [UIColor colorWithRed:244/255.f green:241/255.f blue:237/255.f alpha:1.f];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255/255.f green:117/255.f blue:80/255.f alpha:1.f];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(signIn) name:@"QUOSignInNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(about) name:@"QUOAboutNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(help) name:@"QUOHelpNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(signOut) name:@"QUOSignOutNotification" object:nil];
    
    _gestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(drafts)];
    _gestureRecognizer.minimumPressDuration = 0.8f;
    _gestureRecognizer.allowableMovement = 100.f;
    
    [self.navigationController.navigationBar addGestureRecognizer:_gestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ToCompose"] ||
        [segue.identifier isEqualToString:@"ToAbout"]   ||
        [segue.identifier isEqualToString:@"ToDrafts"]  ||
        [segue.identifier isEqualToString:@"ToHelp"]) {
        
        return;
    }
    
    PostController *postController = (PostController *)[segue destinationViewController];
    QUOPost *post = [_posts objectAtIndex:[_tableView indexPathForSelectedRow].row];
    postController.post = post;
}

@end
