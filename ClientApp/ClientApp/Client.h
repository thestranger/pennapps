//
//  Client.h
//  ClientApp
//
//  Created by Jonathan Chen on 2/15/14.
//  Copyright (c) 2014 pennApps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Client : NSObject

@property bool present;
@property (strong, nonatomic) NSString *first_Name;
@property (strong, nonatomic) NSString *last_Name;
@property (strong, nonatomic) NSString *uid;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *username;

- (Client *)initWithId:(NSString *)cid firstName:(NSString *)fName lastName:(NSString *)lName present:(BOOL)p password:(NSString *)pw username:(NSString *)un;

@end
