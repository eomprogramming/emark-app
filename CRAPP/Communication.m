//
//  Communication.m
//  Marking Software
//
//  Created by David Farrar on May 1, 2012.
//	Last Edited May 11, 2012
//  Copyright 2012 OCDSB. All rights reserved.
//  sdfsdfsdf

#import "Communication.h"
#import "Expectation.h"

@implementation Communication

@synthesize comName; 
@synthesize comExp; 
@synthesize comIsObsCon;  
@synthesize comLvl;
@synthesize comDsp;
@synthesize comToWho;
@synthesize comComments;
@synthesize lastEdit;
@synthesize pathname;
@synthesize filename;

- (id) init
{
	self = [super init];
	if(self)
	{
		comName = Nil;
	
		comExp = Nil;
		
		comIsObsCon = Nil;
		comLvl = Nil;
		comDsp = Nil;
		comToWho = Nil;
	
		comComments = Nil;
	
		lastEdit = Nil;
		
		pathname = Nil;
		
		filename = Nil;
	}
	return self;
}

- (id) initWithPathname:(NSString*)path  andFilename:(NSString*)file
{
	self = [super init];
	if(self)
	{
		pathname = path;
		
		filename = file;
		
		NSArray *communicationData = [[NSArray alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", path, file]];
		
		comName = [communicationData objectAtIndex:0];
		
		comExp = [communicationData objectAtIndex:1];
		
		comIsObsCon = [communicationData objectAtIndex:2];
		comLvl = [communicationData objectAtIndex:3];
		comDsp = [communicationData objectAtIndex:4];
		comToWho = [communicationData objectAtIndex:5];
		
		comComments = [communicationData objectAtIndex:6];
		fileName = [communicationData objectAtIndex:7];
		[self setDate [communicationData objectAtIndex:7]];
		
		[communicationData dealloc];
	}
	return self;
}

- (id) initWithName:(NSString*)name andComExp:(NSString*)exp 
	 andComIsObsCon:(NSString*)isObsCon andComLvl:(NSString*)lvl andComDsp:(NSString*)dsp 
		andComToWho:(NSString*)toWho andComments:(NSString*)comments andLastEdit:(NSString*)date andPathname:(NSString*)path
{
	self = [super init];
	if(self)
	{
		comName = name;
	
		comExp = exp;
		
		comIsObsCon = isObsCon;
		comLvl = lvl;
		comDsp = dsp;
		comToWho = toWho;
	
		comComments = comments;
	        fileName = date;
		[self setDate:date];
		
		pathname = path;
		
		if(comIsObsCon == OBSERVATIONS)
			filename = @"o%i", [lastEdit timeIntervalSince1970];
		else //if(comIsObsCon == CONVERSATIONS)
			filename = @"c%i", [lastEdit timeIntervalSince1970];
	}
	return self;
}

- (id) initWithArray:(NSArray*)data andPathname:(NSString*)path
{
	self = [super init];
	if(self)
	{
		pathname = path;
		
		comName = [data objectAtIndex:0];
		
		comComments = [data objectAtIndex:1];
		
		comLvl = [data objectAtIndex:2];
		comIsObsCon = [data objectAtIndex:3];
		comDsp = [data objectAtIndex:4];//
		comToWho = [data objectAtIndex:5];
		
		comComments = [data objectAtIndex:6];
		fileName = [data objectAtIndex:7];
        [self setDate:[data objectAtIndex:7]];
		
		if(comIsObsCon == OBSERVATIONS)
			filename = @"o%i", [lastEdit timeIntervalSince1970];
		else if(comIsObsCon == CONVERSATIONS)
			filename = @"c%i", [lastEdit timeIntervalSince1970];
	}
	return self;
}

- (void) setName:(NSString*)name {comName=name;}

- (void) setExp:(NSString*)exp {comExp=exp;}

- (void) setObsCon:(NSString*)isObsCon {comIsObsCon=isObsCon;}

- (void) setLvl:(NSString*)lvl {comLvl=lvl;}

- (void) setDsp:(NSString*)dsp {comDsp=dsp;}

- (void) setToWho:(NSString*)toWho {comToWho=toWho;}

- (void) setComments:(NSString*)comments {comComments=comments;}

- (void) setDate:(NSString*)date 
{
    double timeInt = [date doubleValue];
    NSDate *temp = [NSDate dateWithTimeIntervalSince1970:timeInt];
    lastEdit=temp;
}

- (NSString*) getName {return comName;}

- (NSString*) getExp {return comExp;}

- (NSString*) getObsCon {return comIsObsCon;}

- (NSString*) getLvl {return comLvl;}

- (NSString*) getDisp {return comDsp;}

- (NSString*) getToWho {return comToWho;}

- (NSString*) getComments {return comComments;}

- (NSDate*) getDate {return lastEdit;}

- (NSString*) getExpName
{
	NSString *classPathname = [[pathname stringByDeletingLastPathComponent] stringByDeletingLastPathComponent];
	return [Expectation loadExpectationNameWithId:comExp andPathname:classPathname];
}

- (NSString*) getDataString
{
	NSMutableString *mutable = [[NSMutableString alloc] stringWithCapacity:60];
	
	NSException *invalidData = [NSException exceptionWithName:@"InvalidData" reason:@"InvalidIdentifiers - WHATHAVEYOUDONE" userInfo:nil];
	
	[mutable appendString:comName];
	[mutable appendString:@" has "];
	
	if([[self getDisp] isEqual:DEMONSTRATED])
	{
		[mutable appendString:@"demonstrated "];
	}
	else if([[self getDisp ] isEqual:EXPLAINED])
	{
		[mutable appendString:@"explained "];
	}
	
	else 
	{
		@throw invalidData;
	}

	if ([comLvl isEqual:INSUFFICIENT]) 
	{
		[mutable appendString:@"with insufficient understanding "];
	}
	
	else if ([comToWho isEqual:LIMITED])

	{
		[mutable appendString:@"with limited understanding "];
	}
	
	else if ([comToWho isEqual:APPROACHING])
	{
		[mutable appendString:@"with approaching understanding "];
	}
	
	else if ([comToWho isEqual:SUFFICIENT])
	{
		[mutable appendString:@"with sufficient understanding "];
	}
	
	else if ([comToWho isEqual:INSIGHTFUL])
	{
		[mutable appendString:@"with insightful understanding "];
	}
	
	else 
	{
		@throw invalidData;
	}

	if ([comToWho isEqual:INDIVIDUAL]) 
	{
		[mutable appendString:@"to an individual "];
	}
	
	else if ([comToWho isEqual:GROUP])
	{
		[mutable appendString:@"to a group "];
	}
	
	else if (comToWho == CLASS)
	{
		[mutable appendString:@"to the class "];
	}
	
	else 
	{
		@throw invalidData;
	}

	
	[mutable appendString: @"knowledge of "];
	[mutable appendString:[comExp getDataString]];
	[mutable appendString: @". "];
	[mutable appendString:comComments];
	
	return mutable;
}

- (void) saveData
{
	NSMutableArray *temp = [[NSMutableArray alloc] init];
	[temp addObject:comName];
	[temp addObject:comExp];
	[temp addObject:comIsObsCon];
	[temp addObject:comLvl];
	[temp addObject:comDsp];
	[temp addObject:comToWho];
	[temp addObject:comComments];
	[temp addObject:lastEdit];
	
	[temp writeToFile:[NSString stringWithFormat:@"%@/%@", pathname, filename] atomically:YES];
	
	[temp dealloc];
}

+ (Communication*) getEarlierCom1:(Communication*)com1 andCom2:(Communication*)com2
{
	return [[com1 getDate] earlierDate:[com2 getDate]];
}

@end

