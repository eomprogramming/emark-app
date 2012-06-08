//
//  ServerConnectionDelegate.m
//  ConnectToServer
//
//  Created by Patricia Clark on 12-05-23.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ServerConnectionDelegate.h"
#import "ServerConnection.h"

@implementation ServerConnectionDelegate

-(void)setObj:(ServerConnection*) o{
    obj = o;
}

- (void) connectiondidFinishLoading:(NSURLConnection*)connection{
    NSLog(@"did finish lodaing");
}

- (void) connection: (NSURLConnection*)connection{
    NSLog(@"did receive response");
    [obj setData:nil];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response 
{
    NSLog(@"received response");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    if(data==nil) NSLog(@"did not receive data");
    NSLog(@"\n did receive following data: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    
    [obj setData:data];
    obj.isLoaded=YES;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"connection fail with error method called.");
}

@end
