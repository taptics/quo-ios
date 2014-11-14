//
//  InfoCell.h
//  Quo
//
//  Created by Ryan Cohen on 11/14/14.
//  Copyright (c) 2014 Taptics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTAttributedLabel.h"

@interface InfoCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet TTTAttributedLabel *descriptionLabel;

@end
