//
//  Expectation.m
//  Marking Software
//
//  Created by David Farrar on May 1, 2012.
//	Last Edited May 11, 2012
//  Copyright 2012 OCDSB. All rights reserved.
//  Dummy class, code may be moved around and edited to other classes

#import "Expectation.h"

@implementation Expectation


+ (void) writeClassExpectations:(NSString*)pathname andIdentifiers:(NSMutableArray*)identifiers andNames:(NSMutableArray*)names	
{
	NSException *invalidData = [NSException exceptionWithName:@"InvalidData" reason:@"InvalidIdentifiers - WHATHAVEYOUDONE" userInfo:nil];
	
	if(![identifiers count]==[names count])
		@throw invalidData;
	else
	{
        NSLog(@"%i", [identifiers count]);
        NSMutableArray *temp = [[NSMutableArray alloc] init];
		
		[temp addObject:[NSString stringWithFormat:@"%i",[identifiers count]]];
		
		for(int i = 0; i<[identifiers count]; i++)
		{
			[temp addObject:[[NSMutableArray alloc]init]];
            [[temp objectAtIndex:i+1]addObject:[identifiers objectAtIndex:i]];
            [[temp objectAtIndex:i+1]addObject:[names objectAtIndex:i]];
            NSLog(@"%@", temp);
		}
    [temp writeToFile:[NSString stringWithFormat:@"%@/expectations",pathname] atomically:YES];
    }
}


+ (NSString*) loadExpectationNameWithId:(NSString*)identifier andPathname:(NSString*)pathname
{
	NSArray *expectationData = [[NSArray alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/expectations", pathname]];
	NSString *temp;
	int tempInt = [expectationData objectAtIndex:0];
	
	for(int i = 1; i<(tempInt+1); i++)
	{
		if([identifier isEqual:[expectationData objectAtIndex:i]])
		{
			temp = [NSString stringWithFormat :@"%@", [expectationData objectAtIndex:tempInt+i]];
			[expectationData dealloc];
			return temp;
		}
	}
	NSException *invalidParameters = [NSException exceptionWithName:@"InvalidParameters" reason:@"InvalidParameters - WHATHAVEYOUDONE" userInfo:nil];
	@throw invalidParameters;
}

@end