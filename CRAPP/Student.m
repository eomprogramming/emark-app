//
//  Student.m
//  Marking Software
//
//  Created by David Farrar on May 2, 2012.
//	Last Edited May 22, 2012
//  Copyright 2012 OCDSB. All rights reserved.
//

#import "Student.h"


@implementation Student

@synthesize studentId;
@synthesize firstName;
@synthesize surname;
@synthesize observationIds;
@synthesize conversationIds;
@synthesize pathname;

- (id) init
{
	self = [super init];
	if(self)
	{
		studentId = Nil;
		
		firstName = Nil;
		surname = Nil;
	
		observationIds = Nil;
		conversationIds = Nil;
		
		pathname = Nil;
	}
	return self;
}

- (id) initWithPathName:(NSString*)path
{
	self = [super init];
	if(self)
	{
		pathname = path;
		
		NSArray *studentData = [[NSArray alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/student", path]];
	
		studentId = [studentData objectAtIndex:0];
	
		firstName = [studentData objectAtIndex:1];
		surname = [studentData objectAtIndex:2];
	
		observationIds = [[NSMutableArray alloc] init];
		conversationIds = [[NSMutableArray alloc] init];
	
		for(int i = 3; i<[studentData count]; i++)
		{
			NSString *temp = [studentData objectAtIndex:i];
			if([temp characterAtIndex:0=='o'])
			{
				[observationIds addObject:temp];
			}
			
			else if([temp characterAtIndex:0=='c'])
			{
				[conversationIds addObject:temp];
			}
		
			else 
			{
				NSException *invalidFile = [NSException exceptionWithName:@"Invalid Files" reason:@"The file is corrupted." userInfo:nil];
				@throw invalidFile;
			}	
		}
		[studentData dealloc];
	}
	
	return self;
}

- (id) initWithId:(NSString*)studentIdentifier andFirstName:(NSString*)first
	   andSurname:(NSString*)sur andObservations:(NSMutableArray*)observationsIdentifiers 
 andConversations:(NSMutableArray*)conversationsIdentifiers andPathname:(NSString*)path
{
	self = [super init];
	if(self) 
	{
		studentId = studentIdentifier;
		
		firstName = first;
		surname = sur;
		
		observationIds = observationsIdentifiers;
		conversationIds = conversationsIdentifiers;
		
		pathname = path;
	}
	return self;
}

- (id) initWithArray:(NSArray*)data andPathname:(NSString*)path
{
	self = [super init];
	if(self)
	{
		pathname = path;
		
		studentId = [data objectAtIndex:0];
		
		firstName = [data objectAtIndex:1];
		surname = [data objectAtIndex:2];
		
		observationIds = [[NSMutableArray alloc] init];
		conversationIds = [[NSMutableArray alloc] init];
		
		for(int i = 3; i<[data count]; i++)
		{
			NSString *temp = [data i];
			if([temp characterAtIndex:0=='o'])
			{
				[observationIds addObject:temp];
			}
			
			else if([temp characterAtIndex:0=='c'])
			{
				[conversationIds addObject:temp];
			}
			
			else 
			{
				NSException *invalidFile = [NSException exceptionWithName:@"Invalid Files" reason:"The file is corrupted." userInfo:nil];
				@throw invalidFile;
			}	
		}
	}
	return self;
}

- (void) addObservationIdentifier:(NSString*)comId {[observationIds addObject:comId];}

- (void) addConversationIdentifier:(NSString*)comId {[conversationIds addObject:comId];}


- (NSString*) getId {return studentId;}

- (NSString*) getFirstName {return firstName;}

- (NSString*) getSurname {return surname;}

- (NSMutableArray*) getObservationIdentifiers {return observationIds;}

- (NSMutableArray*) getConversationIdentifiers {return conversationIds;}

- (NSString*) getPathname {return pathname;}

- (NSMutableArray*) getObservationPathnames
{
	NSString *tempStr;
	NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	

	for(int i = 0; i<[observationIds count];i++)
	{
		tempStr =  @"%@/%@", pathname, [observationIds objectAtIndex:i];
		[tempArray addObject:tempStr];
	}
	[tempStr dealloc];
	return tempArray;
}

- (NSMutableArray*) getConversationPathnames
{
	NSString *tempStr;
	NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	
	for(int i = 0; i<[conversationIds count]; i++)
	{
		tempStr =  @"%@/%@", pathname, [conversationIds objectAtIndex:i];
		[tempArray addObject:tempStr];
	}
	[tempStr dealloc];
	return tempArray;
}

- (NSMutableArray*) getObservationDates
{
	NSMutableArray *observationDates = [[NSMutableArray alloc] init];
	NSMutableArray *observationData = [[NSMutableArray alloc] init];
							
	for(int i =0; i<[observationIds count]; i++)
	{
		observationData = [observationData initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", pathname, [observationIds objectAtIndex:i]]];
		[observationDates addObject:[observationData objectAtIndex:7]];
	}
	[observationData dealloc];
	return observationDates;
}

- (NSMutableArray*) getConversationDates
{
	NSMutableArray *conversationDates = [[NSMutableArray alloc] init];
	NSMutableArray *conversationData = [[NSMutableArray alloc] init];
	
	for(int i =0; i<[conversationIds count]; i++)
	{
		conversationData = [conversationData initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", pathname, [conversationIds objectAtIndex:i]]];
		[conversationDates addObject:[conversationData objectAtIndex:7]];
	}
	[conversationData dealloc];
	return conversationDates;
}

- (void) saveData
{
	NSMutableArray *temp = [[NSMutableArray alloc] init];
	
	[temp addObject:studentId];
	[temp addObject:firstName];
	[temp addObject:surname];
	
	for(int i = 0; i<[observationIds count]; i++)
	{
		[temp addObject:[observationIds objectAtIndex:i]];
	}

	for(int i = 0; i<[conversationIds count]; i++)
	{
		[temp addObject:[conversationIds objectAtIndex:i]];
	}

	[temp writeToFile:[NSString stringWithFormat:@"%@/student", pathname] atomically:YES];
	
	[temp dealloc];
}

@end
