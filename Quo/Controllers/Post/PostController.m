//
//  PostController.m
//  Quo
//
//  Created by Ryan Cohen on 11/13/14.
//  Copyright (c) 2014 Taptics. All rights reserved.
//

#import "PostController.h"
#import "PostCell.h"

@interface PostController ()

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIView *bottomBarView;
@property (nonatomic, strong) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) IBOutlet UILabel *likesLabel;
@property (nonatomic, strong) IBOutlet UIButton *heartButton;

- (IBAction)back:(id)sender;
- (IBAction)share:(id)sender;
- (IBAction)heart:(id)sender;

- (void)flag;

@end

@implementation PostController

#pragma mark - Actions

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)share:(id)sender {
    NSString *postTitle = [NSString stringWithFormat:@"Check out '%@' on Quo:", _post.title];
    NSString *postLink = [NSString stringWithFormat:@"http://quo.taptics.co/post/%@", _post.identifier];
    
    NSArray *activityItems = @[ postTitle, postLink ];
    NSArray *excludeActivities= @[ UIActivityTypePostToWeibo,
                                   UIActivityTypeAssignToContact,
                                   UIActivityTypeSaveToCameraRoll,
                                   UIActivityTypeAddToReadingList,
                                   UIActivityTypePostToFlickr,
                                   UIActivityTypePostToVimeo,
                                   UIActivityTypePostToTencentWeibo,
                                   UIActivityTypeAirDrop ];
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    activityController.excludedActivityTypes = excludeActivities;
    activityController.view.tintColor = QUO_ORANGE_COLOR;
    
    [self presentViewController:activityController animated:YES completion:nil];
}

- (IBAction)heart:(id)sender {
    // TODO: Check current user
    
    if ([_heartButton.imageView.image isEqual:[UIImage imageNamed:@"Liked"]]) {
        [_heartButton setImage:[UIImage imageNamed:@"Unliked"] forState:UIControlStateNormal];
        
    } else {
        [_heartButton setImage:[UIImage imageNamed:@"Liked"] forState:UIControlStateNormal];
        [[Quo sharedClient] likePostWithIdentifier:_post.identifier userId:[QUOUser currentUser].identifier block:^(BOOL success) {
            if (success) {
                NSLog(@"Spread the love!");
            } else {
                NSLog(@"Couldn't spread love :(");
            }
        }];
    }
}

- (void)flag {
    // TODO: Check current user
    
    [[Quo sharedClient] flagPostWithIdentifier:_post.identifier block:^(BOOL success) {
        if (success) {
            NSLog(@"Flagged post!");
        } else {
            NSLog(@"Couldn't flag post!");
        }
    }];
}

#pragma mark - Table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        static NSString *titleCellId = @"TitleCellId";
        PostCell *cell = (PostCell *)[tableView dequeueReusableCellWithIdentifier:titleCellId];
        
        if (!cell) {
            cell = [[PostCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:titleCellId];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.postTitleTextField.userInteractionEnabled = NO;
        cell.postTitleTextField.text = _post.title;
        cell.postLineCountLabel.text = @"5";
        
        return cell;
        
    }
    
    else if (indexPath.row == 1) {
        static NSString *userCellId = @"UserCellId";
        PostCell *cell = (PostCell *)[tableView dequeueReusableCellWithIdentifier:userCellId];
        
        if (!cell) {
            cell = [[PostCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:userCellId];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.postUserTextField.userInteractionEnabled = NO;
        cell.postUserTextField.text = @"Unknown";
        
        return cell;
        
    } else {
        static NSString *bodyCellId = @"BodyCellId";
        PostCell *cell = (PostCell *)[tableView dequeueReusableCellWithIdentifier:bodyCellId];
        
        if (!cell) {
            cell = [[PostCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:bodyCellId];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.postBodyTextView.userInteractionEnabled = NO;
        cell.postBodyTextView.text = _post.text;
        
        return cell;
    }
}

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _tableView.bounds.size.width, 15.f)];
    _tableView.estimatedRowHeight = 44.f;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    
    _likesLabel.text = @"0 likes";
    [[Quo sharedClient] getPostWithIdentifier:_post.identifier block:^(QUOPost *post) {
        _likesLabel.text = [NSString stringWithFormat:@"%@ likes", post.likes];
    }];
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *date = [formatter dateFromString:_post.createdAt];
    formatter.dateStyle = NSDateFormatterMediumStyle;
    
    _dateLabel.text = [formatter stringFromDate:date];
    _bottomBarView.layer.borderColor = [UIColor colorWithRed:225/255.f green:225/255.f blue:225/255.f alpha:1.f].CGColor;
    _bottomBarView.layer.borderWidth = 1.f;
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255/255.f green:117/255.f blue:80/255.f alpha:1.f];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(flag) name:@"QUOFlagPostNotification" object:nil];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        QUOActionSheet *sheet = [[QUOActionSheet alloc] initWithType:QUOActionSheetTypeFlag forView:self.navigationController.view];
        [sheet show];
    }
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
