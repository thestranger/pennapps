//
//  PreSignInView.m
//  ClientApp
//
//  Created by Joseph May on 2/16/14.
//  Copyright (c) 2014 pennApps. All rights reserved.
//

#import "PreSignInView.h"
#import <AFNetworking/AFNetworking.h>
#import "Resources.h"
#import "StatusView.h"

@implementation PreSignInView

@synthesize userText, pwText, confirmPwText, submitButton, loginButton, fNameText, lNameText, client;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.pwText.secureTextEntry = YES;
    self.confirmPwText.secureTextEntry = YES;
}



- (IBAction)submitButtonPressed:(id)sender {
    NSString *s1 = [NSString stringWithFormat:@"%@",self.pwText.text];
    NSString *s2 = [NSString stringWithFormat:@"%@",self.confirmPwText.text];
    
    if ([self.fNameText.text length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"First name required." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
            [alert show];
    }   else if ([self.lNameText.text length] == 0) {
        UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Last name required." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
        [alert2 show];
    }   else if ([self.userText.text length] == 0) {
        UIAlertView *alert3 = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Username required." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
        [alert3 show];
    }      else if ([self.pwText.text length] == 0) {
        UIAlertView *alert5 = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Password required." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
        [alert5 show];
    }   else if ([self.confirmPwText.text length] == 0) {
        UIAlertView *alert6 = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Password confirmation required." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
        [alert6 show];
    }   else if (![s1 isEqualToString:s2]) {
        UIAlertView *alert4 = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Passwords don't match." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
        [alert4 show];
    }   else {
        Client *c = [[Client alloc] initWithId:nil firstName:self.fNameText.text lastName:self.lNameText.text present:NO password:self.pwText.text username:self.userText.text];
        self.client = c;
        NSDictionary *parameters = @{@"username":c.username,@"password":c.password,@"first_name":c.first_name,@"last_name":c.last_name,@"present":[NSNumber numberWithInt:1]};
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        NSString *urlString = [NSString stringWithFormat:@"%@%@",BASEURL,POSTNEWEMPLOYEE];
        
        [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlString parameters:parameters error:nil];
        
        [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
            [self performSegueWithIdentifier:@"toNewStatus" sender:self];
        }   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Response: %@", operation.response);
            NSLog(@"Error: %@", error);
        }];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"toStatus"]) {
        if (([self.pwText.text length] == 0) || ([self.userText.text length] == 0) || ([self.confirmPwText.text length] == 0) ||
            ([self.fNameText.text length] == 0) || ([self.lNameText.text length] == 0)) {
            return NO;
        } else {
            return YES;
        }
    }  else {
        return YES;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toStatus"]) {
        StatusView *status = segue.destinationViewController;
        [status setClient:self.client];
    }
}

@end
