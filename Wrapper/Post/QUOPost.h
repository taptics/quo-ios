//
//  QuoPost.h
//  Quo
//
//  Created by Ryan Cohen on 8/30/14.
//  Copyright (c) 2014 Quo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QUOPost : NSObject

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *lines;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *likes;
@property (nonatomic, strong) NSString *createdAt;

- (instancetype)initWithIdentifier:(NSString *)identifier
                          location:(NSString *)location
                             lines:(NSString *)lines
                              text:(NSString *)text
                             title:(NSString *)title
                            userId:(NSString *)userId
                             likes:(NSString *)likes
                         createdAt:(NSString *)createdAt;

@end
