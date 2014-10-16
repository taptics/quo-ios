//
//  QuoPost.m
//  Quo
//
//  Created by Ryan Cohen on 8/30/14.
//  Copyright (c) 2014 Quo. All rights reserved.
//

#import "QUOPost.h"

@implementation QUOPost

- (instancetype)initWithIdentifier:(NSString *)identifier
                          location:(NSString *)location
                              text:(NSString *)text
                             title:(NSString *)title
                            userId:(NSString *)userId
                             likes:(NSString *)likes
                         createdAt:(NSString *)createdAt {
    
    self = [super init];
    if (self) {
        self.identifier = identifier;
        self.location = location;
        self.text = text;
        self.title = title;
        self.userId = userId;
        self.likes = likes;
        self.createdAt = createdAt;
    }
    return self;
}

@end
