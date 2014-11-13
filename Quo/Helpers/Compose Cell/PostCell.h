//
//  PostCell.h
//  Quo
//
//  Created by Ryan Cohen on 11/12/14.
//  Copyright (c) 2014 Taptics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZTextView.h"

@interface PostCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UITextField *postTitleTextField;
@property (nonatomic, strong) IBOutlet UITextField *postUserTextField;
@property (nonatomic, strong) IBOutlet UILabel *postLineCountLabel;
@property (nonatomic, strong) IBOutlet SZTextView *postBodyTextView;

@end