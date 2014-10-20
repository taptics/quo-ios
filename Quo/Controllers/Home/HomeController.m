//
//  HomeController.m
//  Quo
//
//  Created by Ryan Cohen on 10/8/14.
//  Copyright (c) 2014 Taptics. All rights reserved.
//

#import "HomeController.h"
#import "HomePostCell.h"
#import "Quo.h"

@interface HomeController ()

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *posts;

- (IBAction)compose:(id)sender;
- (IBAction)settings:(id)sender;
- (void)storePosts:(NSArray *)posts;

@end

@implementation HomeController

#pragma mark - Methods

- (IBAction)compose:(id)sender {
    if (![QUOUser currentUser].loggedIn) {
        QUOActionSheet *sheet = [[QUOActionSheet alloc] initWithType:QUOActionSheetTypeFlag forView:self.navigationController.view];
        [sheet show];
        
    } else {
        NSLog(@"Compose");
    }
}

- (IBAction)settings:(id)sender {
    QUOSlideMenu *menu = [[QUOSlideMenu alloc] initWithView:self.view];
    [menu show];
}

- (void)storePosts:(NSArray *)posts {
    self.posts = [NSArray arrayWithArray:posts];
    
    [self.tableView reloadData];
    // [[QUOBufferView sharedInstance] endBuffer];
}

#pragma mark - Table

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"October 2014";
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
    cell.postAuthorLabel.text = @"Unknown";
    cell.postPreviewLabel.text = post.text;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Push to post detail
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // [QUOBufferView sharedInstance].activeView = self.navigationController.view;
    // [[QUOBufferView sharedInstance] beginBuffer];
    
    [[Quo sharedClient] getAllPostsWithBlock:^(NSArray *posts) {
        [self storePosts:posts];
    }];
    
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor colorWithRed:244/255.f green:241/255.f blue:237/255.f alpha:1.f];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255/255.f green:117/255.f blue:80/255.f alpha:1.f];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIFont fontWithName:@"Skolar" size:24], NSFontAttributeName,
                                [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
