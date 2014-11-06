//
//  SignUpController.m
//  Quo
//
//  Created by Ryan Cohen on 10/29/14.
//  Copyright (c) 2014 Taptics. All rights reserved.
//

#import "SignUpController.h"
#import "FormCell.h"
#import "Quo.h"

@interface SignUpController ()

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *emailField;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) NSArray *textFields;

- (IBAction)back:(id)sender;

@end

@implementation SignUpController

#pragma Actions

- (IBAction)back:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"CellId";
    FormCell *cell = (FormCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[FormCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        [cell.contentView addSubview:_nameField];
    }
    
    else if (indexPath.row == 1) {
        [cell.contentView addSubview:_emailField];
        
    } else {
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
    textField.autocorrectionType = UITextAutocorrectionTypeDefault;
    textField.font = [UIFont fontWithName:LATO_FONT size:19.f];
    textField.textColor = DARK_TEXT_COLOR;
    
    return textField;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag < 2) {
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
    
    _nameField = [self cellTextField];
    _nameField.tag = 0;
    _nameField.delegate = self;
    _nameField.placeholder = @"Name";
    _nameField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    
    _emailField = [self cellTextField];
    _emailField.tag = 1;
    _emailField.delegate = self;
    _emailField.placeholder = @"Email";
    _emailField.keyboardType = UIKeyboardTypeEmailAddress;
    
    _passwordField = [self cellTextField];
    _passwordField.tag = 2;
    _passwordField.delegate = self;
    _passwordField.placeholder = @"Password";
    _passwordField.secureTextEntry = YES;
    _passwordField.returnKeyType = UIReturnKeyDone;
    
    _textFields = @[_nameField, _emailField, _passwordField];
    
    [_nameField becomeFirstResponder];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255/255.f green:117/255.f blue:80/255.f alpha:1.f];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIFont fontWithName:@"Lato-Bold" size:20], NSFontAttributeName,
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
