//
//  QUOActionSheet.m
//  Quo
//
//  Created by Ryan Cohen on 10/8/14.
//  Copyright (c) 2014 Taptics. All rights reserved.
//

#import "QUOActionSheet.h"

@interface QUOActionSheet ()

@property (nonatomic, assign) QUOActionSheetType actionSheetType;
@property (nonatomic, strong) UIView *activeView;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UIButton *confirmButton;
@property (nonatomic, strong) IBOutlet UIButton *cancelButton;

- (void)performAction:(UIButton *)sender;

@end

@implementation QUOActionSheet

#pragma Init

- (instancetype)initWithType:(QUOActionSheetType)type forView:(UIView *)view {
    self = [super init];
    if (self) {
        _actionSheetType = type;
        _activeView = view;
        
        self.tag = 1;
        self.frame = CGRectMake(0, _activeView.bounds.size.height+220, CGRectGetWidth([UIScreen mainScreen].bounds), 223);
        self.backgroundColor = [UIColor whiteColor];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 42, 359, 61)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:@"Lato" size:16.f];
        _titleLabel.textColor = [UIColor colorWithRed:79/255.f green:79/255.f blue:79/255.f alpha:1.f];
        [self addSubview:_titleLabel];
        
        _cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _cancelButton.frame = CGRectMake(0, 152, 188, 71);
        _cancelButton.titleLabel.font = [UIFont fontWithName:@"Lato" size:16.5f];
        [_cancelButton setTitleColor:[UIColor colorWithRed:79/255.f green:79/255.f blue:79/255.f alpha:1.f] forState:UIControlStateNormal];
        [_cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(performAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancelButton];
        
        _confirmButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _confirmButton.frame = CGRectMake(186, 152, 188, 71);
        _confirmButton.titleLabel.font = [UIFont fontWithName:@"Lato" size:16.5f];
        [_confirmButton setTitleColor:[UIColor colorWithRed:79/255.f green:79/255.f blue:79/255.f alpha:1.f] forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(performAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_confirmButton];
        
        UIView *horizontalLine = [[UIView alloc] initWithFrame:CGRectMake(0, 152, 375, 1.5)];
        horizontalLine.backgroundColor = [UIColor colorWithRed:225/255.f green:225/255.f blue:225/255.f alpha:1.f];
        [self addSubview:horizontalLine];
        
        UIView *verticalLine = [[UIView alloc] initWithFrame:CGRectMake(186, 152, 1.5, 71)];
        verticalLine.backgroundColor = [UIColor colorWithRed:225/255.f green:225/255.f blue:225/255.f alpha:1.f];
        [self addSubview:verticalLine];
    }
    return self;
}

#pragma mark - Methods

- (void)show {
    if (_actionSheetType == QUOActionSheetTypeFlag) {
        _titleLabel.text = @"Would you like to flag this post?";
        [_confirmButton setTitle:@"Flag" forState:UIControlStateNormal];
    } else {
        _titleLabel.text = @"Oops! You're not signed in.";
        [_confirmButton setTitle:@"Sign in" forState:UIControlStateNormal];
    }
    
    UIView *dimView = [[UIView alloc] initWithFrame:_activeView.frame];
    dimView.tag = 2;
    dimView.alpha = 0.f;
    dimView.backgroundColor = [UIColor blackColor];
    
    [_activeView addSubview:dimView];
    
    [UIView animateWithDuration:0.4 animations:^{
        dimView.alpha = 0.5f;
        
        self.frame = CGRectMake(0, _activeView.bounds.size.height-220, CGRectGetWidth([UIScreen mainScreen].bounds), 223);
        [_activeView addSubview:self];
    }];
}

- (void)performAction:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"Flag"]) {
        NSLog(@"Flag");
    }
    
    else if ([sender.titleLabel.text isEqualToString:@"Sign in"]) {
        NSLog(@"Sign in");
    }
    
    for (UIView *view in _activeView.subviews) {
        if (view.tag == 1) {
            [UIView animateWithDuration:0.4 animations:^{
                self.frame = CGRectMake(0, view.bounds.size.height+450, CGRectGetWidth([UIScreen mainScreen].bounds), 223);
                
            } completion:^(BOOL completion) {
                [view removeFromSuperview];
            }];
        }
        
        else if (view.tag == 2) {
            [UIView animateWithDuration:0.4 animations:^{
                view.alpha = 0.f;
                
            } completion:^(BOOL completion) {
                [view removeFromSuperview];
            }];
        }
    }
}

@end
