//
//  QUOSlideMenu.m
//  Quo
//
//  Created by Ryan Cohen on 10/17/14.
//  Copyright (c) 2014 Taptics. All rights reserved.
//

#import "QUOSlideMenu.h"
#import "Quo.h"

@interface QUOSlideMenu ()

@property (nonatomic, strong) UIView *activeView;

@property (nonatomic, assign) CGRect aboutButtonFrame;
@property (nonatomic, assign) CGRect helpButtonFrame;
@property (nonatomic, assign) CGRect signOutButtonFrame;
@property (nonatomic, assign) CGRect seperatorFrame;
@property (nonatomic, assign) CGRect secondSeperatorFrame;

@property (nonatomic, strong) UIButton *aboutButton;
@property (nonatomic, strong) UIButton *helpButton;
@property (nonatomic, strong) UIButton *signOutButton;

- (void)performAction:(UIButton *)sender;

@end

@implementation QUOSlideMenu

- (instancetype)initWithView:(UIView *)view {
    self = [super init];
    if (self) {
        _activeView = view;
        
        self.tag = 1;
        self.backgroundColor = [UIColor whiteColor];
        
        if (IS_IPHONE_4) {
            self.frame = CGRectMake(0, _activeView.bounds.size.height - 650, CGRectGetWidth([UIScreen mainScreen].bounds), 230);
            _aboutButtonFrame =  CGRectMake(10, 62, 300, 21);
            _helpButtonFrame = CGRectMake(10, 122, 300, 21);
            _signOutButtonFrame = CGRectMake(10, 182, 300, 21);
            _seperatorFrame = CGRectMake(17, 100, 285, 1);
            _secondSeperatorFrame = CGRectMake(17, 160, 285, 1);
        }
        
        else if (IS_IPHONE_5) {
            self.frame = CGRectMake(0, _activeView.bounds.size.height - 700, CGRectGetWidth([UIScreen mainScreen].bounds), 230);
            _aboutButtonFrame =  CGRectMake(10, 62, 300, 21);
            _helpButtonFrame = CGRectMake(10, 122, 300, 21);
            _signOutButtonFrame = CGRectMake(10, 182, 300, 21);
            _seperatorFrame = CGRectMake(17, 100, 285, 1);
            _secondSeperatorFrame = CGRectMake(17, 160, 285, 1);
        }
        
        else if (IS_IPHONE_6) {
            self.frame = CGRectMake(0, _activeView.bounds.size.height - 800, CGRectGetWidth([UIScreen mainScreen].bounds), 230);
            _aboutButtonFrame = CGRectMake(17, 62, 340, 21);
            _helpButtonFrame = CGRectMake(17, 122, 340, 21);
            _signOutButtonFrame = CGRectMake(17, 182, 340, 21);
            _seperatorFrame = CGRectMake(17, 100, 340, 1);
            _secondSeperatorFrame = CGRectMake(17, 160, 340, 1);
        }
        
        else if (IS_IPHONE_6_PLUS) {
            self.frame = CGRectMake(0, _activeView.bounds.size.height - 800, CGRectGetWidth([UIScreen mainScreen].bounds), 230);
        }
        
        _aboutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _aboutButton.frame = _aboutButtonFrame;
        _aboutButton.titleLabel.font = [UIFont fontWithName:LATO_FONT size:16.5f];
        [_aboutButton setTitleColor:DARK_TEXT_COLOR forState:UIControlStateNormal];
        [_aboutButton setTitle:@"About" forState:UIControlStateNormal];
        [_aboutButton addTarget:self action:@selector(performAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_aboutButton];
        
        _helpButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _helpButton.frame = _helpButtonFrame;
        _helpButton.titleLabel.font = [UIFont fontWithName:LATO_FONT size:16.5f];
        [_helpButton setTitleColor:DARK_TEXT_COLOR forState:UIControlStateNormal];
        [_helpButton setTitle:@"Help" forState:UIControlStateNormal];
        [_helpButton addTarget:self action:@selector(performAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_helpButton];
        
        _signOutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _signOutButton.frame = _signOutButtonFrame;
        _signOutButton.titleLabel.font = [UIFont fontWithName:LATO_FONT size:16.5f];
        [_signOutButton setTitleColor:DARK_TEXT_COLOR forState:UIControlStateNormal];
        [_signOutButton setTitle:@"Sign out" forState:UIControlStateNormal];
        [_signOutButton addTarget:self action:@selector(performAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_signOutButton];
        
        UIView *seperator = [[UIView alloc] initWithFrame:_seperatorFrame];
        seperator.frame = _seperatorFrame;
        seperator.backgroundColor = LIGHT_GREY_COLOR;
        [self addSubview:seperator];
        
        UIView *secondSeperator = [[UIView alloc] initWithFrame:_secondSeperatorFrame];
        secondSeperator.frame = _secondSeperatorFrame;
        secondSeperator.backgroundColor = LIGHT_GREY_COLOR;
        [self addSubview:secondSeperator];
    }
    return self;
}

#pragma mark - Methods

- (void)show {
    UIView *dimView = [[UIView alloc] initWithFrame:_activeView.frame];
    dimView.tag = 2;
    dimView.alpha = 0.f;
    dimView.backgroundColor = [UIColor blackColor];
    
    [_activeView addSubview:dimView];
    
    [UIView animateWithDuration:0.3 animations:^{
        dimView.alpha = 0.5f;
        
        if (IS_IPHONE_4) {
            self.frame = CGRectMake(0, _activeView.bounds.size.height - 457, CGRectGetWidth([UIScreen mainScreen].bounds), 223);
        }
        
        else if (IS_IPHONE_5) {
            self.frame = CGRectMake(0, _activeView.bounds.size.height - 547, CGRectGetWidth([UIScreen mainScreen].bounds), 223);
        }
        
        else if (IS_IPHONE_6) {
            self.frame = CGRectMake(0, _activeView.bounds.size.height - 647, CGRectGetWidth([UIScreen mainScreen].bounds), 223);
        }
        
        else if (IS_IPHONE_6_PLUS) {
            self.frame = CGRectMake(0, _activeView.bounds.size.height - 640, CGRectGetWidth([UIScreen mainScreen].bounds), 223);
        }
    
        [_activeView addSubview:self];
    }];
}

- (void)performAction:(UIButton *)sender {
    NSLog(@"Sender: %@", sender.titleLabel.text);
    
    for (UIView *view in _activeView.subviews) {
        if (view.tag == 1) {
            [UIView animateWithDuration:0.3 animations:^{
                self.frame = CGRectMake(0, view.bounds.size.height - 430, CGRectGetWidth([UIScreen mainScreen].bounds), 223);
                
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
}

@end
