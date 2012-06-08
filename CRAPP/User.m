//
//  User.m
//  Marking Software
//
//	Created by David Farrar on May 2, 2012.
//	Last Edited May 22, 2012
//  Copyright 2012 OCDSB. All rights reserved.
//


#import "User.h"


@implementation User

@synthesize userId;
@synthesize password;
@synthesize firstName;
@synthesize surname;
@synthesize classesIds;
@synthesize pathname;
@synthesize securityQuestion;
@synthesize securityAnswer;

- (id) init
{
	self = [super init];
	if(self)
	{
		userId = Nil;
		
		password = Nil;
		
		firstName = Nil;
		surname = Nil;
		
		classesIds = Nil;
		
		pathname = Nil;
		
		securityQuestion = Nil;
		securityAnswer = Nil;
	}
	return self;
}

- (id) initWithPathName:(NSString*)path
{
	self = [super init];
	if(self)
	{
		pathname = path;
		
		NSArray *userData = [[NSArray alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/user", pathname]];
	
		userId = [userData objectAtIndex:0];

		password = [userData objectAtIndex:1];
	
		firstName = [userData objectAtIndex:2];
		surname = [userData objectAtIndex:3];
	
		classesIds = [[NSMutableArray alloc] init];
	
		int i = 4;
		for(i; i<([userData count]-2); i++)
		{
			[classesIds addObject:[userData objectAtIndex:i]];
		}
		
		securityQuestion = [userData objectAtIndex:(i+1)];
		securityAnswer = [userData objectAtIndex:(i+2)];
	
		[userData dealloc];
	}
	return self;
}

- (id) initWithId:(NSString*)userIdentifier andPassword:(NSString*)psswrd andFirstName:(NSString*)first

	   andSurname:(NSString*)sur andClasses:(NSMutableArray*)classesIdentifiers andPathname:(NSString*)path andSecurityQuestion:(NSString*)secQue andSecurityAnswer:(NSString*)secAns
{
	self = [super init];
	if(self)
	{
		userId = userIdentifier;
	
		password = psswrd;
		
		firstName = first;
		surname = sur;
		
		classesIds = classesIdentifiers;
		
		pathname = path;
		
		securityQuestion = secQue;
		securityAnswer = secAns;
	}
	return self;
}

- (id) initWithArray:(NSArray*)data andPathname:(NSString*)path
{
	self = [super init];
	if(self)
	{
		pathname = path;
		
		userId = [data objectAtIndex:0];
		
		password = [data objectAtIndex:1];
		
		firstName = [data objectAtIndex:2];
		surname = [data objectAtIndex:3];
		
		classesIds = [[NSMutableArray alloc] init];
		
		int i = 4;
		for(i; i<([data count]-2); i++)
		{
			[classesIds addObject:[data objectAtIndex:i]];
		}
		
		securityQuestion = [data objectAtIndex:(i+1)];
		securityAnswer = [data objectAtIndex:(i+2)];
	}
	return self;
}

- (void) setPassword:(NSString*)psswrd {password = psswrd;}

- (void) setSecurityQuestion:(NSString*)secQue {securityQuestion = secQue;}

- (void) setSecurityAnswer:(NSString*)secAns {securityAnswer = secAns;}

- (NSString*) getUserId {return userId;}

- (NSString*) getPassword {return password;}

- (NSString*) getSecurityQuestion {return securityQuestion;}

- (NSString*) getSecurityAnswer {return securityAnswer;}

- (NSString*) getFirstName {return firstName;}

- (NSString*) getSurname {return surname;}

- (NSMutableArray*) getClasses {return classesIds;}

- (NSString*) getPathname {return pathname;}

- (NSMutableArray*) getClassPathnames
{
	NSString *tempStr;
	NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	
	for(int i = 0; i<[classesIds count];i++)
	{
		tempStr =  [NSString stringWithFormat:@"%@/%@", pathname, [classesIds objectAtIndex:i]];
		[tempArray addObject:tempStr];
	}
	[tempStr dealloc];
	return tempArray;
}

- (NSMutableArray*) getClassCourseCodesandSemesterIds
{
	NSMutableArray *classNames = [[NSMutableArray alloc] init];
	NSMutableArray *classSemesterIds = [[NSMutableArray alloc] init];
	NSArray *classData = [[NSArray alloc] init];
	for(int i = 0; i<[classesIds count]; i++)
	{
		classData = [classData initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@/class", pathname, [classesIds objectAtIndex:i]]];	
		[classNames addObject:[classData objectAtIndex:1]];
		[classSemesterIds addObject:[classData objectAtIndex:4]];
	}
	[classData dealloc];
		 
	NSMutableArray *classCodesandIds = [[NSMutableArray alloc] init];
		 
	[classCodesandIds addObject:classNames];
	[classCodesandIds addObject:classSemesterIds];
		 
	[classNames dealloc];
	[classSemesterIds dealloc];
	return classCodesandIds;
}
- (void) saveData
{
	NSMutableArray *temp = [[NSMutableArray alloc] init];
	[temp addObject:userId];
	[temp addObject:password];
	[temp addObject:firstName];
	[temp addObject:surname];
	
	for(int i = 0; i<[classesIds count]; i++)
	{
		[temp addObject:[classesIds objectAtIndex:i]];
	}
	[temp addObject:securityQuestion];
	[temp addObject:securityAnswer];
	
	[temp writeToFile:[NSString stringWithFormat:@"%@/user", pathname] atomically:YES];
	
	[temp dealloc];
}

- (void) deleteUser
{
	NSError *error;
	NSFileManager *manager = [[NSFileManager alloc] init];
	[manager removeItemAtPath:pathname error:error];
}

@end
