//
//  ComposeCell.h
//  Quo
//
//  Created by Ryan Cohen on 11/12/14.
//  Copyright (c) 2014 Taptics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZTextView.h"

@interface ComposeCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UITextField *postTitleTextField;
@property (nonatomic, strong) IBOutlet SZTextView *postBodyTextView;

@end
