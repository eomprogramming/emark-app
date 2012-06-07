//
//  MenuData.m
//  CRAPP
//
//  Created by David Huynh on 12-06-05.
//  Copyright (c) 2012 EOM. All rights reserved.
//

#import "MenuData.h"

@implementation MenuData
+(NSMutableArray*)readFile:(NSString*)fileName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //make a file name to write the data to using the
    //documents directory:
    NSString *fullFileName = [NSString stringWithFormat:@"%@/%@.menuData", documentsDirectory,fileName];
    
    //retrieve your array by using initWithContentsOfFile while passing
    //the name of the file where you saved the array contents.
    NSMutableArray *array = [[[NSMutableArray alloc] initWithContentsOfFile:fullFileName]autorelease];
    return array;
}
@end
