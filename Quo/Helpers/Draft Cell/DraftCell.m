//
//  DraftCell.m
//  Quo
//
//  Created by Ryan Cohen on 12/3/14.
//  Copyright (c) 2014 Taptics. All rights reserved.
//

#import "DraftCell.h"

@implementation DraftCell

- (void)awakeFromNib {
    UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height + 13, CGRectGetWidth([UIScreen mainScreen].bounds), 1)];
    separator.backgroundColor = [UIColor colorWithRed:225/255.f green:225/255.f blue:225/255.f alpha:1.f];
    [self.contentView addSubview:separator];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
