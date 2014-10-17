//
//  QUOBufferView.h
//  Quo
//
//  Created by Ryan Cohen on 10/15/14.
//  Copyright (c) 2014 Taptics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QUOBufferView : UIView

@property (nonatomic, strong) UIView *activeView;

+ (instancetype)sharedInstance;
- (void)beginBuffer;
- (void)endBuffer;

@end
