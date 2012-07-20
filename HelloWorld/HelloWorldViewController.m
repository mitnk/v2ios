//
//  HelloWorldViewController.m
//  HelloWorld
//
//  Created by mitnk on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HelloWorldViewController.h"
#import "ASIHTTPRequest.h"
#import "SBJSON.h"
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


@interface HelloWorldViewController ()

@end

@implementation HelloWorldViewController
@synthesize label;
@synthesize textField;
@synthesize userName = _userName;
@synthesize weiBoEngine;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setTextField:nil];
    [self setLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}



- (IBAction)changeGreeting:(id)sender {
    self.userName = self.textField.text;
    NSString *nameString = self.userName;
    if ([nameString length] == 0) {
        nameString = @"World";
    }
    nameString = [nameString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.label.text = nameString;
    
    NSString *api_url = [[NSString alloc] initWithFormat:@"http://translate.google.com/translate_a/t?text=%@&client=it&hl=en&ie=UTF-8&oe=UTF-8&sl=en&tl=zh-CN", nameString];

    NSURL *url = [NSURL URLWithString:api_url];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSString *response = [request responseString];
        NSDictionary *responseDict = [response JSONValue];
        self.label.text = [[[responseDict valueForKey:@"sentences"] objectAtIndex:0] valueForKey:@"translit"];
    }
    else {
        self.label.text = @"Error!";
    }
    
    printf("%s %s %f\n", [weiBoEngine.userID UTF8String], [weiBoEngine.accessToken UTF8String], weiBoEngine.expireTime);
    
    YippeeWeibo *weibo = [[YippeeWeibo alloc] init];
    [weibo setAccessToken:@"2.004OagzCGG27HB291b87384c0Z9D29" userID:@"2743771211"  expireTime:1342777900 viewcontroller:self];
    [weibo tweet:self.label.text image:nil];
    [weibo release];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.textField) {
        [theTextField resignFirstResponder];
    }
    return YES;
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{

}

- (void)engineDidLogIn:(WBEngine *)engine
{
    [indicatorView stopAnimating];
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil 
                                                       message:@"登录成功！" 
                                                      delegate:self
                                             cancelButtonTitle:@"确定" 
                                             otherButtonTitles:nil];
    [alertView setTag:kWBAlertViewLogInTag];
    [alertView show];
    [alertView release];
}

- (void)logInAlertView:(WBLogInAlertView *)alertView logInWithUserID:(NSString *)userID password:(NSString *)password
{
    [weiBoEngine logInUsingUserID:userID password:password];
    
    [indicatorView startAnimating];
}

- (IBAction)getToken:(id)sender {
    YippeeWeibo *weibo = [[YippeeWeibo alloc] init];
    [weibo login];
}

@end
