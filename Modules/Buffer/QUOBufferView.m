//
//  QUOBufferView.m
//  Quo
//
//  Created by Ryan Cohen on 10/15/14.
//  Copyright (c) 2014 Taptics. All rights reserved.
//

#import "QUOBufferView.h"

@interface QUOBufferView ()

@property (nonatomic, strong) UIView *activeView;

@end

@implementation QUOBufferView

- (instancetype)initWithView:(UIView *)view {
    self = [super init];
    if (self) {
        self.tag = 1;
        _activeView = view;
    }
    return self;
}

- (void)beginBuffer {
    self.frame = _activeView.frame;
    self.backgroundColor = [UIColor blackColor];
    self.alpha = 0.f;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.5f;
        
        [_activeView addSubview:self];
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
