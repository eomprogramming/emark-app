//
//  Options.m
//  Marking Software
//
//  Created by David Farrar on May 7, 2012.
//	Last Edited May 11, 2012
//  Copyright 2012 OCDSB. All rights reserved.
//


#import "Options.h"


@implementation Options

@synthesize isFrench;
@synthesize willAutoSync;
@synthesize useColorBlind;
@synthesize pathname;

- (id) init
{
	self = [super init];
	if(self)
	{
		isFrench = NULL;
		willAutoSync = NULL;
		useColorBlind = NULL;
		pathname = Nil;
	}
	return self;
}

- (id) initWithPathname:(NSString*)path
{
	self = [super init];
	if(self)
	{
		pathname = path;
		
		NSArray *optionsData = [[NSArray alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/options", path]];
		isFrench = [optionsData objectAtIndex:0];
		willAutoSync = [optionsData objectAtIndex:1];
		useColorBlind = [optionsData objectAtIndex:2];
		
		[optionsData dealloc];
	}
	return self;
}

- (id) initWithIsFrench:(BOOL)isFr andWillAutoSync:(BOOL)willSync
	   andUseColorBlind:(BOOL)useBlind andPathname:(NSString*)path
{
	self = [super init];
	if(self)
	{
		isFrench = isFr;
		willAutoSync = willSync;
		useColorBlind = useBlind;
		pathname = path;
		
		[self saveData];
	}
	return self;
}

- (id) initWithArray:(NSArray*)data andPathname:(NSString*)path
{	
	self = [super init];
	if(self)
	{
		pathname = path;
		
		isFrench = [data objectAtIndex:0];
		willAutoSync = [data objectAtIndex:1];
		useColorBlind = [data objectAtIndex:2];
	}
	return self;
	
}

- (void) setIsFrench:(BOOL)isFr {isFrench = isFr;}

- (void) setWillAutoSync:(BOOL)willSync {willAutoSync = willSync;}

- (void) setUseColorBlind:(BOOL)useBlind {useColorBlind = useBlind;}


- (BOOL) getIsFrench {return isFrench;}

- (BOOL) getWillAutoSync {return willAutoSync;}

- (BOOL) getUseColorBlind {return useColorBlind;}

- (NSString*) getPathname {return pathname;}

- (void) saveData
{
	NSMutableArray *temp = [[NSMutableArray alloc] init];

	[temp addObject:[NSNumber numberWithBool:isFrench]];
	[temp addObject:[NSNumber numberWithBool:willAutoSync]];
	[temp addObject:[NSNumber numberWithBool:useColorBlind]];
	
	[temp writeToFile:[NSString stringWithFormat:@"%@/options", pathname] atomically:YES];
	
	[temp dealloc];
}

@end
