//
//  BoxViewController.h
//  BoxApp
//
//  Created by Joseph May on 2/14/14.
//  Copyright (c) 2014 pennApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface BoxViewController : UIViewController<CBPeripheralManagerDelegate>


@property (weak, nonatomic) IBOutlet UISwitch *broadcastIsOn;

@property (weak, nonatomic) IBOutlet UIImageView *broadcastImage;


@property (weak, nonatomic) IBOutlet UILabel *bluetoothStatusLabel;

@property (strong, nonatomic) CLBeaconRegion *myBeaconRegion;

@property (strong, nonatomic) NSDictionary *myBeaconData;

@property (strong, nonatomic) CBPeripheralManager *peripheralManager;

@end
