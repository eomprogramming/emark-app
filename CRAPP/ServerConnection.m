//
//  ServerConnection.m
//  ConnectToServer
//
//  Created by Patricia Clark on 12-05-23.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ServerConnection.h"
#import "ServerConnectionDelegate.h"

@implementation ServerConnection
NSString const *IPAddress = @"10.178.30.78"; 
NSError *error;
@synthesize responseData;
@synthesize isLoaded;
@synthesize sessionID;
@synthesize staffID;

// blahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblah
// blahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblah

-(NSData*) getData{
    return responseData;
}
-(void) setData:(NSMutableData*) d
{
    responseData = [d retain];
}
-(NSMutableArray*)login:(NSString*)username withPwd:(NSString*)password{
    ServerConnectionDelegate *sDelegate = [ServerConnectionDelegate alloc];//init delegate
    [sDelegate setObj:self];
    
    //format the params that will be passed to the server
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:username,@"0", password, @"1",nil];
    NSData *data =[NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    NSData *jsonData = [[NSData alloc] initWithData :data];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    jsonString = [self urlEncodeValue:jsonString];
    
    //sets up the NSURLrequest
    NSString *inputString =[@"fcn=login&params=" stringByAppendingString:[NSString stringWithFormat:@"%@&is_app=1",jsonString]];
    NSString *urlString = [[NSString stringWithFormat:@"http://%@/mark/model/staff-model.php?", IPAddress]stringByAppendingString:inputString];    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    
    //connect to the server
    NSString *output =  [self connectToServer:request withData:inputString];
    
    //edit the return response
    output = [output substringWithRange:NSMakeRange(1, output.length - 3)];
    
    //convert output to an array
    NSMutableArray *jsonArray = [NSJSONSerialization JSONObjectWithData:[output dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    
    //get to see if the request was sucessful (note: does not currently work)
    
    if([[jsonArray objectAtIndex:0] boolValue]==YES)NSLog(@"logged in");
    else{
    }
    
    
    
    sessionID = [[jsonArray objectAtIndex:1] objectAtIndex:2];
    staffID = [[jsonArray objectAtIndex:1] objectAtIndex:1];

    return [jsonArray retain];
}
-(void)logout{
    //init delegate
    ServerConnectionDelegate *sDelegate = [ServerConnectionDelegate alloc];
    [sDelegate setObj:self];
    
    //format the params that will be passed to the server
    NSString *inputString =[@"fcn=logout&params=" stringByAppendingString:[NSString stringWithFormat:@"%@&is_app=1",@""]];
    NSString *urlString = [[NSString stringWithFormat:@"http://%@/mark/model/staff-model.php?", IPAddress]stringByAppendingString:inputString];    
    
    //sets up the NSURLrequest
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    
    //connect to the server
    NSString *output =  [self connectToServer:request withData:inputString];
}
-(NSMutableArray*) selectClasses:(NSString*) staffId{
    // init delegate
    ServerConnectionDelegate *sDelegate = [ServerConnectionDelegate alloc];
    [sDelegate setObj:self];
   
    // format params
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:staffId,@"0",nil];
    NSData *data =[NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    NSData *jsonData = [[NSData alloc] initWithData :data];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    jsonString = [self urlEncodeValue:jsonString];
    
    // setup NSURLConnection
    NSString *inputString =[@"fcn=selectClasses&params=" stringByAppendingString:[NSString stringWithFormat:@"%@&sess_id=%@&is_app=1",jsonString,sessionID]];
    NSString *urlString = [[NSString stringWithFormat:@"http://%@/mark/model/classes-model.php?", IPAddress]stringByAppendingString:inputString];    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    
    // Connect to server
    NSString *output =  [self connectToServer:request withData:inputString];
    output = [output substringWithRange:NSMakeRange(1, output.length - 3)];
    
    // format return response
    NSMutableArray *jsonArray = [NSJSONSerialization JSONObjectWithData:[output dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    //check if the connection was a sucess (does not work currently)
    if([[jsonArray objectAtIndex:0] boolValue]==YES)NSLog(@"sucess");
    else{
    }    
    return jsonArray;

}
-(NSMutableArray*) selectExpectationsByCourses:(NSString*) sectionId{
    //init delegate
    ServerConnectionDelegate *sDelegate = [ServerConnectionDelegate alloc];
    [sDelegate setObj:self];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: sectionId ,@"0",nil];
    
    NSData *data =[NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    NSData *jsonData = [[NSData alloc] initWithData :data];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    jsonString = [self urlEncodeValue:jsonString];
    NSString *inputString =[@"fcn=selectExpectationsByCourse&params=" stringByAppendingString:[NSString stringWithFormat:@"%@&sess_id=%@&is_app=1",jsonString,sessionID]];
    NSString *urlString = [[NSString stringWithFormat:@"http://%@/mark/model/expectations-model.php?", IPAddress]stringByAppendingString:inputString];    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    NSString *output =  [self connectToServer:request withData:inputString];
    output = [output substringWithRange:NSMakeRange(1, output.length - 3)];
    NSMutableArray *jsonArray = [NSJSONSerialization JSONObjectWithData:[output dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    //does not work
    if([[jsonArray objectAtIndex:0] boolValue]==YES)NSLog(@"sucess");
    return jsonArray;
}
-(NSMutableArray*) selectStudentsByCourses:(NSString*) courseId{
    ServerConnectionDelegate *sDelegate = [ServerConnectionDelegate alloc];
    [sDelegate setObj:self];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:courseId,@"0",nil];
    NSData *data =[NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    NSData *jsonData = [[NSData alloc] initWithData :data];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    jsonString = [self urlEncodeValue:jsonString];
    NSString *inputString =[@"fcn=selectStudentsByCourse&params=" stringByAppendingString:[NSString stringWithFormat:@"%@&sess_id=%@&is_app=1",jsonString,sessionID]];
    NSString *urlString = [[NSString stringWithFormat:@"http://%@/mark/model/student-model.php?", IPAddress]stringByAppendingString:inputString];    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    
     NSString *output =  [self connectToServer:request withData:inputString];
    NSMutableArray *jsonArray = [NSJSONSerialization JSONObjectWithData:[output dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    //does not work
    if([[jsonArray objectAtIndex:0] boolValue]==YES)NSLog(@"sucess");
    else{
    }    
    return jsonArray;
}
-(NSMutableArray*) selectObservationsAndOrConvos: (NSString*) studentId type:(NSString*)type lrnSkill:(NSMutableArray*)skill {
    ServerConnectionDelegate *sDelegate = [ServerConnectionDelegate alloc];
    [sDelegate setObj:self];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:studentId,@"0",type,@"1",skill,@"2",nil];
    NSData *data =[NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    NSData *jsonData = [[NSData alloc] initWithData :data];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    jsonString = [self urlEncodeValue:jsonString];
    NSString *inputString =[@"fcn=selectObservationsAndOrConvos&params=" stringByAppendingString:[NSString stringWithFormat:@"%@&sess_id=%@&is_app=1",jsonString,sessionID]];
    NSString *urlString = [[NSString stringWithFormat:@"http://%@/mark/model/communications-model.php?", IPAddress]stringByAppendingString:inputString];    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    NSString *output =   [self connectToServer:request withData:inputString];
    NSMutableArray *jsonArray = [NSJSONSerialization JSONObjectWithData:[output dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    //does not work
    if([[jsonArray objectAtIndex:0] boolValue]==YES)NSLog(@"sucess");   
    return jsonArray;
}
-(NSMutableArray*) selectAllCommunications: (NSString*) studentId{
    ServerConnectionDelegate *sDelegate = [ServerConnectionDelegate alloc];
    [sDelegate setObj:self];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:studentId,@"0",nil];
    
    NSData *data =[NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    NSData *jsonData = [[NSData alloc] initWithData :data];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    jsonString = [self urlEncodeValue:jsonString];
    NSString *inputString =[@"fcn=selectAllCommunications&params=" stringByAppendingString:[NSString stringWithFormat:@"%@&sess_id=%@&is_app=1",jsonString,sessionID]];
    NSString *urlString = [[NSString stringWithFormat:@"http://%@/mark/model/communications-model.php?", IPAddress]stringByAppendingString:inputString];    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    
    NSString *output = [self connectToServer:request withData:inputString];
    NSMutableArray *jsonArray = [NSJSONSerialization JSONObjectWithData:[output dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    //does not work
    if([[jsonArray objectAtIndex:0] boolValue]==YES)NSLog(@"sucess");
    else{
    }    
    return jsonArray;
}

-(NSString*) addObservation:(NSString*)studentId time:(NSString*)timeStamp isLearning:(NSString*)isLrn 
                explrnSkill:(NSString*)explrnSkill level:(NSString*)level text:(NSString*) inputText{
    
    ServerConnectionDelegate *sDelegate = [ServerConnectionDelegate alloc];
    [sDelegate setObj:self];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            studentId,@"0",
                            timeStamp,@"1",
                            isLrn,@"2",
                            explrnSkill,@"3",
                            level,@"4",
                            inputText,@"5",                            nil];
    NSData *data =[NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    NSData *jsonData = [[NSData alloc] initWithData :data];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    jsonString = [self urlEncodeValue:jsonString];
    NSString *inputString =[@"fcn=addObservation&params=" stringByAppendingString:[NSString stringWithFormat:@"%@&sess_id=%@&is_app=1",jsonString,sessionID]];
    NSString *urlString = [[NSString stringWithFormat:@"http://%@/mark/model/communications-model.php?", IPAddress]stringByAppendingString:inputString];    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    
    NSString *output = [self connectToServer:request withData:inputString];
    
    //implement a check to output
    if(output)NSLog(@"");
    else{
    }    
    return output;
}

-(NSString*) addConversation:(NSString*)studentId time:(NSString*)timeStamp isLearning:(NSString*)isLrn 
                 explrnSkill:(NSString*)explrnSkill level:(NSString*)level text:(NSString*) inputText{
    
    ServerConnectionDelegate *sDelegate = [ServerConnectionDelegate alloc];
    [sDelegate setObj:self];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            studentId,@"0",
                            timeStamp,@"1",
                            isLrn,@"2",
                            explrnSkill,@"3",
                            level,@"4",
                            inputText,@"5",nil];
    NSData *data =[NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    NSData *jsonData = [[NSData alloc] initWithData :data];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    jsonString = [self urlEncodeValue:jsonString];
    NSString *inputString =[@"fcn=addObservation&params=" stringByAppendingString:[NSString stringWithFormat:@"%@&sess_id=%@&is_app=1",jsonString,sessionID]];
    NSString *urlString = [[NSString stringWithFormat:@"http://%@/mark/model/communications-model.php?", IPAddress]stringByAppendingString:inputString];    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    
    NSString *output = [self connectToServer:request withData:inputString];
    
    //implement a check to output
    if(output)NSLog(@"");
    else{
    }    
    return output;
}

-(NSString*) deleteRecord:(NSString*)recordId{
    ServerConnectionDelegate *sDelegate = [ServerConnectionDelegate alloc];
    [sDelegate setObj:self];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            recordId,@"0",nil];
    NSData *data =[NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    NSData *jsonData = [[NSData alloc] initWithData :data];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    jsonString = [self urlEncodeValue:jsonString];
    NSString *inputString =[@"fcn=deleteRecord&params=" stringByAppendingString:[NSString stringWithFormat:@"%@&sess_id=%@&is_app=1",jsonString,sessionID]];
    NSString *urlString = [[NSString stringWithFormat:@"http://%@/mark/model/communications-model.php?", IPAddress]stringByAppendingString:inputString];    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    
    NSString *output = [self connectToServer:request withData:inputString];
    
    //implement a check to output
    if(output)NSLog(@"");
    else{
    }    
    return output;
}

-(NSString*) updateRecord:(NSString*)recordId time:(NSString*)timeStamp isLearning:(NSString*)isLrn 
              explrnSkill:(NSString*)explrnSkill level:(NSString*)level text:(NSString*) inputText{
    
    ServerConnectionDelegate *sDelegate = [ServerConnectionDelegate alloc];
    [sDelegate setObj:self];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            recordId,@"0",
                            timeStamp,@"1",
                            isLrn,@"2",
                            explrnSkill,@"3",
                            level,@"4",
                            inputText,@"5",nil];
    NSData *data =[NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    NSData *jsonData = [[NSData alloc] initWithData :data];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    jsonString = [self urlEncodeValue:jsonString];
    NSString *inputString =[@"fcn=updateRecord&params=" stringByAppendingString:[NSString stringWithFormat:@"%@&sess_id=%@&is_app=1",jsonString,sessionID]];
    NSString *urlString = [[NSString stringWithFormat:@"http://%@/mark/model/communications-model.php?", IPAddress]stringByAppendingString:inputString];    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    
    NSString *output = [self connectToServer:request withData:inputString];
    
    //implement a check to output
    if(output)NSLog(@"");
    else{
    }    
    return output;

}

-(NSMutableArray*) sync: (NSMutableArray*) input
{
    ServerConnectionDelegate *sDelegate = [ServerConnectionDelegate alloc];
    [sDelegate setObj:self];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:input,@"0",nil];
    NSData *data =[NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    NSData *jsonData = [[NSData alloc] initWithData :data];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    jsonString = [self urlEncodeValue:jsonString];
    NSString *inputString =[@"fcn=selectClasses&params=" stringByAppendingString:[NSString stringWithFormat:@"%@&sess_id=%@&is_app=1",jsonString,sessionID]];
    NSString *urlString = [[NSString stringWithFormat:@"http://%@/mark/model/classes-model.php?", IPAddress]stringByAppendingString:inputString];    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    NSString *output =  [self connectToServer:request withData:inputString];
    output = [output substringWithRange:NSMakeRange(1, output.length - 3)];
    NSMutableArray *jsonArray = [NSJSONSerialization JSONObjectWithData:[output dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    //does not work
    if([[jsonArray objectAtIndex:0] boolValue]==YES)NSLog(@"sucess");
    else{
    }    
    return jsonArray;

}



-(NSString*) connectToServer:(NSMutableURLRequest*) request withData:(NSString*) inputString{
    isLoaded = NO;
    ServerConnectionDelegate *sDelegate = [ServerConnectionDelegate alloc];
    [sDelegate setObj:self];
    NSData *inputData=[inputString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type: text/html; charset=UTF-8'"];
    [request setValue:[NSString stringWithFormat:@"%d",[inputString length]] forHTTPHeaderField:@"Content-length"];
    [request setHTTPBody:inputData];
        
    if(![NSURLConnection canHandleRequest:request])NSLog(@"invalid connection");
    
    [[NSURLConnection alloc] initWithRequest:request delegate:sDelegate startImmediately:YES];
    
       
    do{
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }while(!isLoaded);
    isLoaded=NO;
    
    return [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
}
-(NSString*)urlEncodeValue:(NSString *)str{
    str = (NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)str, NULL, CFSTR("?=&+"), kCFStringEncodingUTF8);
    return str;
}
-(void)dealloc {
    [super dealloc];
}

@end
