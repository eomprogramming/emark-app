//
//  Options.h
//  Marking Software
//
//  Created by David Farrar on May 7, 2012.
//	Last Edited May 11, 2012
//  Copyright 2012 OCDSB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Options : NSObject 
{
	BOOL isFrench;
	BOOL useColorBlind;
	BOOL willAutoSync;
	NSString *pathname;
}

@property BOOL isFrench;
@property BOOL useColorBlind;
@property BOOL willAutoSync;
@property NSString *pathname;

// Initializes an instance of Options with Null
- (id) init;

// Initializes an instance of Options with a pathname
- (id) initWithPathname:(NSString*)path;

// Initializes an instance of Options with parameters
- (id) initWithIsFrench:(BOOL)isFr andWillAutoSync:(BOOL)willSync
	   andUseColorBlind:(BOOL)useBlind andPathname:(NSString*)path;

// Initializes an instance of Options with 
- (id) initWithArray:(NSArray*)data andPathname:(NSString*)path;

// Mutator: sets isFrench as true or false
- (void) setIsFrench:(BOOL)isFr;

// Mutator: sets willAutoSync as true or false
- (void) setWillAutoSync:(BOOL)willSync;

// Mutator: sets useColorBlind as true or false
- (void) setUseColorBlind:(BOOL)useBlind;

// Accessor: returns isFrench
- (BOOL) getIsFrench;

// Accessor: returns willAutoSync
- (BOOL) getWillAutoSync;

// Accessor: returns useColorBlind
- (BOOL) getUseColorBlind;

// Accessor: returns pathname
- (NSString*) getPathname;

// Saves the data to pathname
- (void) saveData;

@end
