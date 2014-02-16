//
//  PreSignInView.h
//  ClientApp
//
//  Created by Joseph May on 2/16/14.
//  Copyright (c) 2014 pennApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Client.h"

@interface PreSignInView : UIViewController <UITextFieldDelegate>

@property (weak, atomic) IBOutlet UITextField *fNameText;
@property (weak, atomic) IBOutlet UITextField *lNameText;
@property (weak, atomic) IBOutlet UITextField *userText;
@property (weak, atomic) IBOutlet UITextField *pwText;
@property (weak, atomic) IBOutlet UITextField *confirmPwText;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) Client *client;

-(IBAction)submitButtonPressed:(id)sender;

@end
