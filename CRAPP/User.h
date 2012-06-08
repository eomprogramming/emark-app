//
//  User.h
//  Marking Software
//
//	Created by David Farrar on May 2, 2012.
//	Last Edited May 22, 2012
//  Copyright 2012 OCDSB. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface User : NSObject 
{
	NSString *userId;
	
	NSString *password;
	
	NSString *firstName;
	NSString *surname;
	
	NSMutableArray *classesIds;
	NSString *pathname;
	
	NSString *securityQuestion;
	NSString *securityAnswer;
}

@property NSString *userId;
@property NSString *password;
@property NSString *firstName;
@property NSString *surname;
@property NSMutableArray *classesIds;
@property NSString *pathname;
@property NSString *securityQuestion;
@property NSString *securityAnswer;

// Initializes an instance of User with Null
- (id) init;

// Initalizes an instance of User with a file
- (id) initWithPathName:(NSString*)path;

// Initializes an instance of User with parameters
- (id) initWithId:(NSString*)userIdentifier andPassword:(NSString*)psswrd andFirstName:(NSString*)first
	   andSurname:(NSString*)sur andClasses:(NSMutableArray*)classesIdentifiers andPathname:(NSString*)path andSecurityQuestion:(NSString*)secQue
andSecurityAnswer:(NSString*)secAns;

// Initializes and instance of User with an array of data
- (id) initWithArray:(NSArray*)data andPathname:(NSString*)path;

// Mutator: sets the password
- (void) setPassword:(NSString*)psswrd;

// Mutator: sets the security question
- (void) setSecurityQuestion:(NSString*)secQue;

// Mutator: sets the security answer
- (void) setSecurityAnswer:(NSString*)secAns;

// Accessor: returns the user identifier
- (NSString*) getUserId;

// Accessor: returns the password
- (NSString*) getPassword;

// Accessor: returns the security question
- (NSString*) getSecurityQuestion;

// Accessor: returns the security answer
- (NSString*) getSecurityAnswer;

// Accessor: returns the first name
- (NSString*) getFirstName;

// Accessor: returns the surname;
- (NSString*) getSurname;

// Accessor: returns an array of file names
- (NSMutableArray*) getClasses;

// returns the pathname of the file
- (NSString*) getPathname;

// returns the pathnames of all class files
- (NSMutableArray*) getClassPathnames;

- (NSMutableArray*) getClassCourseCodes;

// Writes data to a file
- (void) saveData;

// Deletes file
- (void) deleteUser;

@end
