//
//  InfoCell.m
//  Quo
//
//  Created by Ryan Cohen on 11/14/14.
//  Copyright (c) 2014 Taptics. All rights reserved.
//

#import "InfoCell.h"

@implementation InfoCell

- (void)awakeFromNib {
    _descriptionLabel.lineSpacing = 5.f;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
