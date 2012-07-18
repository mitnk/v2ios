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

@interface HelloWorldViewController ()

@end

@implementation HelloWorldViewController
@synthesize label;
@synthesize textField;
@synthesize userName = _userName;

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
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.textField) {
        [theTextField resignFirstResponder];
    }
    return YES;
}
@end
