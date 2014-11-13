//
//  HomePostCell.h
//  Quo
//
//  Created by Ryan Cohen on 10/8/14.
//  Copyright (c) 2014 Taptics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTAttributedLabel.h"

@interface HomePostCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *postTitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *postAuthorLabel;
@property (nonatomic, strong) IBOutlet UILabel *postLinesLabel;
@property (nonatomic, strong) IBOutlet TTTAttributedLabel *postPreviewLabel;

@end
