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
    
    NSMutableArray *a = [[[NSMutableArray alloc]init]autorelease];
    [a addObject:@"Settings/Paramètres"];
    [a addObject:@"Auto-Update/Mise à jour automatique"];
    [a addObject:@"Auto/Auto"];
    [a addObject:@"Manual/Manuel"];
    [a addObject:@"Colour Blind Version/Version Daltonien"];
    [a addObject:@"Colour Blind/Daltonien"];
    [a addObject:@"Normal/Normale"];
    [a addObject:@"Change password/Changer mot de passe"];
    [a addObject:@"Update/Mettre à jour"];
    [a addObject:@"Help/Aide"];
    [a addObject:@"Logout/Déconnexion"];
    [IO writeToFile:@"SettingsMenu" andData:a];
    
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