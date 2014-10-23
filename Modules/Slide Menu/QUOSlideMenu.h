//
//  QUOSlideMenu.h
//  Quo
//
//  Created by Ryan Cohen on 10/17/14.
//  Copyright (c) 2014 Taptics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QUOSlideMenu : UIView

@property (nonatomic, assign) BOOL isDisplayed;
@property (nonatomic, strong) UIView *activeView;

+ (instancetype)sharedInstance;
- (void)show;
- (void)dismiss;

@end
