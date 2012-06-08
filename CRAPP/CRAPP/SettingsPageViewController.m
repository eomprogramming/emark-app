//
//  SettingsPageViewController.m
//  Shifmark
//
//  Created by David Huynh on 12-04-12.
//  Copyright (c) 2012 EOM. All rights reserved.
//

#import "SettingsPageViewController.h"
#import "CourseSelectionViewController.h"
#import "ClassListViewController.h"
#import "StudentInfoViewController.h"
#import "ViewController.h"
#import "COPviewerViewController.h"
#import "MenuData.h"

@interface SettingsPageViewController ()

@end

@implementation SettingsPageViewController
#define PROP_FILE_STR @"SettingsMenu"
#define ENG_INT 0
#define FREN_INT 1

-(IBAction)goBack{
   
    UIViewController *prevVC = nil;
    /*
     CourseSelectionViewController = Cours
     StudentInfoViewController = StudInfo
     ClassListViewController = Class List
     COPviewerViewController = COPview
     */
    if([backButton.accessibilityHint isEqualToString:@"Cours"]){
        prevVC = [[CourseSelectionViewController alloc]init];
        [self presentModalViewController:prevVC animated:YES];
    }
    else if([backButton.accessibilityHint isEqualToString:@"Class List"]){
        prevVC = [[ClassListViewController alloc]init];
        [self presentModalViewController:prevVC animated:YES];
        [((ClassListViewController*)prevVC)setCourseCode:helpButton.accessibilityHint];
    }
    else if([backButton.accessibilityHint isEqualToString:@"COPview"]){
        prevVC = [[COPviewerViewController alloc]init];
        [self presentModalViewController:prevVC animated:YES];
        [((COPviewerViewController*)prevVC)passExtraInfo:helpButton.accessibilityHint];
    }
    else if([backButton.accessibilityHint isEqualToString:@"StudInfo"]){
        prevVC = [[StudentInfoViewController alloc]init];
        [self presentModalViewController:prevVC animated:YES];
        [((StudentInfoViewController*)prevVC)setExtraInfo:helpButton.accessibilityHint];
    }
    //    [self removeFromParentViewController];
    [prevVC release];
}

-(void)setPrevMenu:(NSString*)name{
//     = name;
    backButton.accessibilityHint = name;
}

-(void)passExtraVCinfo:(NSString *)params{
    helpButton.accessibilityHint = params;
}

-(IBAction)changePwd{
    UIAlertView *current = [[UIAlertView alloc] initWithTitle:@"Password Confirmation" message:@"Please enter your current password." delegate:nil cancelButtonTitle:@"Submit" otherButtonTitles:nil];
    current.alertViewStyle = UIAlertViewStylePlainTextInput;
    [current show];
    [current release];
    
    UIAlertView *new = [[UIAlertView alloc]initWithTitle:@"New Password" message:@"Please enter your new password" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    new.alertViewStyle = UIAlertViewStyleSecureTextInput;
    [new show];
    [new release];
    
    UIAlertView *confirmation = [[UIAlertView alloc]initWithTitle:@"Confirm Password" message:@"Please confirm your password" delegate:nil cancelButtonTitle:@"Confirm" otherButtonTitles:nil];
    confirmation.alertViewStyle = UIAlertViewStyleSecureTextInput;
    [confirmation show];
    [confirmation release];
    
}

-(IBAction)logout{
    ViewController *main = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    [self presentModalViewController:main animated:YES];
    [main release];
}

-(IBAction)createNewPassword{
    
}

-(IBAction)switchLang{
    if(langSegCont.selectedSegmentIndex==ENG_INT)
        [self switchToEng];
    else if(langSegCont.selectedSegmentIndex==FREN_INT)
        [self switchToFr];
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
//    
    menuObjects = [[NSMutableArray alloc]init];
    [menuObjects addObject:titleLabel];
    [menuObjects addObject:autoUpdateLabel];
    [menuObjects addObject:updateSegCont];
    [menuObjects addObject:colBlindLabel];
    [menuObjects addObject:colBlindSegCont];
    [menuObjects addObject:changePwdButton];
    [menuObjects addObject:udpateButton];
    [menuObjects addObject:helpButton];
    [menuObjects addObject:logoutButton];
    
    textOnMenu = [MenuData readFile:PROP_FILE_STR];
    
    if(1+1==2)
        [self switchToFr]; 
    
//    [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStyleBordered target:nil action:nil]; 
    
    // Do any additional setup after loading the view from its nib.
}

-(void)switchToEng{
    for(int i=0; i<[menuObjects count]; i++){
        for (int j=0; j<[textOnMenu count]; j++) {
            if([[menuObjects objectAtIndex:i] isKindOfClass:[UIBarButtonItem class]]){
                if([((UIBarButtonItem*)[menuObjects objectAtIndex:i]).title rangeOfString:[[textOnMenu objectAtIndex:j]substringFromIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location+1]].location<=[((UIBarButtonItem*)[menuObjects objectAtIndex:i]).title length]){
                    [((UIBarButtonItem*)[menuObjects objectAtIndex:i])setTitle:[((UIBarButtonItem*)[menuObjects objectAtIndex:i]).title stringByReplacingOccurrencesOfString:[[textOnMenu objectAtIndex:j]substringFromIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location+1] withString:[[textOnMenu objectAtIndex:j]substringToIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location]]];
                    j = [textOnMenu count];
                }
            }
            else if([[menuObjects objectAtIndex:i]isKindOfClass:[UISegmentedControl class]]){
                for(int k =0; k<((UISegmentedControl*)[menuObjects objectAtIndex:i]).numberOfSegments; k++){
                    if ([[((UISegmentedControl*)[menuObjects objectAtIndex:i]) titleForSegmentAtIndex:k] isEqual:[[textOnMenu objectAtIndex:j]substringFromIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location+1]]) {
                        [((UISegmentedControl*)[menuObjects objectAtIndex:i]) setTitle:
                         [[((UISegmentedControl*)[menuObjects objectAtIndex:i]) titleForSegmentAtIndex:k]stringByReplacingOccurrencesOfString:
                          [[textOnMenu objectAtIndex:j]substringFromIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location+1] withString:[[textOnMenu objectAtIndex:j]substringToIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location]] forSegmentAtIndex:k];
                    }
                }
            }
            else if([[menuObjects objectAtIndex:i] isKindOfClass:[UIButton class]]){
                if([((UIButton*)[menuObjects objectAtIndex:i]).titleLabel.text rangeOfString:[[textOnMenu objectAtIndex:j]substringFromIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location+1]].location<=[((UIButton*)[menuObjects objectAtIndex:i]).titleLabel.text length]){
                    [((UIButton*)[menuObjects objectAtIndex:i])setTitle:[((UIButton*)[menuObjects objectAtIndex:i]).titleLabel.text stringByReplacingOccurrencesOfString:[[textOnMenu objectAtIndex:j]substringFromIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location+1] withString:[[textOnMenu objectAtIndex:j]substringToIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location]] forState:((UIButton*)[menuObjects objectAtIndex:i]).state];
                    j = [textOnMenu count];
                }
            }
            else if([[menuObjects objectAtIndex:i] isKindOfClass:[UILabel class]]){
                if([((UILabel*)[menuObjects objectAtIndex:i]).text rangeOfString:[[textOnMenu objectAtIndex:j]substringFromIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location+1]].location<=[((UILabel*)[menuObjects objectAtIndex:i]).text length]){
                    ((UILabel*)[menuObjects objectAtIndex:i]).text = [((UILabel*)[menuObjects objectAtIndex:i]).text stringByReplacingOccurrencesOfString:[[textOnMenu objectAtIndex:j]substringFromIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location+1] withString:[[textOnMenu objectAtIndex:j]substringToIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location]];
                    j = [textOnMenu count];
                }
            }
        }
    }
}

-(void)switchToFr{
    for(int i=0; i<[menuObjects count]; i++){
        for (int j=0; j<[textOnMenu count]; j++) {
            if([[menuObjects objectAtIndex:i] isKindOfClass:[UIBarButtonItem class]]){
                if([((UIBarButtonItem*)[menuObjects objectAtIndex:i]).title rangeOfString:[[textOnMenu objectAtIndex:j]substringToIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location]].location<=[((UIBarButtonItem*)[menuObjects objectAtIndex:i]).title length]){
                    [((UIBarButtonItem*)[menuObjects objectAtIndex:i])setTitle:[((UIBarButtonItem*)[menuObjects objectAtIndex:i]).title stringByReplacingOccurrencesOfString:[[textOnMenu objectAtIndex:j]substringToIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location] withString:[[textOnMenu objectAtIndex:j]substringFromIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location+1]]];
                    j = [textOnMenu count];
                }
            }
            else if([[menuObjects objectAtIndex:i]isKindOfClass:[UISegmentedControl class]]){
                for(int k =0; k<((UISegmentedControl*)[menuObjects objectAtIndex:i]).numberOfSegments; k++){
                    if ([[((UISegmentedControl*)[menuObjects objectAtIndex:i]) titleForSegmentAtIndex:k] isEqual:[[textOnMenu objectAtIndex:j]substringToIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location]]) {
                        [((UISegmentedControl*)[menuObjects objectAtIndex:i]) setTitle:
                         [[((UISegmentedControl*)[menuObjects objectAtIndex:i]) titleForSegmentAtIndex:k]stringByReplacingOccurrencesOfString:
                        [[textOnMenu objectAtIndex:j]substringToIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location] withString:[[textOnMenu objectAtIndex:j]substringFromIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location+1]] forSegmentAtIndex:k];
                    }
                }
            }
            else if([[menuObjects objectAtIndex:i] isKindOfClass:[UIButton class]]){
                if([((UIButton*)[menuObjects objectAtIndex:i]).titleLabel.text rangeOfString:[[textOnMenu objectAtIndex:j]substringToIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location]].location<=[((UIButton*)[menuObjects objectAtIndex:i]).titleLabel.text length]){
                    [((UIButton*)[menuObjects objectAtIndex:i])setTitle:[((UIButton*)[menuObjects objectAtIndex:i]).titleLabel.text stringByReplacingOccurrencesOfString:[[textOnMenu objectAtIndex:j]substringToIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location] withString:[[textOnMenu objectAtIndex:j]substringFromIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location+1]] forState:((UIButton*)[menuObjects objectAtIndex:i]).state];
                    j = [textOnMenu count];
                }
            }
            else if([[menuObjects objectAtIndex:i] isKindOfClass:[UILabel class]]){
                if([((UILabel*)[menuObjects objectAtIndex:i]).text rangeOfString:[[textOnMenu objectAtIndex:j]substringToIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location]].location<=[((UILabel*)[menuObjects objectAtIndex:i]).text length]){
                    ((UILabel*)[menuObjects objectAtIndex:i]).text = [((UILabel*)[menuObjects objectAtIndex:i]).text stringByReplacingOccurrencesOfString:[[textOnMenu objectAtIndex:j]substringToIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location] withString:[[textOnMenu objectAtIndex:j]substringFromIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location+1]];
                    j = [textOnMenu count];
                }
            }
        }
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [super release];
    [self release];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
