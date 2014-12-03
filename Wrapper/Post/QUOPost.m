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
        _lines = lines;
        _userId = userId;
        _likes = likes;
        _createdAt = createdAt;
    }
    
    return self;
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        _title = [decoder decodeObjectForKey:@"title"];
        _text = [decoder decodeObjectForKey:@"text"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_title forKey:@"title"];
    [coder encodeObject:_text forKey:@"text"];
}

@end
