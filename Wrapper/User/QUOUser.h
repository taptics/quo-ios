//
//  QuoUser.h
//  Quo
//
//  Created by Ryan Cohen on 8/30/14.
//  Copyright (c) 2014 Quo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QUOUser : NSObject

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *createdAt;
@property (nonatomic, strong) NSString *avatar;

@property (nonatomic, assign) BOOL loggedIn;
@property (nonatomic, strong) NSString *password;

/*!
 Initializes a new user object.
 @result A brand new user object.
 */
- (instancetype)initWithIdentifier:(NSString *)identifier
                             email:(NSString *)email
                              name:(NSString *)name
                          location:(NSString *)location
                         createdAt:(NSString *)createdAt
                            avatar:(NSString *)avatar;

/*!
 Returns the shared instance of the user object.
 @result Shared instance of QUOUser.
 */
+ (instancetype)currentUser;

/*!
 Clears the current user's info from memory.
 */
+ (void)logOut;

@end
