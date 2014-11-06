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

@end

@implementation LoginController

#pragma mark - Actions

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
    
    return textField;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag < 1) {
        UITextField *nextTextField = [_textFields objectAtIndex:textField.tag + 1];
        [nextTextField becomeFirstResponder];
        
    } else {
        [textField resignFirstResponder];
    }
    
    return YES;
}

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.backgroundColor = [UIColor clearColor];
    
    _emailField = [self cellTextField];
    _emailField.tag = 0;
    _emailField.delegate = self;
    _emailField.placeholder = @"Email";
    _emailField.keyboardType = UIKeyboardTypeEmailAddress;
    
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
    
    // TODO: Custom back button item
    // UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:[UIImage imageNamed:@"Back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    // _navigationItem.backBarButtonItem = backButton;
    
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
