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
#import "YippeeWeibo.h"

@interface HelloWorldViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, retain) YippeeWeibo *weibo;
@property (assign, nonatomic) IBOutlet UILabel *label;
@property (assign, nonatomic) IBOutlet UITextField *textField;
@property (copy, nonatomic) NSString *userName;

- (IBAction)changeGreeting:(id)sender;
- (IBAction)getToken:(id)sender;
@end
