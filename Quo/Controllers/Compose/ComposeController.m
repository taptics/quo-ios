//
//  ComposeController.m
//  Quo
//
//  Created by Ryan Cohen on 11/11/14.
//  Copyright (c) 2014 Taptics. All rights reserved.
//

#import "ComposeController.h"

@interface ComposeController ()

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSString *postTitle;
@property (nonatomic, copy) NSString *postBody;

- (IBAction)cancel:(id)sender;
- (IBAction)post:(id)sender;

@end

@implementation ComposeController

#pragma mark - Actions

- (IBAction)cancel:(id)sender {
    [self.view endEditing:YES];
    
    if ([self isEmpty:_postBody]) {
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                       message:nil
                                                                preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *delete = [UIAlertAction actionWithTitle:@"Delete"
                                                         style:UIAlertActionStyleDestructive
                                                       handler:^(UIAlertAction *action) {
                                                           [alert dismissViewControllerAnimated:YES completion:nil];
                                                           [self dismissViewControllerAnimated:YES completion:nil];
                                                       }];
        
        UIAlertAction *draft = [UIAlertAction actionWithTitle:@"Save draft"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          
                                                          // TODO: Save draft
                                                          [alert dismissViewControllerAnimated:YES completion:nil];
                                                      }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction *action) {
                                                           [alert dismissViewControllerAnimated:YES completion:nil];
                                                       }];
        
        
        [alert addAction:delete];
        [alert addAction:draft];
        [alert addAction:cancel];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (IBAction)post:(id)sender {
    if ([self isEmpty:_postTitle] || [self isEmpty:_postBody]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Quo"
                                                                       message:@"Hey, you're missing some words!"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *dismiss = [UIAlertAction actionWithTitle:@"Dismiss"
                                                          style:UIAlertActionStyleCancel
                                                        handler:^(UIAlertAction *action) {
                                                            
                                                            [alert dismissViewControllerAnimated:YES completion:nil];
                                                        }];
        
        
        [alert addAction:dismiss];
        [self presentViewController:alert animated:YES completion:nil];
        
    } else {
        [self.view endEditing:YES];
        
        [QUOBufferView sharedInstance].activeView = self.view;
        [[QUOBufferView sharedInstance] beginBuffer];
        
        [[Quo sharedClient] createPostWithTitle:_postTitle text:_postBody userId:[QUOUser currentUser].identifier location:@"" block:^(BOOL success) {
            if (success) {
                [self dismissViewControllerAnimated:YES completion:nil];
                
            } else {
                NSLog(@"Error posting :(");
            }
        }];
    }
}

#pragma mark - Table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
 
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        static NSString *titleCellId = @"TitleCellId";
        PostCell *cell = (PostCell *)[tableView dequeueReusableCellWithIdentifier:titleCellId];
        
        if (!cell) {
            cell = [[PostCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:titleCellId];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.postTitleTextField.tintColor = DARK_TEXT_COLOR;
        [cell.postTitleTextField becomeFirstResponder];
        
        return cell;
        
    } else {
        static NSString *bodyCellId = @"BodyCellId";
        PostCell *cell = (PostCell *)[tableView dequeueReusableCellWithIdentifier:bodyCellId];
        
        if (!cell) {
            cell = [[PostCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:bodyCellId];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
}

#pragma mark - Text

- (BOOL)isEmpty:(NSString *)string {
    if ([string length] == 0) {
        return true;
    }
    
    if (![[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]) {
        return true;
    }
    return false;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    _postTitle = textField.text;
}

- (void)textViewDidChange:(UITextView *)textView {
    [_tableView beginUpdates];
    [_tableView endUpdates];
    
    _postBody = textView.text;
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    [textView scrollRangeToVisible:textView.selectedRange];
}

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _tableView.bounds.size.width, 0.1f)];
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
