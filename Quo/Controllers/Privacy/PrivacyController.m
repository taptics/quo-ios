//
//  PrivacyController.m
//  Quo
//
//  Created by Ryan Cohen on 11/14/14.
//  Copyright (c) 2014 Taptics. All rights reserved.
//

#import "PrivacyController.h"

@interface PrivacyController ()

@property (nonatomic, strong) IBOutlet UIWebView *webView;

- (IBAction)back:(id)sender;

@end

@implementation PrivacyController

#pragma mark - Actions

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:@"http://quoapp.co/privacy"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [_webView loadRequest:request];
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
