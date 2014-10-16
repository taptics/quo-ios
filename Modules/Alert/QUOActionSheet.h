//
//  QUOActionSheet.h
//  Quo
//
//  Created by Ryan Cohen on 10/8/14.
//  Copyright (c) 2014 Taptics. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, QUOActionSheetType) {
    QUOActionSheetTypeFlag = 0,
    QUOActionSheetTypeSignIn = 1
};

@interface QUOActionSheet : UIView

/*
 * Initializer
 */
- (instancetype)initWithType:(QUOActionSheetType)type forView:(UIView *)view;

/*
 * Show
 */
- (void)show;

@end
