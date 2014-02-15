//
//  Client.m
//  ClientApp
//
//  Created by Jonathan Chen on 2/15/14.
//  Copyright (c) 2014 pennApps. All rights reserved.
//

#import "Client.h"

@implementation Client

@synthesize present, firstName, lastName, uid;

- (Client *)initWithId:(NSString *)cid firstName:(NSString *)fName lastName:(NSString *)lName present:(BOOL)p {
    self = [super init];
    if (self) {
        if (p) {
            self.present = [NSString stringWithFormat:@"YES"];
        }
        self.firstName = fName;
        self.lastName = lName;
        self.uid = cid;
    }
    return self;
}

@end
