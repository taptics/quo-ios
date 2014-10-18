//
//  QUOBufferView.m
//  Quo
//
//  Created by Ryan Cohen on 10/15/14.
//  Copyright (c) 2014 Taptics. All rights reserved.
//

#import "QUOBufferView.h"

@implementation QUOBufferView

+ (instancetype)sharedInstance {
    static QUOBufferView *buffer = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        buffer = [self new];
    });
    
    return buffer;
}

- (void)beginBuffer {
    self.tag = 1;
    self.frame = _activeView.frame;
    self.alpha = 0.f;
    self.backgroundColor = [UIColor blackColor];
    
    [_activeView addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.5f;
    }];
}

- (void)endBuffer {
    for (UIView *view in _activeView.subviews) {
        if (view.tag == 1) {
            [UIView animateWithDuration:0.3 animations:^{
                self.alpha = 0.f;
                
            } completion:^(BOOL completion) {
                [view removeFromSuperview];
            }];
        }
    }
}

@end
