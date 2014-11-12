//
//  ComposeCell.m
//  Quo
//
//  Created by Ryan Cohen on 11/12/14.
//  Copyright (c) 2014 Taptics. All rights reserved.
//

#import "ComposeCell.h"
#import "Quo.h"

@implementation ComposeCell

- (void)awakeFromNib {
    _postTitleTextField.tintColor = DARK_TEXT_COLOR;
    _postTitleTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    _postTitleTextField.keyboardType = UIKeyboardTypeASCIICapable;
    _postBodyTextView.keyboardType = UIKeyboardTypeASCIICapable;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
