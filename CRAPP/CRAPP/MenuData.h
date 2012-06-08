//
//  MenuData.h
//  CRAPP
//
//  Created by David Huynh on 12-06-05.
//  Copyright (c) 2012 EOM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuData : NSObject
+(NSMutableArray*)readFile:(NSString*)fileName;
@end
