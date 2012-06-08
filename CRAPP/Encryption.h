//
//  Encryption.h
//  CRAPP
//
//  Created by David Huynh on 12-06-05.
//  Copyright (c) 2012 EOM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Encryption : NSObject
+(NSString *)encrypt:(NSString*)str;
+(NSString *)decrypt:(NSString*)str;
@end
