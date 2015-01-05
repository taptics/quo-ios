//
//  QuoPost.m
//  Quo
//
//  Created by Ryan Cohen on 8/30/14.
//  Copyright (c) 2014 Quo. All rights reserved.
//

#import "QUOPost.h"

@implementation QUOPost

#pragma mark - Init

- (instancetype)initWithIdentifier:(NSString *)identifier
                          location:(NSString *)location
                             lines:(NSString *)lines
                              text:(NSString *)text
                             title:(NSString *)title
                            userId:(NSString *)userId
                             likes:(NSString *)likes
                         createdAt:(NSString *)createdAt {
    
    self = [super init];
    if (self) {
        _identifier = identifier;
        _location = location;
        _text = text;
        _title = title;
        _lines = [NSString stringWithFormat:@"%@", lines];
        _userId = userId;
        _likes = likes;
        _createdAt = createdAt;
    }
    
    return self;
}


@end
