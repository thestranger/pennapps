//
//  Client.m
//  ClientApp
//
//  Created by Jonathan Chen on 2/15/14.
//  Copyright (c) 2014 pennApps. All rights reserved.
//

#import "Client.h"

@implementation Client

@synthesize present, first_Name, last_Name, uid, username, pw;

- (Client *)initWithId:(NSString *)cid firstName:(NSString *)fName lastName:(NSString *)lName present:(BOOL)p {
    self = [super init];
    if (self) {
        self.present = p;
        self.first_Name = fName;
        self.last_Name = lName;
        self.uid = cid;
    }
    return self;
}

@end
