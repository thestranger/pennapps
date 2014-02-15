//
//  StatusView.m
//  ClientApp
//
//  Created by Jonathan Chen on 2/14/14.
//  Copyright (c) 2014 pennApps. All rights reserved.
//

#import "StatusView.h"
#import "Resources.h"

#include <Security/Security.h>
#include <RestKit/RestKit.h>
#include <MobileCoreServices/MobileCoreServices.h>
#include <SystemConfiguration/SystemConfiguration.h>

#import <Security/Security.h>
#import <RestKit/RestKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <SystemConfiguration/SystemConfiguration.h>

@implementation StatusView

@synthesize statusLabel, locationManager, myBeaconRegion, client;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Initialize location manager and set ourselves as the delegate
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.pausesLocationUpdatesAutomatically=NO;
    
    // Create a NSUUID with the same UUID as the broadcasting beacon
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"715D9AA5-ED95-431B-A5C3-4738168D45B6"];
    
    // Setup a new region with that UUID and same identifier as the broadcasting beacon
    self.myBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                             identifier:@"com.pennApps.entrance"];
    
    // Tell location manager to start monitoring for the beacon region
    [self.locationManager startMonitoringForRegion:self.myBeaconRegion];
}

/* - (void)locationManager:(CLLocationManager*)manager didEnterRegion:(CLRegion*)region
{
    [self.locationManager startRangingBeaconsInRegion:self.myBeaconRegion];
    self.statusLabel.text = @"Yes";
} */

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region {
    NSString *resourcePath = [NSString stringWithFormat:POSTNEWCLIENTSTATUS];
    
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    objectManager.HTTPClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BASEURL]];
    //[objectManager.requestCache invalidateAll];
    
    RKObjectMapping *clientMapping = [RKObjectMapping mappingForClass:[Client class]];


    NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys: @"firstName", @"first_name", @"lastName", @"last_Name", @"uid", @"uid", nil];
    
    [clientMapping addAttributeMappingsFromDictionary:dictionary];
    
    if (state == CLRegionStateInside) {
        self.statusLabel.text = @"Yes";
        self.client.present = TRUE;
    } else if (state == CLRegionStateOutside || state == CLRegionStateUnknown){
        self.statusLabel.text = @"No";
        self.client.present = FALSE;
    }
    
}

/* -(void)locationManager:(CLLocationManager*)manager didExitRegion:(CLRegion*)region
{
    [self.locationManager stopRangingBeaconsInRegion:self.myBeaconRegion];
    self.statusLabel.text = @"No";
} */

-(void)locationManager:(CLLocationManager*)manager
       didRangeBeacons:(NSArray*)beacons
              inRegion:(CLBeaconRegion*)region
{
    // Beacon found!
    //self.statusLabel.text = @"Beacon found!";
    
    CLBeacon *foundBeacon = [beacons firstObject];
    NSInteger n = foundBeacon.rssi;
    if (n == 0) {
        self.statusLabel.text = @"No";
    } else {
        self.statusLabel.text = @"Yes";
    }
    // You can retrieve the beacon data from its properties
    //NSString *uuid = foundBeacon.proximityUUID.UUIDString;
    //NSString *major = [NSString stringWithFormat:@"%@", foundBeacon.major];
    //NSString *minor = [NSString stringWithFormat:@"%@", foundBeacon.minor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
