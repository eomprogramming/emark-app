//
//  ServerConnectionDelegate.h
//  ConnectToServer
//
//  Created by Patricia Clark on 12-05-23.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerConnection.h"

@interface ServerConnectionDelegate : NSObject{
    NSString *sessionID;
    ServerConnection *obj;
}
-(void)setObj:(ServerConnection*)o; 

@end
