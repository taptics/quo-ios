//
//  DraftsController.h
//  Quo
//
//  Created by Ryan Cohen on 11/18/14.
//  Copyright (c) 2014 Taptics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DraftsController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *drafts;

@end
