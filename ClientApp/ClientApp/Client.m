//
//  Client.m
//  ClientApp
//
//  Created by Jonathan Chen on 2/15/14.
//  Copyright (c) 2014 pennApps. All rights reserved.
//

#import "Client.h"

@implementation Client

@synthesize username, password; //present, first_Name, last_Name, uid, username, password;

 - (Client *)initWithId:(NSString *)cid firstName:(NSString *)fName lastName:(NSString *)lName present:(BOOL)p password:(NSString *)pw username:(NSString *)un {
    self = [super init];
    if (self) {
        self.present = p;
        self.first_name = fName;
        self.last_name = lName;
        self.uid = cid;
        self.username = un;
        self.password = pw;
    }
    return self;
}


@end
