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

@property (nonatomic, assign) CGFloat labelFontSize;
@property (nonatomic, assign) CGRect labelFrame;
@property (nonatomic, assign) CGRect horizontalLineFrame;
@property (nonatomic, assign) CGRect verticalLineFrame;
@property (nonatomic, assign) CGRect confirmButtonFrame;
@property (nonatomic, assign) CGRect cancelButtonFrame;

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UIButton *confirmButton;
@property (nonatomic, strong) IBOutlet UIButton *cancelButton;

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
            _labelFontSize = 16.2f;
            _labelFrame = CGRectMake(10, 20, 300, 51);
            _cancelButtonFrame = CGRectMake(0, 82, 160, 71);
            _confirmButtonFrame = CGRectMake(160, 82, 160, 71);
            _horizontalLineFrame = CGRectMake(0, 87, 320, 1.5);
            _verticalLineFrame = CGRectMake(160, 87, 1.5, 71);
        }
        
        else if (IS_IPHONE_6) {
            _labelFontSize = 18.f;
            _labelFrame = CGRectMake(10, 15, 359, 71);
            _cancelButtonFrame = CGRectMake(0, 90, 188, 60);
            _confirmButtonFrame = CGRectMake(186, 90, 188, 60);
            _horizontalLineFrame = CGRectMake(0, 92, 375, 1.5);
            _verticalLineFrame = CGRectMake(186, 92, 1.5, 61);
        }
        
        else if (IS_IPHONE_6_PLUS) {
            _labelFontSize = 19.f;
            _labelFrame = CGRectMake(8, 22, 398, 51);
            _cancelButtonFrame = CGRectMake(0, 82, 208, 71);
            _confirmButtonFrame = CGRectMake(207, 82, 207, 71);
            _horizontalLineFrame = CGRectMake(0, 85, 414, 1.5);
            _verticalLineFrame = CGRectMake(207, 85, 1.5, 71);
        }
        
        _titleLabel = [[UILabel alloc] initWithFrame:_labelFrame];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:SKOLAR_FONT size:_labelFontSize];
        _titleLabel.textColor = DARK_TEXT_COLOR;
        [self addSubview:_titleLabel];
        
        _cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _cancelButton.frame = _cancelButtonFrame;
        _cancelButton.titleLabel.font = [UIFont fontWithName:LATO_FONT size:_labelFontSize];
        [_cancelButton setTitleColor:DARK_TEXT_COLOR forState:UIControlStateNormal];
        [_cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(dismissWithSender:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancelButton];
        
        _confirmButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _confirmButton.frame = _confirmButtonFrame;
        _confirmButton.titleLabel.font = [UIFont fontWithName:LATO_FONT size:_labelFontSize];
        [_confirmButton setTitleColor:DARK_TEXT_COLOR forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(dismissWithSender:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_confirmButton];
        
        UIView *horizontalLine = [[UIView alloc] initWithFrame:_horizontalLineFrame];
        horizontalLine.backgroundColor = LIGHT_GREY_COLOR;
        [self addSubview:horizontalLine];
        
        UIView *verticalLine = [[UIView alloc] initWithFrame:_verticalLineFrame];
        verticalLine.backgroundColor = LIGHT_GREY_COLOR;
        [self addSubview:verticalLine];
    }
    
    return self;
}

#pragma mark - Methods

- (void)show {
    if (_actionSheetType == QUOActionSheetTypeFlag) {
        _titleLabel.text = @"Would you like to flag this post for review?";
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
        self.frame = CGRectMake(0, _activeView.bounds.size.height - 150, CGRectGetWidth([UIScreen mainScreen].bounds), 223);
        
        [_activeView addSubview:self];
    }];
}

- (void)dismissWithSender:(UIButton *)sender {
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
    
    if ([sender.titleLabel.text isEqualToString:@"Flag"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"QUOFlagPostNotification" object:nil];
    }
    
    else if ([sender.titleLabel.text isEqualToString:@"Sign in"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"QUOSignInNotification" object:nil];
    }
}

@end
