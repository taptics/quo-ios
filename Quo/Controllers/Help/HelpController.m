//
//  HelpController.m
//  Quo
//
//  Created by Ryan Cohen on 11/13/14.
//  Copyright (c) 2014 Taptics. All rights reserved.
//

#import "HelpController.h"
#import "Quo.h"
#import "InfoCell.h"

@interface HelpController ()

@property (nonatomic, strong) IBOutlet UITableView *tableView;

- (IBAction)back:(id)sender;
- (void)openMailWithSubject:(NSString *)subject;

@end

@implementation HelpController

#pragma mark - Actions

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)openMailWithSubject:(NSString *)subject {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailController = [MFMailComposeViewController new];
        mailController.mailComposeDelegate = self;
        mailController.navigationBar.tintColor = QUO_ORANGE_COLOR;
        
        [mailController setToRecipients:@[@"support@taptics.co"]];
        [mailController setSubject:subject];
        
        [mailController setMessageBody:@"" isHTML:NO];
        
        [self presentViewController:mailController animated:true completion:nil];
        
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Quo"
                                                                       message:@"Hey, please configure a mail account to send feedback!"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *dismiss = [UIAlertAction actionWithTitle:@"Dismiss"
                                                          style:UIAlertActionStyleCancel
                                                        handler:^(UIAlertAction *action) {
                                                            
                                                            [alert dismissViewControllerAnimated:YES completion:nil];
                                                        }];
        
        
        [alert addAction:dismiss];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark - Table

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = 0;
    
    if (section == 0) {
        rows = 2;
        
    } else {
        rows = 1;
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
        
    } else {
        title = @"Tip";
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
            cell.titleLabel.text = @"Report problem";
            
            UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(15, cell.contentView.frame.size.height + 29, CGRectGetWidth([UIScreen mainScreen].bounds) - 31, 1)];
            separator.backgroundColor = [UIColor colorWithRed:225/255.f green:225/255.f blue:225/255.f alpha:1.f];
            [cell.contentView addSubview:separator];
            
        } else {
            cell.titleLabel.text = @"Send feedback";
        }
        
        return cell;
        
    } else {
        static NSString *cellId = @"DescriptionCellId";
        InfoCell *cell = (InfoCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
        
        if (!cell) {
            cell = [[InfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.descriptionLabel.text = @"Shake your device while viewing a post to flag it for review.";
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NSString *version = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"];
            NSString *subject = [NSString stringWithFormat:@"Problem with Quo v%@", version];
            [self openMailWithSubject:subject];
            
        } else {
            NSString *version = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"];
            NSString *subject = [NSString stringWithFormat:@"Feedback for Quo v%@", version];
            [self openMailWithSubject:subject];
        }
    }
}

#pragma mark - Mail

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
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
