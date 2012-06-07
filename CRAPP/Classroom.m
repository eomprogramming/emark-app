//
//  Class.m
//  Marking Software
//
//	Created by David Farrar on May 2, 2012.
//	Last Edited May 14, 2012
//  Copyright 2012 OCDSB. All rights reserved.
//

#import "Classroom.h"


@implementation Classroom: NSObject

@synthesize classId;
@synthesize className;
@synthesize sectionId;
@synthesize sectionName;
@synthesize semester;
@synthesize studentIds;
@synthesize expectationIds;
@synthesize pathname;

- (id) init
{
	self = [super init];
	if(self)
	{
		classId = nil;
		className = nil;
		sectionId = nil;
		sectionName = nil;
		semester = nil;
		
		studentIds = nil;
		expectationIds = nil;
		
		pathname = nil;
	}
	return self;
}

- (id) initWithPathname:(NSString*)path
{
	self = [super init];
	if(self)
	{
		pathname = path;
		
		NSArray *optionsData = [[NSArray alloc] initWithContentsOfFile:@"%@/class", path];

		classId = [optionsData objectAtIndex:0];
		className = [optionsData objectAtIndex:1];
		sectionId = [optionsData objectAtIndex:2];
		sectionName = [optionsData objectAtIndex:3];
		semester = [optionsData objectAtIndex:4];
		
		for(int i = 5; i < [optionsData count]; i++)
		{
			NSString *temp = [userData i];
			if(temp characterAtIndex:0=='s')
			{
				[studentIds addObject:temp];
			}
			
			else if(temp characterAtIndex:0=='e')
			{
				[expectationIds addObject:temp];
			}
		}
		[optionsData dealloc];
	}
	return self;
}

- (id) initWithId:(int)classIdentifier andClassName:(NSString*)clssName 
	 andSectionId:(int)sectionIdentifier andSectionName:(NSString*)sctionName
	  andSemester:(int)semesterIdentifer andStudents:(NSMutableArray*)studentIdentifiers 
  andExpectations:(NSMutableArray*)expectationIdentifiers andPathname:(NSString*)path;
{
	self = [super init];
	if(self)
	{
		classId = classIdentifier;
		className = clssName;
		sectionId = sectionIdentifier;
		sectionName = sctionName;
		semester = semesterIdentifier;
		
		studentIds = studentIdentifiers;
		expectationIds = expectationIdentifiers;
		
		pathname = path;
	}
	return self;
}

- (id) initWithArray:(NSString*)data andPathname:(NSString*)path
{
	self = [super init];
	if(self)
	{
		pathname = path;
		
		classId = [data objectAtIndex:0];
		className = [data objectAtIndex:1];
		sectionId = [data objectAtIndex:2];
		sectionName = [data objectAtIndex:3];
		semester = [data objectAtIndex:4];
		
		for(int i = 5; i < [data count]; i++)
		{
			NSString *temp = [data i];
			if(temp characterAtIndex:0=='s')
			{
				[studentIds addObject:temp];
			}
			
			else if(temp characterAtIndex:0=='e')
			{
				[expectationIds addObject:temp];
			}
		}
	}
	return self;
	
}

- (int) getId {return classId;}

- (NSString*) getClassName {return className;}

- (int) getSectionId {return sectionId;}

- (NSString*) getSectionName {return sectionName;}

- (int) getSemester {return semester;}

- (NSMutableArray*) getStudentIdentifiersList {return studentIds;}

- (NSMutableArray*) getExpectationIdentifiersList {return studentIds;}

- (NSString*) getPathname {return pathname;}

- (NSMutableArray*) getStudentPathnames
{
	NSString *tempStr;
	NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	
	for(int i = 0; i<[studentIds count];i++)
	{
		tempStr =  @"%@/%@", pathname, [studentIds objectAtIndex:i];
		[tempArray addObject:tempStr];
	}
	[tempStr dealloc];
	return tempArray;	
}

- (NSMutableArray*) getStudentNames
{
	NSMutableArray *studentNames = [[NSMutableArray alloc] init];
	NSArray *studentData = [[NSArray alloc] init]
	
	for(int i = 0; i < [studentIds count]; i++)
	{
		studentData = [studentData initWithContentsOfFile:@"%@/%@/student", pathname, [studentIds objectAtIndex:i]];
		[studentNames addObject:@"%@, %@", [studentData objectAtIndex:1], [studentData objectAtIndex:2]];
		
	}
	[studentData dealloc];
	return studentNames;
}

- (void) saveData
{
	NSMutableArray *temp = [[NSMutableArray alloc] init];
	[temp addObject:classId];
	[temp addObject:className];
	[temp addObject:sectionId];
	[temp addObject:sectionName];
	[temp addObject:semester];
	
	for(int i = 0; i < [studentIdentifiers count]; i++)
	{
		[temp addObject:[studentIds objectAtIndex:i]]
	}
	
	for(int i = 0; i < [expectationIdentifiers count]; i++)
	{
		[temp addObject:[expectationIds objectAtIndex:i]]
	}
	
	[temp writeToFile:@"%@/class", pathname atomically:YES];
	
	[temp dealloc];
}

@end
