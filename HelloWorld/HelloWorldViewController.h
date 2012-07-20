//
//  HelloWorldViewController.h
//  HelloWorld
//
//  Created by mitnk on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBEngine.h"
#import "WBSendView.h"
#import "WBLogInAlertView.h"

@interface HelloWorldViewController : UIViewController <UITextFieldDelegate, WBEngineDelegate, UIAlertViewDelegate, WBLogInAlertViewDelegate, WBSendViewDelegate>
{
    WBEngine *weiBoEngine;
    UIActivityIndicatorView *indicatorView;
}

@property (assign, nonatomic) IBOutlet UILabel *label;
@property (assign, nonatomic) IBOutlet UITextField *textField;
@property (copy, nonatomic) NSString *userName;
@property (nonatomic, retain) WBEngine *weiBoEngine;

- (IBAction)changeGreeting:(id)sender;
- (IBAction)getToken:(id)sender;
- (id)initWithAppKey:(NSString *)theAppKey appSecret:(NSString *)theAppSecret;
@end
