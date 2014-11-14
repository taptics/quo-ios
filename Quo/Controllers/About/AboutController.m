//
//  AboutController.m
//  Quo
//
//  Created by Ryan Cohen on 11/13/14.
//  Copyright (c) 2014 Taptics. All rights reserved.
//

#import "AboutController.h"

@interface AboutController ()

@property (nonatomic, strong) IBOutlet UITableView *tableView;

- (IBAction)back:(id)sender;

@end

@implementation AboutController

#pragma mark - Actions

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = 0;
    
    if (section == 0) {
        rows = 2;
    }
    
    else if (section == 1) {
        rows = 1;
        
    } else {
        rows = 2;
    }
    
    return rows;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(17, 5, 320, 20)];
    label.font = [UIFont fontWithName:LATO_FONT size:17.f];
    label.text = [self tableView:tableView titleForHeaderInSection:section];
    label.textColor = [UIColor colorWithRed:139/255.f green:139/255.f  blue:139/255.f  alpha:1.f];
    
    UIView *headerView = [UIView new];
    [headerView addSubview:label];
    
    return headerView;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title = @"";
    
    if (section == 0) {
        title = nil;
    }
    
    else if (section == 1) {
        title = @"Who are we?";
        
    } else {
        title = @"Follow us on Twitter";
    }
    
    return title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *cellId = @"HeaderCellId";
        InfoCell *cell = (InfoCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
        
        if (!cell) {
            cell = [[InfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"Terms & Conditions";
            
            UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(15, cell.contentView.frame.size.height + 29, CGRectGetWidth([UIScreen mainScreen].bounds) - 31, 1)];
            separator.backgroundColor = [UIColor colorWithRed:225/255.f green:225/255.f blue:225/255.f alpha:1.f];
            [cell.contentView addSubview:separator];
            
        } else {
            cell.titleLabel.text = @"Privacy Policy";
        }
        
        return cell;
    }
    
    else if (indexPath.section == 1) {
        static NSString *cellId = @"DescriptionCellId";
        InfoCell *cell = (InfoCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
        
        if (!cell) {
            cell = [[InfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.descriptionLabel.text = @"Quo is designed and developed by Taptics, a small company consisting of Ryan Cohen, Phil Fishbein, Jack Defuria, and Jacqueline Angel.";
        
        return cell;
        
    } else {
        static NSString *cellId = @"HeaderCellId";
        InfoCell *cell = (InfoCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
        
        if (!cell) {
            cell = [[InfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"@quoapp";
            
            UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(15, cell.contentView.frame.size.height + 29, CGRectGetWidth([UIScreen mainScreen].bounds) - 31, 1)];
            separator.backgroundColor = [UIColor colorWithRed:225/255.f green:225/255.f blue:225/255.f alpha:1.f];
            [cell.contentView addSubview:separator];
            
        } else {
            cell.titleLabel.text = @"@tapticsco";
        }
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self performSegueWithIdentifier:@"ToTerms" sender:self];
            
        } else {
            [self performSegueWithIdentifier:@"ToPrivacy" sender:self];
        }
    }
    
    else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://user?screen_name=quoapp"]]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?screen_name=quoapp"]];
                
            } else {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://twitter.com/quoapp"]];
            }
            
        } else {
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://user?screen_name=tapticsco"]]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?screen_name=tapticsco"]];
                
            } else {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://twitter.com/tapticsco"]];
            }
        }
        
    } else {
        return;
    }
}

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.backgroundView = nil;
    _tableView.backgroundColor = [UIColor colorWithRed:244/255.f green:241/255.f blue:237/255.f alpha:1.f];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _tableView.bounds.size.width, 1.f)];
    _tableView.estimatedRowHeight = 44.f;
    _tableView.rowHeight = UITableViewAutomaticDimension;
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
