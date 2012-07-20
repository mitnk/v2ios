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

- (void)setAccessToken:(NSString *)accessToken userID:(NSString *)userID expireTime:(double) expireTime viewcontroller:(id)vc;
- (BOOL)tweet:(NSString *)text image:(UIImage *)image;
- (void)login;
@end
