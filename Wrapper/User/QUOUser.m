//
//  QuoUser.m
//  Quo
//
//  Created by Ryan Cohen on 8/30/14.
//  Copyright (c) 2014 Quo. All rights reserved.
//

#import "QUOUser.h"
#import "Quo.h"

@implementation QUOUser

#pragma Initializer

- (instancetype)initWithIdentifier:(NSString *)identifier
                             email:(NSString *)email
                              name:(NSString *)name
                          location:(NSString *)location
                         createdAt:(NSString *)createdAt
                            avatar:(NSString *)avatar {
    self = [super init];
    if (self) {
        self.identifier = identifier;
        self.email = email;
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

- (void)logOut {
    [QUOUser currentUser].identifier = @"";
    [QUOUser currentUser].email      = @"";
    [QUOUser currentUser].name       = @"";
    [QUOUser currentUser].password   = @"";
    [QUOUser currentUser].location   = @"";
    [QUOUser currentUser].createdAt  = @"";
    [QUOUser currentUser].avatar     = @"";
    [QUOUser currentUser].loggedIn   = NO;
    
    [[NSUserDefaults standardUserDefaults] setObject:[QUOUser currentUser].identifier forKey:@"CurrentUserIdentifier"];
    [[NSUserDefaults standardUserDefaults] setObject:[QUOUser currentUser].email      forKey:@"CurrentUserEmail"];
    [[NSUserDefaults standardUserDefaults] setObject:[QUOUser currentUser].name       forKey:@"CurrentUserName"];
    [[NSUserDefaults standardUserDefaults] setObject:[QUOUser currentUser].location   forKey:@"CurrentUserLocation"];
    [[NSUserDefaults standardUserDefaults] setObject:[QUOUser currentUser].createdAt  forKey:@"CurrentUserCreatedAt"];
    [[NSUserDefaults standardUserDefaults] setObject:[QUOUser currentUser].password   forKey:@"CurrentUserPassword"];
    [[NSUserDefaults standardUserDefaults]   setBool:[QUOUser currentUser].loggedIn   forKey:@"CurrentUserLoggedIn"];
}

@end
