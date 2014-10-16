//
//  QuoUser.m
//  Quo
//
//  Created by Ryan Cohen on 8/30/14.
//  Copyright (c) 2014 Quo. All rights reserved.
//

#import "QUOUser.h"

@implementation QUOUser

#pragma mark - Init

- (instancetype)initWithIdentifier:(NSString *)identifier
                          username:(NSString *)username
                              name:(NSString *)name
                          location:(NSString *)location
                         createdAt:(NSString *)createdAt
                            avatar:(NSString *)avatar {
    
    self = [super init];
    if (self) {
        self.identifier = identifier;
        self.username = username;
        self.name = name;
        self.location = location;
        self.createdAt = createdAt;
        self.avatar = avatar;
    }
    return self;
}

#pragma Singleton

+ (instancetype)currentUser {
    static QUOUser *user = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        user = [self new];
    });
    
    return user;
}

#pragma Functions

+ (void)logOut {
    [QUOUser currentUser].identifier = @"";
    [QUOUser currentUser].username   = @"";
    [QUOUser currentUser].password   = @"";
    [QUOUser currentUser].loggedIn   = NO;
    
    [[NSUserDefaults standardUserDefaults] setObject:[QUOUser currentUser].identifier forKey:@"CurrentUserIdentifier"];
    [[NSUserDefaults standardUserDefaults] setObject:[QUOUser currentUser].username   forKey:@"CurrentUserUsername"];
    [[NSUserDefaults standardUserDefaults] setObject:[QUOUser currentUser].password   forKey:@"CurrentUserPassword"];
    [[NSUserDefaults standardUserDefaults]   setBool:[QUOUser currentUser].loggedIn   forKey:@"CurrentUserLoggedIn"];
}

@end
