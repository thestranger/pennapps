//
//  ClientViewController.m
//  ClientApp
//
//  Created by Joseph May on 2/14/14.
//  Copyright (c) 2014 pennApps. All rights reserved.
//

#import "ClientViewController.h"
#import "AFNetworking.h"
#import "Resources.h"
#import "Client.h"
#import "StatusView.h"

@interface ClientViewController ()

@end

@implementation ClientViewController

@synthesize userText, pwText, submitButton, client;

- (void)viewWillAppear:(BOOL)animated {
        self.pwText.secureTextEntry = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (IBAction)submitButtonPressed:(id)sender {
    
    if ([self.userText.text length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Username required." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
        [alert show];
    } else if ([self.pwText.text length] == 0) {
        UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Password required." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
        [alert2 show];
    } else {
        Client *c = [[Client alloc] initWithId:nil firstName:nil lastName:nil present:NO password:self.pwText.text username:self.userText.text];
        self.client = c;
    NSDictionary *parameters = @{@"username":c.username,@"password":c.password};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",BASEURL,POSTLOGIN];
    
    [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlString parameters:parameters error:nil];
    
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if (([self.pwText.text length] == 0) || ([self.userText.text length] == 0)) {
        return NO;
    } else {
        return YES;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toStatus"]) {
        StatusView *status = [[StatusView alloc] init];
        status.client = self.client;
    }
}

@end
