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
    self.frame = _activeView.frame;
    self.backgroundColor = [UIColor blackColor];
    self.alpha = 0.f;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.5f;
        
        UIWindow *activeWindow = [UIApplication sharedApplication].keyWindow;
        [activeWindow addSubview:self];
    }];
}

- (void)endBuffer {
    for (UIView *view in _activeView.subviews) {
        NSLog(@"Tag: %lu", (unsigned long)view.tag);
        
        if (view.tag == 1) {
            [view removeFromSuperview];
        }
    }
}

@end
