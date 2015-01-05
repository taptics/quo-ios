//
//  ComposeController.h
//  Quo
//
//  Created by Ryan Cohen on 11/11/14.
//  Copyright (c) 2014 Taptics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostCell.h"
#import "Quo.h"

@interface ComposeController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, assign) BOOL fromDraft;
@property (nonatomic, strong) NSDictionary *draft;

@end
