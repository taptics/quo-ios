//
//  PostController.h
//  Quo
//
//  Created by Ryan Cohen on 11/13/14.
//  Copyright (c) 2014 Taptics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Quo.h"

@interface PostController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) QUOPost *post;

@end
