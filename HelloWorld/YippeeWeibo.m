//
//  YippeeWeibo.m
//  HelloWorld
//
//  Created by mitnk on 7/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "YippeeWeibo.h"

// #define kWBSDKDemoAppKey @""
// #define kWBSDKDemoAppSecret @""

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

- (void) dealloc
{
    [self.weiBoEngine setDelegate:nil];
    [super dealloc];
}

- (void)setAccessToken:(NSString *)accessToken userID:(NSString *)userID
{
    [self.weiBoEngine setAccessToken:accessToken];
    [self.weiBoEngine setUserID:userID];
    NSTimeInterval expireTime = [[NSDate date] timeIntervalSince1970] + 31536000; // Add 365 days
    [self.weiBoEngine setExpireTime:expireTime];
}

- (BOOL) tweet:(NSString *)text image:(UIImage *)image
{
    if ([self.weiBoEngine isLoggedIn])
    {
        [self.weiBoEngine sendWeiBoWithText:text image:image];
    }
    else {
        [self.weiBoEngine logIn];
    }
    return  YES;
}

- (void)OauthLogin
{
    [self.weiBoEngine logIn];
}

- (void)engineDidLogIn:(WBEngine *)engine
{
    NSString *accessToken = engine.accessToken;
    NSString *userID = engine.userID;
    NSTimeInterval expireTime = [[NSDate date] timeIntervalSince1970] + 31536000; // Add 365 days
    NSLog(@"\nLogin Ok. accessToken: %@ userID: %@ %f\n", accessToken, userID, expireTime);
}

- (BOOL)getAccessInfoFromServer
{
    // ASIRequest from ocean server
    // Then [self setAccessToken:<#(NSString *)#> userID:<#(NSString *)#> expireTime:<#(double)#> viewcontroller:<#(id)#>
    return YES;
}

- (void)engine:(WBEngine *)engine requestDidSucceedWithResult:(id)result
{
    NSLog(@"You Said: %@\n", [result objectForKey:@"text"]);
}

- (void)engine:(WBEngine *)engine requestDidFailWithError:(NSError *)error
{
    NSLog(@"%@", [error localizedDescription]);
}

@end
