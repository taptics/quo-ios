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

- (IBAction)back:(id)sender;
- (IBAction)share:(id)sender;

@end

@implementation PostController

#pragma mark - Actions

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)share:(id)sender {
    NSLog(@"Share");
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
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateStyle = NSDateFormatterMediumStyle;
    
    _dateLabel.text = [formatter stringFromDate:[NSDate date]];
    _bottomBarView.layer.borderColor = [UIColor colorWithRed:225/255.f green:225/255.f blue:225/255.f alpha:1.f].CGColor;
    _bottomBarView.layer.borderWidth = 1.f;
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255/255.f green:117/255.f blue:80/255.f alpha:1.f];
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
