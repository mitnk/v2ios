//
//  YippeeWeibo.m
//  HelloWorld
//
//  Created by mitnk on 7/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "YippeeWeibo.h"

#define kWBSDKDemoAppKey @"1025844814"
#define kWBSDKDemoAppSecret @"aefa217eb23928b06ca163ba9b8b12be"

#ifndef kWBSDKDemoAppKey
#error
#endif

#ifndef kWBSDKDemoAppSecret
#error
#endif

#define kWBAlertViewLogOutTag 100
#define kWBAlertViewLogInTag  101

@implementation YippeeWeibo

@synthesize weiBoEngine;

- (id)init
{
    if ( self = [super init] )
    {
        WBEngine *engine = [[WBEngine alloc] initWithAppKey:kWBSDKDemoAppKey appSecret:kWBSDKDemoAppSecret];
        [engine setDelegate:self];
        [engine setIsUserExclusive:NO];
        self.weiBoEngine = engine;
        [engine release];
    }
    
    return self;
}

- (void)setAccessToken:(NSString *)accessToken userID:(NSString *)userID expireTime:(double) expireTime viewcontroller:(id)vc
{
    [self.weiBoEngine setAccessToken:accessToken];
    [self.weiBoEngine setUserID:userID];
    [self.weiBoEngine setExpireTime:expireTime];
}

- (BOOL) tweet:(NSString *) text image:(UIImage *)image
{
    // [self.weiBoEngine logIn];
    
    [self.weiBoEngine sendWeiBoWithText:text image:nil];
    return  YES;
}

- (void)login
{
    [self.weiBoEngine logIn];
}

- (void)engineDidLogIn:(WBEngine *)engine
{
    NSString *accessToken = engine.accessToken;
    NSString *userID = engine.userID;
    NSInteger expireTime = engine.expireTime;
    NSLog(@"\ndidlogin: %@ %@ %d\n", accessToken, userID, expireTime);
}

@end
