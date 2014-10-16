//
//  QUOConstants.h
//  Quo
//
//  Created by Ryan Cohen on 10/15/14.
//  Copyright (c) 2014 Taptics. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LATO_FONT @"Lato"

#define DARK_TEXT_COLOR  [UIColor colorWithRed:79/255.f green:79/255.f   blue:79/255.f  alpha:1.f]
#define LIGHT_GREY_COLOR [UIColor colorWithRed:225/255.f green:225/255.f blue:225/255.f alpha:1.f]

#define IS_IPHONE_4 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)480) < DBL_EPSILON)
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)568) < DBL_EPSILON)
#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)667) < DBL_EPSILON)
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)736) < DBL_EPSILON)

@interface QUOConstants : NSObject

@end
