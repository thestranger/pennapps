//
//  GlobalDataHandler.h
//  ClientApp
//
//  Created by Jonathan Chen on 2/15/14.
//  Copyright (c) 2014 pennApps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalDataHandler : NSObject

    + (GlobalDataHandler *)sharedInstance;

-(void)sendLoginRequest;
-(void)sendClientStatus;

@end
