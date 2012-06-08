//
//  AccCreationViewController.m
//  Shifmark
//
//  Created by David Huynh on 12-05-19.
//  Copyright (c) 2012 EOM. All rights reserved.
//

#import "AccCreationViewController.h"

@interface AccCreationViewController ()

@end

@implementation AccCreationViewController

-(IBAction)createUser{
    // CHECK TO SEE IF THE USER EXISTS ALREADY, IF NOT CHECK TO SEE IF THE PASSWORDS MATCH
    UIAlertView *alert = nil;
    if([password.text isEqualToString:conPassword.text]&&[password.text length]>0&&[username.text length]==0&&[username.text characterAtIndex:0]=='C')
        alert = [[UIAlertView alloc]initWithTitle:@"Thank you!•Merci!" message:@"Thank you for making an account! Your account is ready to use, and requires a restart. Merci pour avoir créer un compte! Votre compte est prêt à utiliser, mais un recommencement est requis." delegate:self cancelButtonTitle:@"OK•D'accord" otherButtonTitles:nil];
    else 
        alert = [[UIAlertView alloc]initWithTitle:@"Error•Erreur" message:@"Oops! Your password does not match with the confirmation passowrd. Désolé, votre mot de passe n'est pas égal avec votre mot de passe de confirmation." delegate:self cancelButtonTitle:@"OK•D'accord" otherButtonTitles:nil];
    [alert show];
    [alert release];
//    exit(0);
}

-(IBAction)putKeyboardDown{
    if(username.resignFirstResponder == YES)
        [username resignFirstResponder];
    else if(password.resignFirstResponder==YES)
        [password resignFirstResponder];
    else if(conPassword.resignFirstResponder==YES)
        [conPassword resignFirstResponder];
    else if(secQuest.resignFirstResponder==YES)
        [secQuest resignFirstResponder];
    else
        [secAns resignFirstResponder];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [scrollView setScrollEnabled:YES];
    scrollView.frame = CGRectMake(0,44,320,220);
    scrollView.bounds = CGRectMake(0,0,320,220);
    [scrollView setContentSize:CGSizeMake(310, 375)];
    scrollView.showsVerticalScrollIndicator = YES;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([alertView.title isEqualToString:@"Thank you!•Merci!"]) {
        //CREATE NEW USER HERE!
        exit(0);
    }
}

@end
