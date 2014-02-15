//
//  BoxViewController.m
//  BoxApp
//
//  Created by Joseph May on 2/14/14.
//  Copyright (c) 2014 pennApps. All rights reserved.
//

#import "BoxViewController.h"

@interface BoxViewController ()

@end

@implementation BoxViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //create UUID Object
    NSUUID *uuid= [[NSUUID alloc] initWithUUIDString: @"715D9AA5-ED95-431B-A5C3-4738168D45B6"];

    //initialize the Beacon Region
    //subject to change
    self.myBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                  major:1
                                                                  minor:1
                                                            identifier:@"com.pennApps.entrance" ];
    //test
    self.myBeaconData = [self.myBeaconRegion peripheralDataWithMeasuredPower:nil];
    
    self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];
    //endTest
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)switchSwitched:(id)sender {
    
    //if switch = true
    //        turn on broadcast
    //if switch = false
    //         turn off broadcast
    // FOR NOW, IT CAN ONLY BE TURNED ON
    
//    self.myBeaconData = [self.myBeaconRegion peripheralDataWithMeasuredPower:nil];
    
//    self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];
    if (!_broadcastIsOn)
    {
        [self.peripheralManager startAdvertising:self.myBeaconData];
    }
    else if ( _broadcastIsOn)
    {
       [self.peripheralManager stopAdvertising];
    }
        
}

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    if (peripheral.state == CBPeripheralManagerStatePoweredOn)
    {
        //Bluetooth is on
        
        //update our status label
        self.bluetoothStatusLabel.text = @"Bluetooth Status: On";
        _broadcastIsOn.enabled =YES;
        //Start broadcasting
       if(_broadcastIsOn)
       {
           [self.peripheralManager startAdvertising:self.myBeaconData];
       }
    }
    else if (peripheral.state == CBPeripheralManagerStatePoweredOff)
    {
        //Update our status label
        self.bluetoothStatusLabel.text = @"Bluetooth Status: Off";
        
        _broadcastIsOn.enabled =NO;
        
        //Bluetooth isn't on. Stop broadcasting
        [self.peripheralManager stopAdvertising];
    }
    else if (peripheral.state == CBPeripheralManagerStateUnsupported)
    {
        self.bluetoothStatusLabel.text = @"Bluetooth Not Supported";
        _broadcastIsOn.enabled =NO;
    }
}

@end
