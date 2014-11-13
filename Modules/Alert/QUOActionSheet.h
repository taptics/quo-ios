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

typedef NS_ENUM(NSInteger, QUOActionSheetOption) {
    QUOActionSheetOptionFlag = 0,
    QUOActionSheetOptionSignIn = 1
};

@interface QUOActionSheet : UIView

- (instancetype)initWithType:(QUOActionSheetType)type forView:(UIView *)view;
- (void)show;
- (void)dismissWithSender:(UIButton *)sender;

@end