//
//  Student.h
//  Marking Software
//
//  Created by David Farrar on May 2, 2012.
//	Last Edited May 22, 2012
//  Copyright 2012 OCDSB. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Student : NSObject 
{
	NSString *studentId;
	
	NSString *firstName;
	NSString *surname;
	
	NSMutableArray *observationIds;
	NSMutableArray *conversationIds;
	
	NSString *pathname;
}

@property NSString *studentId;
@property NSString *firstName;
@property NSString *surname;
@property NSMutableArray *observationIds;
@property NSMutableArray *conversationIds;
@property NSString *pathname;

// Initializes an instance of Student with Null
- (id) init;

// Initializes an instance of Student with a file
- (id) initWithPathName:(NSString*)path;

// Initializes an instance of Student with parameters
- (id) initWithId:(NSString*)studentIdentifier andFirstName:(NSString*)first
	   andSurname:(NSString*)sur andObservations:(NSMutableArray*)observationsIdentifiers 
 andConversations:(NSMutableArray*)conversationsIdentifiers andPathname:(NSString*)path;

// Initalizes an instance of Student with an array
- (id) initWithArray:(NSArray*)data andPathname:(NSString*)path;

// Mutator: adds an object to observations
- (void) addObservationIdentifier:(NSString*)comId;

// Mutator: adds an object to conversations
- (void) addConversationIdentifier:(NSString*)comId;

// Accessor: returns the student identifier
- (NSString*) getId;

// Accessor: returns the students first name
- (NSString*) getFirstName;

// Accessor: returns the student surname
- (NSString*) getSurname;

// Accessor: returns an array of observations
- (NSMutableArray*) getObservationIdentifiers; //	Communication[]

// Accessor: returns an array of conversations
- (NSMutableArray*) getConversationIdentifiers; //	Communication[]

// Accessor: returns the pathname
- (NSString*) getPathname;

// Accessor: returns the pathnames for all observations
- (NSMutableArray*) getObservationPathnames;

// Accessor: returns the pathnames for all conversations
- (NSMutableArray*) getConversationPathnames;

- (NSMutableArray*) getObservationDates;

- (NSMutableArray*) getConversationDates;

// saves the data to a file located at pathname
- (void) saveData;

@end
