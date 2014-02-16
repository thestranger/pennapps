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
    
    self.client = [[Client alloc] initWithId:@"2500" firstName:@"Jon" lastName:@"Chen" present:YES password:@"password" username:@"Chenny_Chen_Chen"];
    
    // Initialize location manager and set ourselves as the delegate
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    //self.locationManager.pausesLocationUpdatesAutomatically=NO;
//    
//    AFHTTPClient* client = [RKObjectManager sharedManager].HTTPClient;
//    NSDictionary *headers = client.defaultHeaders;
//    NSLog(@"Headers %d", headers.count);
//    NSArray *arHeaders = headers.allKeys;
//    NSArray *arValues = headers.allValues;
//    for (int i=0; i < headers.count; i++)
//    {
//        NSLog(@"Header = %@; Value=%@", arHeaders[i], arValues[
    // Create a NSUUID with the same UUID as the broadcasting beacon
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"715D9AA5-ED95-431B-A5C3-4738168D45B6"];
    
    // Setup a new region with that UUID and same identifier as the broadcasting beacon
    self.myBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                             identifier:@"com.pennApps.entrance"];
    
    // Tell location manager to start monitoring for the beacon region
    //[self.locationManager startMonitoringForRegion:self.myBeaconRegion];
    [self.locationManager startRangingBeaconsInRegion:self.myBeaconRegion];
    
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    
    objectManager.HTTPClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BASEURL]];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    //RKObjectMapping *clientMapping = [RKObjectMapping mappingForClass:[Client class]];
    RKObjectMapping *requestMapping = [RKObjectMapping requestMapping];
    [requestMapping addAttributeMappingsFromDictionary:@{@"username":@"username", @"password":@"password"}];
    NSString *s = [NSString stringWithFormat:@"%@%@", BASEURL, POSTNEWCLIENTSTATUS];
    [objectManager addRequestDescriptor:
     [RKRequestDescriptor requestDescriptorWithMapping:requestMapping objectClass:[Client class] rootKeyPath:POSTNEWCLIENTSTATUS method:RKRequestMethodPOST]];
     //[RKRequestDescriptor requestDescriptorWithMapping:requestMapping objectClass:[Client class] rootKeyPath:POSTLOGIN]];
    
    [objectManager postObject:self.client path:POSTNEWCLIENTSTATUS parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        NSLog(@"Posted object with the following result: %@", mappingResult);
        NSLog(@"WHOOOOOO!!!!");
        self.statusLabel.text = @"YAY";
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"Whut");
        self.statusLabel.text = @"=(";
    }];
    
    
    
    
}

/* - (void)locationManager:(CLLocationManager*)manager didEnterRegion:(CLRegion*)region
{
    [self.locationManager startRangingBeaconsInRegion:self.myBeaconRegion];
    self.statusLabel.text = @"Yes";
} */

/* - (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region {
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
    
} */

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
    
    NSString *urlString = [NSString stringWithFormat:@"%@/%@",BASEURL, POSTNEWCLIENTSTATUS];
    NSURL *url = [NSURL URLWithString:urlString];
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    objectManager.HTTPClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BASEURL]];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    RKObjectMapping *clientMapping = [RKObjectMapping mappingForClass:[Client class]];
    
    NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys: @"first_Name", @"first_name", @"last_Name", @"last_Name", @"uid", @"uid", nil];
    
    [clientMapping addAttributeMappingsFromDictionary:dictionary];
    
    CLBeacon *foundBeacon = [beacons firstObject];
    NSInteger n = foundBeacon.rssi;
    if (n == 0) {
        self.statusLabel.text = @"No";
        self.client.present = NO;
    } else {
        self.statusLabel.text = @"Yes";
        self.client.present = YES;
    }
    
    [objectManager addRequestDescriptor:
     [RKRequestDescriptor requestDescriptorWithMapping:clientMapping objectClass:[Client class] rootKeyPath:@"client" method:nil]];
    
    
    
    [objectManager postObject:self.client path:POSTNEWCLIENTSTATUS parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        NSLog(@"Posted object with the following result: %@", mappingResult);
        NSLog(@"WHOOOOOO!!!!");
    } failure:nil];
    
     /*:self.client usingBlock:^(RKObjectLoader *loader) {
        NSLog(@"In post object block");
        loader.resourcePath = @"/client";
        loader.delegate = self;
        loader.method = RKRequestMethodPOST;
        loader.objectMapping = clientMapping;
        loader.serializationMapping = clientMapping; */
    
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
