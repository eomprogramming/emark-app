//
//  Expectation.m
//  Marking Software
//
//  Created by David Farrar on May 1, 2012.
//	Last Edited May 11, 2012
//  Copyright 2012 OCDSB. All rights reserved.
//  Dummy class, code may be moved around and edited to other classes

#import <Foundation/Foundation.h>

@interface Expectation : NSObject 
{}

+ (void) writeClassExpectations:(NSString*)pathname andIdentifiers:(NSMutableArray*)identifiers andNames:(NSMutableArray*)names;

+ (NSString*) loadExpectationNameWithId:(NSString*)identifier andPathname:(NSString*)pathname;

@end
