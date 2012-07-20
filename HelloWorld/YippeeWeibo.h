//
//  YippeeWeibo.h
//  HelloWorld
//
//  Created by mitnk on 7/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBEngine.h"

@interface YippeeWeibo : NSObject <WBEngineDelegate>

@property (nonatomic, retain) WBEngine *weiBoEngine;

- (void)setAccessToken:(NSString *)accessToken userID:(NSString *)userID;
- (BOOL)tweet:(NSString *)text image:(UIImage *)image;

// Login with Sina Weibo Oauth
- (void)OauthLogin;

// Get Access Info from Ocean server, then it will set Access token info.
- (BOOL)getAccessInfoFromServer;
@end
