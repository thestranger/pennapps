//
//  ClientViewController.h
//  ClientApp
//
//  Created by Joseph May on 2/14/14.
//  Copyright (c) 2014 pennApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClientViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *userText;
@property (weak, nonatomic) IBOutlet UITextField *pwText;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

-(IBAction)submitButtonPressed:(id)sender;

@end
