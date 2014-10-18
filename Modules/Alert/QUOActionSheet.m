//
//  QUOActionSheet.m
//  Quo
//
//  Created by Ryan Cohen on 10/8/14.
//  Copyright (c) 2014 Taptics. All rights reserved.
//

#import "QUOActionSheet.h"
#import "QUOBufferView.h"
#import "Quo.h"

@interface QUOActionSheet ()

@property (nonatomic, assign) QUOActionSheetType actionSheetType;
@property (nonatomic, strong) UIView *activeView;

@property (nonatomic, assign) CGRect labelFrame;
@property (nonatomic, assign) CGRect horizontalLineFrame;
@property (nonatomic, assign) CGRect verticalLineFrame;
@property (nonatomic, assign) CGRect confirmButtonFrame;
@property (nonatomic, assign) CGRect cancelButtonFrame;

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
        self.frame = CGRectMake(0, _activeView.bounds.size.height + 220, CGRectGetWidth([UIScreen mainScreen].bounds), 223);
        self.backgroundColor = [UIColor whiteColor];
        
        if (IS_IPHONE_4 || IS_IPHONE_5) {
            self.labelFrame = CGRectMake(10, 49, 300, 51);
            self.cancelButtonFrame = CGRectMake(0, 152, 160, 71);
            self.confirmButtonFrame = CGRectMake(160, 152, 160, 71);
            self.horizontalLineFrame = CGRectMake(0, 157, 320, 1.5);
            self.verticalLineFrame = CGRectMake(160, 157, 1.5, 71);
        }
        else if (IS_IPHONE_6) {
            self.labelFrame = CGRectMake(10, 42, 359, 71);
            self.cancelButtonFrame = CGRectMake(0, 152, 188, 71);
            self.confirmButtonFrame = CGRectMake(186, 152, 188, 71);
            self.horizontalLineFrame = CGRectMake(0, 152, 375, 1.5);
            self.verticalLineFrame = CGRectMake(186, 152, 1.5, 71);
        }
        else if (IS_IPHONE_6_PLUS) {
            self.labelFrame = CGRectMake(8, 54, 398, 51);
            self.cancelButtonFrame = CGRectMake(0, 157, 208, 71);
            self.confirmButtonFrame = CGRectMake(207, 157, 207, 71);
            self.horizontalLineFrame = CGRectMake(0, 157, 414, 1.5);
            self.verticalLineFrame = CGRectMake(207, 157, 1.5, 71);
        }
        
        _titleLabel = [[UILabel alloc] initWithFrame:self.labelFrame];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:LATO_FONT size:16.f];
        _titleLabel.textColor = DARK_TEXT_COLOR;
        [self addSubview:_titleLabel];
        
        _cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _cancelButton.frame = self.cancelButtonFrame;
        _cancelButton.titleLabel.font = [UIFont fontWithName:LATO_FONT size:16.5f];
        [_cancelButton setTitleColor:DARK_TEXT_COLOR forState:UIControlStateNormal];
        [_cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(performAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancelButton];
        
        _confirmButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _confirmButton.frame = self.confirmButtonFrame;
        _confirmButton.titleLabel.font = [UIFont fontWithName:LATO_FONT size:16.5f];
        [_confirmButton setTitleColor:DARK_TEXT_COLOR forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(performAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_confirmButton];
        
        UIView *horizontalLine = [[UIView alloc] initWithFrame:self.horizontalLineFrame];
        horizontalLine.backgroundColor = LIGHT_GREY_COLOR;
        [self addSubview:horizontalLine];
        
        UIView *verticalLine = [[UIView alloc] initWithFrame:self.verticalLineFrame];
        verticalLine.backgroundColor = LIGHT_GREY_COLOR;
        [self addSubview:verticalLine];
    }
    return self;
}

#pragma mark - Methods

- (void)show {
    if (_actionSheetType == QUOActionSheetTypeFlag) {
        _titleLabel.text = @"Would you like to flag this post as inappropriate?";
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
    
    [UIView animateWithDuration:0.3 animations:^{
        dimView.alpha = 0.5f;
        
        self.frame = CGRectMake(0, _activeView.bounds.size.height - 220, CGRectGetWidth([UIScreen mainScreen].bounds), 223);
        [_activeView addSubview:self];
    }];
}

- (void)performAction:(UIButton *)sender {
    NSString *action = [NSString string];
    
    if ([sender.titleLabel.text isEqualToString:@"Flag"]) {
        action = @"Flag";
    }
    else if ([sender.titleLabel.text isEqualToString:@"Sign in"]) {
        action = @"Sign in";
    }
    
    for (UIView *view in _activeView.subviews) {
        if (view.tag == 1) {
            [UIView animateWithDuration:0.3 animations:^{
                self.frame = CGRectMake(0, view.bounds.size.height + 450, CGRectGetWidth([UIScreen mainScreen].bounds), 223);
                
            } completion:^(BOOL completion) {
                [view removeFromSuperview];
            }];
        }
        
        else if (view.tag == 2) {
            [UIView animateWithDuration:0.3 animations:^{
                view.alpha = 0.f;
                
            } completion:^(BOOL completion) {
                [view removeFromSuperview];
            }];
        }
    }
    
    if ([action isEqualToString:@"Flag"]) {
        // TODO: Flag post
        [[QUOBufferView sharedInstance] beginBuffer];
        
    } else {
        // TODO: Pop up sign in
        NSLog(@"Sign in");
    }
}

@end
