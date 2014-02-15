//
//  GlobalDataHandler.m
//  ClientApp
//
//  Created by Jonathan Chen on 2/15/14.
//  Copyright (c) 2014 pennApps. All rights reserved.
//

#import "GlobalDataHandler.h"

@implementation GlobalDataHandler

static GlobalDataHandler *_sharedDataHandler = nil;   //instance variable

- (id)init
{ return self; }

// Use to define the singleton instance of the GlobalDataHandler
+ (GlobalDataHandler *)sharedInstance
{
    @synchronized([GlobalDataHandler class])
    {
        if (!_sharedDataHandler) {
            NSAssert(_sharedDataHandler == nil,@"Attempted to allocate a second instance of the GlobalDataHandler singleton.");
            _sharedDataHandler = [[super alloc] init];
        }
        return _sharedDataHandler;
    }
    return nil;
}


@end
