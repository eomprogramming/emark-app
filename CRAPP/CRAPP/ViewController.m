//
//  ViewController.m
//  Shifmark
//
//  Created by David Huynh on 12-04-11.
//  Copyright (c) 2012 EOM. All rights reserved.
//

#import "ViewController.h"
#import "MenuData.h"
#import "CourseSelectionViewController.h"
#import "AccCreationViewController.h"
#import "User.h"
#import "PwdRecovViewController.h"
#import "ServerConnection.h"
#import "Classroom.h"
#import "Student.h"
#import "Communication.h"
#import "Expectation.h"

@interface ViewController ()

@end

@implementation ViewController
-(IBAction)login{
//    printf(userField.text);
    /*
     * k, so what we need to do here:
     * - Check user / password combination (if wrong, display alert, then return to the current menu, but block it out)
     */
    
//    NSString *msg = [[NSString alloc]initWithString:@"MUHAHAHA! We have your password, and it is "];
//    msg = [msg stringByAppendingFormat:pwdField.text];
//    
//    UIAlertView *muhaha = [[UIAlertView alloc]initWithTitle:@"Password" message: msg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//    [muhaha show];
////    [msg release];
//    [muhaha release];
    
    if([userField.text isEqualToString:@"C12345"]&&[pwdField.text isEqualToString:@"12345"]){
        CourseSelectionViewController *courses = [[CourseSelectionViewController alloc]initWithNibName: nil bundle: nil];
        [self presentModalViewController:courses animated:YES];
        //    [courses test];
        [courses release];   
    }
    else if([userField.text length]==0 || [pwdField.text length]==0){
        UIAlertView *blank = [[UIAlertView alloc]initWithTitle:@"Error•Erreur" message:@"Please enter your username and password. Veuillez entrer votre nom d'utilisateur et mot the passe." delegate:self cancelButtonTitle:@"OK•D'accord" otherButtonTitles: nil];
        [blank show];
        [blank release];
    }
    else{
        UIAlertView *invalidPwd = [[UIAlertView alloc]initWithTitle:@"Error•Erreur" message:@"Oops! Your username and password combination do not match. Désolé, le mot de passe entré n'est pas égal à celle du compte." delegate:self cancelButtonTitle:@"OK•D'accord" otherButtonTitles: nil];
        [invalidPwd show];
        [invalidPwd release];
    }
     
    //ExpectationViewController *expC = [[ExpectationViewController alloc]initWithNibName:nil bundle:nil];
    //[self presentModalViewController:expC animated:YES];
    
}

//-(IBAction)pwdRecovery{
//    //printf([[forgotPwdButton titleLabel]text]);
//    /*
//     * Send email, then show pop up.
//     */
//    UIAlertView *sentEmail = [[UIAlertView alloc] initWithTitle:@"Password Recovery" message:@"A new password has been sent to you. Please try logging again with the new password." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [sentEmail show];
//    [sentEmail release];
//}
//
//-(IBAction)pwdRecoveryFr{
//    UIAlertView *sentEmail = [[UIAlertView alloc] initWithTitle:@"Nouveau mot de passe" message:@"Nous avons vous envoyer un courriel avec votre nouveau mot de passe. Veuillez réessayer la connexion encore, avec le nouveau mot de passe." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [sentEmail show];
//    [sentEmail release];
//}

-(IBAction)putKeyboardDown{
    if(userField.resignFirstResponder == NO)
        [userField resignFirstResponder];
    if(pwdField.resignFirstResponder ==NO)
        [pwdField resignFirstResponder];
}

-(IBAction)signUp{
    AccCreationViewController *signup = [[AccCreationViewController alloc]init];
    [self presentModalViewController:signup animated:YES];
    [signup release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    ServerConnection *connection = [[ServerConnection alloc]init];
    [connection login:@"12345" withPwd:@""];
    NSMutableArray *output = [connection selectClasses:connection.staffID];
    [output removeObjectAtIndex:0];
    
    // Generate the path to the new directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *eMarkPATH = [NSString stringWithFormat:@"%@/eMarking/C12345", [paths objectAtIndex:0]];    
    
    //array of Courses semester sorted, the master array has all them
    NSMutableArray *masterCourseList = [[NSMutableArray alloc]init];
    NSMutableArray *s1courseList = [[NSMutableArray alloc]init];
    NSMutableArray *s2courseList = [[NSMutableArray alloc]init];
    
    for(int i =0; i<[[output objectAtIndex:0] count];i++){
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docDirectory = [paths objectAtIndex:0]; 
        NSLog(@"%@", docDirectory);
        Classroom *c = [[Classroom alloc]initWithArray:[[output objectAtIndex:0]objectAtIndex:i] andPathname:[NSString stringWithFormat:@"%@/Library/eMarking/",docDirectory]];
        
        [masterCourseList addObject:c];
                                    
        
        if([[[masterCourseList objectAtIndex:i]getSemester] isEqual:@"1"])
        {
            [s1courseList addObject:[masterCourseList objectAtIndex:i]];
            NSLog(@"added s1 for cycle %i", i);
        }
        
        if([[[masterCourseList objectAtIndex:i]getSemester] isEqual:@"2"])
        {
            [s2courseList addObject:[masterCourseList objectAtIndex:i]];
            NSLog(@"added s2 for cycle %i", i);
        }
        
    }
    //array of students 
    output = [connection selectStudentsByCourses:[[s1courseList objectAtIndex:0]getId]];
    [output removeObjectAtIndex:0];
    NSMutableArray  *studentList = [[NSMutableArray alloc]init];
    for(int i =0; i<[[output objectAtIndex:0] count];i++){
        [studentList addObject:[[Student alloc]initWithArray:[[output objectAtIndex:0]objectAtIndex:i] andPathname:@"/KINGSTON"]];
    }
    
    //[connection addConversation:@"1" time:@"1" isLearning:@"1" explrnSkill:@"1" level:@"1" text:@"hi"];
    
    //array of communications for a student
    output = [connection selectAllCommunications:[[studentList objectAtIndex:0]getId]];
    [output removeObjectAtIndex:0];
    
    NSMutableArray  *communicationsList = [[NSMutableArray alloc]init];
    for(int i =0; i<[[output objectAtIndex:0] count];i++){
        [communicationsList addObject:[[Communication alloc]initWithArray:[[output objectAtIndex:0]objectAtIndex:i] andPathname:@"KINGSTON"]];
    }
    
    
    
    

    //make courses directory
    for(int i=0; i<[masterCourseList count];i++){
        Classroom *c = [masterCourseList objectAtIndex:i];
        NSString *newFolder = [NSString stringWithFormat:@"/%@/%@",eMarkPATH,[c getId]];
        [c setPathname:newFolder];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:newFolder]) {
            // Directory does not exist so create it
            [[NSFileManager defaultManager] createDirectoryAtPath:newFolder withIntermediateDirectories:YES attributes:nil error:nil];
        }
        [c saveData];
    }
    //array of course expectations and saving them
    for(int i =0;i<[masterCourseList count];i++){
    output = [connection selectExpectationsByCourses:[[masterCourseList objectAtIndex:i]getId]];
    [output removeObjectAtIndex:0];
    output = [output objectAtIndex:0];
    NSMutableArray *names = [[NSMutableArray alloc]init];
    NSMutableArray *Ids = [[NSMutableArray alloc]init];
    
        for(int i = 0; i<[output count];i++){
        [names addObject:[[output objectAtIndex:i]objectAtIndex:0]];
        [names addObject:[[output objectAtIndex:i]objectAtIndex:1]];
        }
    
        [Expectation writeClassExpectations:[NSString stringWithFormat:@"/%@/%@",eMarkPATH,[[masterCourseList objectAtIndex:i] getId]] andIdentifiers:Ids andNames:names];
    }
    //creating student directories
    for(int i = 0;i<[masterCourseList count];i++){
        output = [connection selectStudentsByCourses:[[masterCourseList objectAtIndex:i] getId]];
        [output removeObjectAtIndex:0];
        output = [output objectAtIndex:0];
        for(int i =0;i<[output count];i++){
            [[[NSFileManager defaultManager]createDirectoryAtPath:[NSString stringWithFormat@"/%@/%@/%@",eMarkPATH,[[masterCourseList objectAtIndex:i] getId],[[output objectAtIndex:i] getId]]];
    
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

-(IBAction)pwdRecov{
    PwdRecovViewController *pwdRec = [[PwdRecovViewController alloc]init];
    [self presentModalViewController:pwdRec animated:YES];
    [pwdRec release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
   
}

@end
