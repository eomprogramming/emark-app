//
//  Class.h
//  Marking Software
//
//	Created by David Farrar on May 2, 2012.
//	Last Edited May 14, 2012
//  Copyright 2012 OCDSB. All rights reserved.
//
//#import <Cocoa/Cocoa.h>
//gordon ff
#import <Foundation/Foundation.h>

@interface Classroom :NSObject
{
	NSString *classId;
	NSString *className;
	NSString *sectionId;
	NSString *sectionName;
	NSString *semester;
	
	NSMutableArray *studentIds; // int[]
	NSMutableArray *expectationIds; // int[]
	
	NSString *pathname;
}

@property NSString *classId;
@property NSString *className;
@property NSString *sectionId;
@property NSString *sectionName;
@property NSString *semester;
@property NSMutableArray *studentIds;
@property NSMutableArray *expectationIds;
@property NSString *pathname;

// Initializes an instance of Class with Null
- (id) init;
	
// Initializes an instance of Class with a file
- (id) initWithPathname:(NSString*)path;

// Initializes an instance of Class with parameters 
- (id) initWithId:(int)classIdentifier andClassName:(NSString*)clssName 
	 andSectionId:(int)sectionIdentifier andSectionName:(NSString*)sctionName
	  andSemester:(int)semesterIdentifer andStudents:(NSMutableArray*)studentIdentifiers 
  andExpectations:(NSMutableArray*)expectationIdentifiers andPathname:(NSString*)path;

// Initializes an instance of Class with an array
- (id) initWithArray:(NSMutableArray*)data andPathname:(NSString*)path;

// Accessor: returns the class identifier
- (int) getId;

// Accessor: returns the class name as an NSString
- (NSString*) getClassName;

// Accessor: returns the section identifier
- (int) getSectionId;

// Accessor: returns the section name as an NSString
- (NSString*) getSectionNameId;

// Accessor: returns the semester (0 = 1st, 1 = 2nd)
- (int) getSemester;

// Accessor: returns a list of the students
- (NSMutableArray*) getStudentIdentifiersList; // Student[]

// Accessor: returns a list of the expectations
- (NSMutableArray*) getExpectationIdentifiersList; // Expectation[]

// Accessor: returns the pathname
- (NSString*) getPathname;

// Accessor: returns a list of pathnames for students
- (NSMutableArray*) getStudentPathnames;

- (NSMutableArray*) getStudentNames;

- (void) saveData;

@end
