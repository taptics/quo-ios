//
//  LoginController.m
//  Quo
//
//  Created by Ryan Cohen on 10/29/14.
//  Copyright (c) 2014 Taptics. All rights reserved.
//

#import "LoginController.h"
#import "FormCell.h"
#import "Quo.h"

@interface LoginController ()

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UITextField *emailField;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) NSArray *textFields;

- (IBAction)back:(id)sender;
- (IBAction)send:(id)sender;

- (void)disableEditing:(BOOL)disable;

@end

@implementation LoginController

#pragma mark - Actions

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)send:(id)sender {
    [self disableEditing:YES];
    
    if ([self isEmpty:_emailField.text] || [self isEmpty:_passwordField.text]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Quo"
                                                                       message:@"Hey, you're missing some information!"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *dismiss = [UIAlertAction actionWithTitle:@"Dismiss"
                                                          style:UIAlertActionStyleCancel
                                                        handler:^(UIAlertAction *action) {
                                                            
                                                            [alert dismissViewControllerAnimated:YES completion:nil];
                                                        }];
        
        
        [alert addAction:dismiss];
        [self presentViewController:alert animated:YES completion:nil];
        [self disableEditing:NO];
        
    } else {
        [[Quo sharedClient] authenticateUserWithEmail:_emailField.text password:_passwordField.text block:^(BOOL success) {
            if (success) {
                [[QUOBufferView sharedInstance] endBuffer];
                [self performSegueWithIdentifier:@"ToHome" sender:self];
                
            } else {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Quo"
                                                                               message:@"Sorry, that information is incorrect."
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *dismiss = [UIAlertAction actionWithTitle:@"Dismiss"
                                                                  style:UIAlertActionStyleCancel
                                                                handler:^(UIAlertAction *action) {
                                                                    
                                                                    [alert dismissViewControllerAnimated:YES completion:nil];
                                                                }];
                
                
                [alert addAction:dismiss];
                [self presentViewController:alert animated:YES completion:nil];
                [self disableEditing:NO];
            }
        }];
    }
    
}

- (void)disableEditing:(BOOL)disable {
    if (disable) {
        [QUOBufferView sharedInstance].activeView = self.navigationController.view;
        [[QUOBufferView sharedInstance] beginBuffer];
        
    } else {
        [QUOBufferView sharedInstance].activeView = self.navigationController.view;
        [[QUOBufferView sharedInstance] endBuffer];
        
        [_passwordField becomeFirstResponder];
    }
}

#pragma mark - Table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"CellId";
    FormCell *cell = (FormCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[FormCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        [cell.contentView addSubview:_emailField];
    }
    
    else if (indexPath.row == 1) {
        [cell.contentView addSubview:_passwordField];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64.f;
}

#pragma mark - Fields

- (UITextField *)cellTextField {
    UITextField *textField = [[UITextField alloc] initWithFrame:CELL_TEXTFIELD_FRAME];
    textField.returnKeyType = UIReturnKeyNext;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.font = [UIFont fontWithName:LATO_FONT size:19.f];
    textField.textColor = DARK_TEXT_COLOR;
    textField.tintColor = DARK_TEXT_COLOR;
    
    return textField;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag < 1) {
        UITextField *nextTextField = [_textFields objectAtIndex:textField.tag + 1];
        [nextTextField becomeFirstResponder];
        
    } else {
        [self send:nil];
    }
    
    return YES;
}

- (BOOL)isEmpty:(NSString *)string {
    if ([string length] == 0) {
        return true;
    }
    
    if (![[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]) {
        return true;
    }
    return false;
}

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _tableView.bounds.size.width, 10.f)];
    
    _emailField = [self cellTextField];
    _emailField.tag = 0;
    _emailField.delegate = self;
    _emailField.placeholder = @"Email";
    _emailField.keyboardType = UIKeyboardTypeEmailAddress;
    _emailField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    _passwordField = [self cellTextField];
    _passwordField.tag = 1;
    _passwordField.delegate = self;
    _passwordField.placeholder = @"Password";
    _passwordField.secureTextEntry = YES;
    _passwordField.returnKeyType = UIReturnKeyDone;
    
    _textFields = @[_emailField, _passwordField];
    
    [_emailField becomeFirstResponder];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255/255.f green:117/255.f blue:80/255.f alpha:1.f];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIFont fontWithName:@"Lato-Bold" size:20], NSFontAttributeName,
                                [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
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
