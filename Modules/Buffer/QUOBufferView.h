//
//  QUOBufferView.h
//  Quo
//
//  Created by Ryan Cohen on 10/15/14.
//  Copyright (c) 2014 Taptics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QUOBufferView : UIView

- (instancetype)initWithView:(UIView *)view;
- (void)beginBuffer;
- (void)endBuffer;

@end
