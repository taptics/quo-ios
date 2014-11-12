//
//  ComposeController.m
//  Quo
//
//  Created by Ryan Cohen on 11/11/14.
//  Copyright (c) 2014 Taptics. All rights reserved.
//

#import "ComposeController.h"

@interface ComposeController ()

- (IBAction)cancel:(id)sender;
- (IBAction)post:(id)sender;

@end

@implementation ComposeController

#pragma mark - Actions

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)post:(id)sender {
    NSLog(@"Post");
}

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
