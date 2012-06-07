//
//  Communication.h
//  Marking Software
//
//  Created by David Farrar on May 1, 2012.
//	Last Edited May 11, 2012
//  Copyright 2012 OCDSB. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Communication : NSObject 
{
	#define OBSERVATIONS @"0"
	#define CONVERSATIONS @"1"
	
	#define INSUFFICIENT @"0"
	#define LIMITED @"1"
	#define APPROACHING @"2"
	#define SUFFICIENT @"3"
	#define INSIGHTFUL @"4"
	
	#define DEMONSTRATED @"0"
	#define EXPLAINED @"1"
	
	#define INDIVIDUAL @"0"
	#define GROUP @"1"
	#define CLASS @"2"
	
	NSString *comName;

	NSString *comExp;
	NSString *comIsObsCon;
	NSString *comLvl;
	NSString *comDsp;
	NSString *comToWho;
	
	NSString *comComments;
	
	NSDate *lastEdit;
	
	NSString *pathname;
}

@property NSString *comName; 
@property NSString *comExp; 
@property NSString *comIsObsCon;  
@property NSString *comLvl;
@property NSString *comDsp;
@property NSString *comToWho;
@property NSString *comComments;
@property NSDate *lastEdit;
@property NSString *pathname;
@property NSString *filename;

// Initializes an instance of Communication with Null
- (id) init;

- (id) initWithPathname:(NSString*)path andFilename:(NSString*)file;

// Initializes an instance of Communication with parameters
- (id) initWithName:(NSString*)name andComExp:(NSString*)exp 
andComIsObsCon:(NSString*)isObsCon andComLvl:(NSString*)lvl andComDsp:(NSString*)dsp 
andComToWho:(NSString*)toWho andComments:(NSString*)comments andLastEdit:(NSDate*)date andPathname:(NSString*)path;

// Initializes an instance of Communication with an Array
- (id) initWithArray:(NSArray*)data andPathname:(NSString*)path;

// Mutator: sets the name of the communication
- (void) setName:(NSString*)name;

// Mutator: sets the expectation
- (void) setExp:(NSString*)exp;

// Mutator: sets an identifier for observations or conversations
- (void) setObsCon:(NSString*)isObsCon;

// Mutator: sets the value/level of the communication
- (void) setLvl:(NSString*)lvl;

// Mutator: sets the type of display of the communication
- (void) setDsp:(NSString*)dsp;

// Mutator: sets the value of to who displayed
- (void) setToWho:(NSString*)toWho;

// Mutator: sets the comments with an NSString
- (void) setComments:(NSString*)comments;

// Mutator: sets the Date
- (void) setDate:(NSDate*)date;

// Accessor: returns the name
- (NSString*) getName;

// Accessor: returns the expectation
- (NSString*) getExp;

// Accessor: returns the identifier for observations or conversations
- (NSString*) getObsCon;

// Accessor: returns the level
- (NSString*) getLvl;

// Accessor: returns the method of display
- (NSString*) getDisp;

// Accessor: returns to who was displayed  (0=individual, 1=group, 2=class)
- (NSString*) getToWho;

// Accessor: returns the comments
- (NSString*) getComments;

// Accessor: returns the date
- (NSDate*) getDate;

// Accessor: returns values as data string (integers are interpreted as words)
- (NSString*) getDataString;

// Saves the data to a file at pathname
- (void) saveData;

// (Static) Compare: used for sorting methods by date 
+ (Communication*) getEarlierCom1:(Communication*)com1 andCom2:(Communication*)com2;

@end
