//
//  Quo.m
//  Quo
//
//  Created by Ryan Cohen on 8/30/14.
//  Copyright (c) 2014 Quo. All rights reserved.
//

#import "Quo.h"
#import "AFNetworking.h"
#import "MD5.h"

static NSString *QUO_GET_ALL_USERS      = @"http://quoapp.herokuapp.com/api/user/all";
static NSString *QUO_GET_USER_BY_ID     = @"http://quoapp.herokuapp.com/api/user/get/%@";
static NSString *QUO_CREATE_USER        = @"http://quoapp.herokuapp.com/api/user/create";
static NSString *QUO_AUTH_USER          = @"http://quoapp.herokuapp.com/api/user/authenticate";

static NSString *QUO_GET_ALL_POSTS      = @"http://quoapp.herokuapp.com/api/post/all";
static NSString *QUO_GET_POSTS_BY_USER  = @"http://quoapp.herokuapp.com/api/post/all/%@";
static NSString *QUO_GET_POST_BY_ID     = @"http://quoapp.herokuapp.com/api/post/get/%@";
static NSString *QUO_CREATE_POST        = @"http://quoapp.herokuapp.com/api/post/create";
static NSString *QUO_LIKE_POST          = @"http://quoapp.herokuapp.com/api/post/like/%@";
static NSString *QUO_FLAG_POST          = @"http://quoapp.herokuapp.com/api/post/flag/%@";

@implementation Quo

#pragma mark - Singleton

+ (instancetype)sharedClient {
    static Quo *quo = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        quo = [self new];
    });
    
    return quo;
}

#pragma mark - Users

- (void)getAllUsersWithBlock:(QUOGetAllObjects)block {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:[Quo sharedClient].apiKey forHTTPHeaderField:@"Authorization-Token"];
    
    [manager GET:QUO_GET_ALL_USERS parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *users = [NSMutableArray array];
        
        for (id object in responseObject[@"users"]) {
            QUOUser *user = [[QUOUser alloc] initWithIdentifier:object[@"id"]
                                                       email:object[@"username"]
                                                           name:object[@"name"]
                                                       location:object[@"location"]
                                                      createdAt:object[@"createdAt"]
                                                         avatar:object[@"avatarURL"]];
            [users addObject:user];
        }
        
        block(users);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)getUserWithIdentifier:(NSString *)identifier block:(QUOGetUser)block {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:[Quo sharedClient].apiKey forHTTPHeaderField:@"Authorization-Token"];
    
    NSString *url = [NSString stringWithFormat:QUO_GET_USER_BY_ID, identifier];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        QUOUser *user = [[QUOUser alloc] initWithIdentifier:responseObject[@"user"][@"id"]
                                                   email:responseObject[@"user"][@"username"]
                                                       name:responseObject[@"user"][@"name"]
                                                   location:responseObject[@"user"][@"location"]
                                                  createdAt:responseObject[@"user"][@"createdAt"]
                                                     avatar:responseObject[@"user"][@"avatarURL"]];
        
        block(user);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)createUserWithEmail:(NSString *)email
                      password:(NSString *)password
                          name:(NSString *)name
                      location:(NSString *)location
                         block:(QUOSuccessMessage)block {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:[Quo sharedClient].apiKey forHTTPHeaderField:@"Authorization-Token"];
    
    NSDictionary *params = @{
                             @"username" : email,
                             @"password" : [password MD5String],
                             @"name"     : name,
                             @"location" : location
                            };
    
    NSString *url = [NSString stringWithFormat:QUO_CREATE_USER, [Quo sharedClient].apiKey];
    
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"success"] boolValue] == NO) {
            block(NO, responseObject[@"error"]);
        } else {
            [self authenticateUserWithEmail:email password:password block:^(BOOL success) {
                if (success) {
                    [[NSUserDefaults standardUserDefaults] setObject:[QUOUser currentUser].identifier forKey:@"CurrentUserIdentifier"];
                    [[NSUserDefaults standardUserDefaults] setObject:[QUOUser currentUser].email      forKey:@"CurrentUserEmail"];
                    [[NSUserDefaults standardUserDefaults] setObject:[QUOUser currentUser].name       forKey:@"CurrentUserName"];
                    [[NSUserDefaults standardUserDefaults] setObject:[QUOUser currentUser].location   forKey:@"CurrentUserLocation"];
                    [[NSUserDefaults standardUserDefaults] setObject:[QUOUser currentUser].createdAt  forKey:@"CurrentUserCreatedAt"];
                    [[NSUserDefaults standardUserDefaults] setObject:[QUOUser currentUser].password   forKey:@"CurrentUserPassword"];
                    [[NSUserDefaults standardUserDefaults]   setBool:[QUOUser currentUser].loggedIn   forKey:@"CurrentUserLoggedIn"];
                    
                    block(YES, @"");
                } else {
                    NSLog(@"Uh oh, error logging in after sign up.");
                }
            }];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)authenticateUserWithEmail:(NSString *)email
                            password:(NSString *)password
                               block:(QUOSuccess)block {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:[Quo sharedClient].apiKey forHTTPHeaderField:@"Authorization-Token"];
    
    NSDictionary *params = @{
                             @"username" : email,
                             @"password" : [password MD5String],
                            };
    
    [manager POST:QUO_AUTH_USER parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"success"] boolValue] == NO) {
            block(NO);
        } else {
            [[Quo sharedClient] getUserWithIdentifier:responseObject[@"userId"] block:^(QUOUser *user) {
                [QUOUser currentUser].identifier = user.identifier;
                [QUOUser currentUser].email      = user.email;
                [QUOUser currentUser].name       = user.name;
                [QUOUser currentUser].password   = password;
                [QUOUser currentUser].loggedIn   = YES;
                
                [[NSUserDefaults standardUserDefaults] setObject:[QUOUser currentUser].identifier forKey:@"CurrentUserIdentifier"];
                [[NSUserDefaults standardUserDefaults] setObject:[QUOUser currentUser].email      forKey:@"CurrentUserEmail"];
                [[NSUserDefaults standardUserDefaults] setObject:[QUOUser currentUser].name       forKey:@"CurrentUserName"];
                [[NSUserDefaults standardUserDefaults] setObject:[QUOUser currentUser].password   forKey:@"CurrentUserPassword"];
                [[NSUserDefaults standardUserDefaults]   setBool:[QUOUser currentUser].loggedIn   forKey:@"CurrentUserLoggedIn"];
            }];
            
            block(YES);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

#pragma mark - Posts

- (void)getAllPostsWithBlock:(QUOGetAllObjects)block {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:[Quo sharedClient].apiKey forHTTPHeaderField:@"Authorization-Token"];
    
    [manager GET:QUO_GET_ALL_POSTS parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *posts = [NSMutableArray array];
        
        for (id object in responseObject[@"posts"]) {
            QUOPost *post = [[QUOPost alloc] initWithIdentifier:object[@"id"]
                                              location:object[@"location"]
                                                  text:object[@"text"]
                                                 title:object[@"title"]
                                                userId:object[@"userId"]
                                                 likes:object[@"likes"]
                                             createdAt:object[@"createdAt"]];
            [posts addObject:post];
        }
        
        block(posts);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error.localizedDescription);
    }];
}

- (void)getAllPostsFromUser:(NSString *)userId block:(QUOGetAllObjects)block {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:[Quo sharedClient].apiKey forHTTPHeaderField:@"Authorization-Token"];
    
    NSString *url = [NSString stringWithFormat:QUO_GET_POSTS_BY_USER, userId];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *posts = [NSMutableArray array];
        
        for (id object in responseObject[@"posts"]) {
            [self getUserWithIdentifier:object[@"userId"] block:^(QUOUser *user) {
                QUOPost *post = [[QUOPost alloc] initWithIdentifier:object[@"id"]
                                                           location:object[@"location"]
                                                               text:object[@"text"]
                                                              title:object[@"title"]
                                                             userId:object[@"userId"]
                                                              likes:object[@"likes"]
                                                          createdAt:object[@"createdAt"]];
                [posts addObject:post];
            }];
        }
        
        block(posts);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)getPostWithIdentifier:(NSString *)identifier block:(QUOGetPost)block {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:[Quo sharedClient].apiKey forHTTPHeaderField:@"Authorization-Token"];
    
    NSString *url = [NSString stringWithFormat:QUO_GET_POST_BY_ID, identifier];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        QUOPost *post = [[QUOPost alloc] initWithIdentifier:responseObject[@"post"][@"id"]
                                                   location:responseObject[@"post"][@"location"]
                                                       text:responseObject[@"post"][@"text"]
                                                      title:responseObject[@"post"][@"title"]
                                                     userId:responseObject[@"post"][@"userId"]
                                                      likes:responseObject[@"post"][@"likes"]
                                                  createdAt:responseObject[@"post"][@"createdAt"]];
        
        block(post);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)createPostWithTitle:(NSString *)title
                       text:(NSString *)text
                     userId:(NSString *)userId
                   location:(NSString *)location
                      block:(QUOSuccess)block {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:[Quo sharedClient].apiKey forHTTPHeaderField:@"Authorization-Token"];
    
    NSDictionary *params = @{
                             @"title"    : title,
                             @"text"     : text,
                             @"userId"   : userId,
                             @"location" : location
                            };
    
    [manager POST:QUO_CREATE_POST parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"success"] boolValue] == NO) {
            block(NO);
        } else {
            block(YES);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)likePostWithIdentifier:(NSString *)identifier
                        userId:(NSString *)userId
                         block:(QUOSuccess)block {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:[Quo sharedClient].apiKey forHTTPHeaderField:@"Authorization-Token"];
    
    NSDictionary *params = @{ @"userId" : userId };
    
    NSString *url = [NSString stringWithFormat:QUO_LIKE_POST, identifier];
    
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"success"] boolValue] == NO) {
            block(NO);
        } else {
            block(YES);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)flagPostWithIdentifier:(NSString *)identifier block:(QUOSuccess)block {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:[Quo sharedClient].apiKey forHTTPHeaderField:@"Authorization-Token"];
    
    NSDictionary *params = @{ @"id" : identifier };
    
    NSString *url = [NSString stringWithFormat:QUO_FLAG_POST, identifier];
    
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"success"] boolValue] == NO) {
            block(NO);
        } else {
            block(YES);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
