//
//  ViewController.m
//  Quo
//
//  Created by Ryan Cohen on 9/29/14.
//  Copyright (c) 2014 Taptics. All rights reserved.
//

#import "LaunchController.h"
#import "QUOActionSheet.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface LaunchController ()

@property (nonatomic, strong) IBOutlet UIButton *twitterSignUpButton;
@property (nonatomic, strong) IBOutlet UIButton *signUpLaterButton;

- (IBAction)signUpLater:(id)sender;
- (IBAction)signUpWithTwitter:(id)sender;

@end

@implementation LaunchController

#pragma mark - Methods

- (IBAction)signUpLater:(id)sender {
    // Sign up later
    // TODO: Method body
    
    [self performSegueWithIdentifier:@"ToHome" sender:self];
}

- (IBAction)signUpWithTwitter:(id)sender {
    ACAccountStore *store = [ACAccountStore new];
    ACAccountType *type = [store accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [store requestAccessToAccountsWithType:type options:nil completion:^(BOOL granted, NSError *error) {
        if (granted) {
            NSArray *accounts = [store accountsWithAccountType:type];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Choose Account" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *accountAction = nil;
            
            if (accounts.count == 0) {
                alert.title = @"There were no Twitter accounts found on this device.";
            }
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                NSLog(@"Cancelled");
            }];
            
            [alert addAction:cancel];
            
            for (ACAccount *account in accounts) {
                accountAction = [UIAlertAction actionWithTitle:account.username style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    NSLog(@"Chose: %@", action.title);
                }];
                
                [alert addAction:accountAction];
            }
            
            [self presentViewController:alert animated:YES completion:nil];
            
        } else {
            NSLog(@"Access not granted");
        }
    }];
}

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.twitterSignUpButton.tintColor = [UIColor whiteColor];
    self.twitterSignUpButton.backgroundColor = [UIColor colorWithRed:255/255.f green:117/255.f blue:80/255.f alpha:1.f];
    self.twitterSignUpButton.layer.cornerRadius = 4.f;
    
    self.signUpLaterButton.tintColor = [UIColor colorWithRed:193/255.f green:193/255.f blue:193/255.f alpha:1.f];
    self.signUpLaterButton.backgroundColor = [UIColor whiteColor];
    self.signUpLaterButton.layer.borderColor = [UIColor colorWithRed:193/255.f green:193/255.f blue:193/255.f alpha:1.f].CGColor;
    self.signUpLaterButton.layer.borderWidth = 2.f;
    self.signUpLaterButton.layer.cornerRadius = 4.f;
    
    // TODO: Hide status bar
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
