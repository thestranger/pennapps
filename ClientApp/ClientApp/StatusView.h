//
//  StatusView.h
//  ClientApp
//
//  Created by Jonathan Chen on 2/14/14.
//  Copyright (c) 2014 pennApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <RestKit/RestKit.h>

#include <Security/Security.h>
#include <RestKit/RestKit.h>
#include <MobileCoreServices/MobileCoreServices.h>
#include <SystemConfiguration/SystemConfiguration.h>

#import <Security/Security.h>
#import <RestKit/RestKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <SystemConfiguration/SystemConfiguration.h>

#import "Client.h"

@interface StatusView : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) CLBeaconRegion *myBeaconRegion;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) Client *client;

@end
