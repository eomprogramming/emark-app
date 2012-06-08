///*
    //  ServerConnection.h
    //  ConnectToServer
    //
    // This class is used to connect to the server and retrieve data.
    // The ServerConnectionDelegate class must be included in any implementations
    // of this class.
    //
    //  Created by Patricia Clark on 12-05-23.
    //  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
    //
    
#import <Foundation/Foundation.h>
    
    @interface ServerConnection : NSObject{
        NSString *sessionID;
        NSMutableData *responseData;
        NSString *staffID;
        bool *isLoaded;
        }

@property (assign, nonatomic) NSMutableData *responseData; 
@property (assign, nonatomic) NSString *sessionID;
@property (assign, nonatomic) NSString *staffID; 


@property (assign, nonatomic) bool *isLoaded;

/*
 * Refer to bit.ly/markingapi for what the server will return.
 */

/*
 * Sets the responseData variable. This method is only used by the delegate
 * @params NSData d - the data responseData is set to
 */
-(void) setData:(NSData*) d;

/*
 * Sets the responseData variable. This method is only used by the delegate
 * @returns the responseData variable
 */
-(NSData*) getData;

/*
 * Encodes the passed string.
 * @params NSString str - the string to be encoded 
 * @returns a NSString of the original string encoded to UTF8
 */
-(NSString*)urlEncodeValue:(NSString *)str;

/*
 * Logs in to the server and and set the sessionId if sucessful
 * @params NSString username - the account's username
 * @params NSString password - the account's password
 * @returns - NSMutableArray of the server response 
 */
-(NSMutableArray*)login:(NSString*)username withPwd:(NSString*)password;

/*
 * Log out from the server.
 */
-(void)logout;

/*
 * Returns a list of the teacher's school classes
 * @params NSString staffId - the staffId, this is the staffId variable of a serverConnection object
 * @returns - NSMutableArray of the server response 
 */
-(NSMutableArray*) selectClasses: (NSString*) staffId;

/*
 * Returns a list of the course's expectations/learning skills
 * @params NSString sectionId - the sectionId of the course
 * @returns - NSMutableArray of the server response 
 */
-(NSMutableArray*) selectExpectationsByCourses: (NSString*) sectionId;

/*
 * Returns a list of students by course
 * @params NSString studentId - the staffId, this is the staffId variable of a serverConnection object
 * @returns - NSMutableArray of the server response 
 */
-(NSMutableArray*) selectStudentsByCourses: (NSString*) studentId;

/*
 * Returns a list of a student's observations or conversations
 * @params NSString studentId - the student's id
 * @params NSString type - 1 for observations, 2 for conversations, 3 for both
 * @params NSMutableArray skill - An array of two elements. The first element is an array of learning skill 
 * ids that the user wishes to view. The second element is an array of expectation ids that the user wishes
 * to view
 * @returns - NSMutableArray of the server response 
 */
-(NSMutableArray*) selectObservationsAndOrConvos: (NSString*) studentId type:(NSString*)type lrnSkill:  (NSMutableArray*)skill;

/*
 * Returns a list of a student's communications
 * @params NSString studentId - the staffId, this is the staffId variable of a serverConnection object
 * @returns - NSMutableArray of the server response 
 */
-(NSMutableArray*) selectAllCommunications: (NSString*) studentId;

/*
 * Sync's the current record with the server
 * @params NSMutableArray input - an array of communications that wished to be synced. Refer to   
 * bit.ly/markingapi for details on format
 * @returns - NSMutableArray of the server response 
 */
-(NSMutableArray*) sync: (NSMutableArray*) input;

/*
 * Add an observation to a student
 * @params NSString studentId - the student's id
 * @params NSString timeStamp - the unix timestamp of the date the observation was sent
 * @params NSString isLearning - 0 for false, 1 for true
 * @params NSString explrnSkill - the id of the expectation or learning skill
 * @params NSString level - the level of the communication, can be 0,1,2,3, or 4
 * @params NSString inputText - the comment of the communication. Refer to bit.ly/markingApi for the 
 * format
 * @returns - NSMutableArray of the server response 
 */
-(NSMutableArray*) addObservation:(NSString*)studentId time:(NSString*)timeStamp isLearning:(NSString*)isLrn 
                explrnSkill:(NSString*)explrnSkill level:(NSString*)level text:(NSString*) inputText;

/*
 * Add an conversation to a student
 * @params NSString studentId - the student's id
 * @params NSString timeStamp - the unix timestamp of the date the observation was sent
 * @params NSString isLearning - 0 for false, 1 for true
 * @params NSString explrnSkill - the id of the expectation or learning skill
 * @params NSString level - the level of the communication can be 0,1,2,3, or 4
 * @params NSString inputText - the comment of the communication. Refer to bit.ly/markingApi for the 
 * format
 * @returns - NSString of the server response 
 */
-(NSMutableArray*) addConversation:(NSString*)studentId time:(NSString*)timeStamp isLearning:(NSString*)isLrn 
                 explrnSkill:(NSString*)explrnSkill level:(NSString*)level text:(NSString*)inputText;

/*
 * Delete a selected record
 * @returns - NSString of the server response
*/ 
 -(NSMutableArray*) deleteRecord:(NSString*)recordId;
 
 /*
 * Update a record
 * @params NSString recordId - the record's Id
 * @params NSString timeStamp - the unix timestamp of the date the observation was sent
 * @params NSString isLearning - 0 for false, 1 for true
 * @params NSString explrnSkill - the id of the expectation or learning skill
 * @params NSString level - the level of the communication can be 0,1,2,3, or 4
 * @params NSString inputText - the comment of the communication. Refer to bit.ly/markingApi for the 
 * format
 * @returns - NSMutableArray of the server response 
 */
-(NSMutableArray*) updateRecord:(NSString*)recordId time:(NSString*)timeStamp isLearning:(NSString*)isLrn 
              explrnSkill:(NSString*)explrnSkill level:(NSString*)level text:(NSString*) inputText;

@end
