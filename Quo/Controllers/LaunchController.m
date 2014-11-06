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

@property (nonatomic, strong) IBOutlet UIButton *signUpButton;
@property (nonatomic, strong) IBOutlet UIButton *loginButton;

@end

@implementation LaunchController

#pragma mark - View

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
    self.signUpButton.tintColor = [UIColor whiteColor];
    self.signUpButton.backgroundColor = [UIColor colorWithRed:255/255.f green:117/255.f blue:80/255.f alpha:1.f];
    self.signUpButton.layer.cornerRadius = 4.f;
    
    self.loginButton.tintColor = [UIColor colorWithRed:193/255.f green:193/255.f blue:193/255.f alpha:1.f];
    self.loginButton.backgroundColor = [UIColor whiteColor];
    self.loginButton.layer.borderColor = [UIColor colorWithRed:193/255.f green:193/255.f blue:193/255.f alpha:1.f].CGColor;
    self.loginButton.layer.borderWidth = 2.f;
    self.loginButton.layer.cornerRadius = 4.f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
