//
//  StatusView.h
//  ClientApp
//
//  Created by Jonathan Chen on 2/14/14.
//  Copyright (c) 2014 pennApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#import "Client.h"

@interface StatusView : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) CLBeaconRegion *myBeaconRegion;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) Client *client;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
