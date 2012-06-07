//
//  CourseSelectionViewController.m
//  Shifmark
//
//  Created by David Huynh on 12-04-11.
//  Copyright (c) 2012 EOM. All rights reserved.
//
//

#import "CourseSelectionViewController.h"
#import "SettingsPageViewController.h"
#import "ClassListViewController.h"
#import "ViewController.h"
#import "MenuData.h"
@interface CourseSelectionViewController ()

@end

@implementation CourseSelectionViewController
#define PROP_FILE_STR @"CourseSelectionMenu"

- (IBAction) goToSettings{
    SettingsPageViewController *settings = [[SettingsPageViewController alloc]init];
    [self presentModalViewController:settings animated:YES];
    [settings setPrevMenu:@"Cours"];
    [settings release];
}

-(IBAction)logout{
    ViewController *main = [[ViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:nil];
    [self presentModalViewController:main animated:YES];
    [main release];
}

-(IBAction)getClassList:(id)sender{
    
    ClassListViewController *classList = [[ClassListViewController alloc]init];
    [self presentModalViewController:classList animated:YES];
    [classList setCourseCode:((UIButton *)sender).currentTitle];
    [classList release];
}

-(IBAction)changeSemester{
    if(semesterChanger.selectedSegmentIndex == 0){
        [courseOneButton setTitle:@"ICS2O.-01" forState:courseOneButton.state];
        [courseTwoButton setTitle:@"ICS3U.-01" forState:courseTwoButton.state];
        [courseThreeButton setTitle:@"MPM2D.-04" forState:courseThreeButton.state];
    }
    else{
        [courseOneButton setTitle:@"MPM2D.-09" forState:courseOneButton.state];
        [courseTwoButton setTitle:@"MPM2D.-07" forState:courseTwoButton.state];
        [courseThreeButton setTitle:@"ICS4U.-01" forState:courseThreeButton.state];
    }
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
    [courseOneButton setTitle:@"ICS2O.-01" forState:courseOneButton.state];
    [courseTwoButton setTitle:@"ICS3U.-01" forState:courseTwoButton.state];
    [courseThreeButton setTitle:@"MPM2D.-04" forState:courseThreeButton.state];
    
    if(1+1==2){
        
        NSMutableArray *menuObjects = [[NSMutableArray alloc]init];
        [menuObjects addObject:titleLabel];
        [menuObjects addObject:helpButton];
        [menuObjects addObject:settingsButton];
        [menuObjects addObject:logoutButton];
        [menuObjects addObject:semesterChanger];
        
        NSMutableArray *textOnMenu = [MenuData readFile:PROP_FILE_STR];
        
        for(int i=0; i<[menuObjects count]; i++){
            for (int j=0; j<[textOnMenu count]; j++) {
                if([[menuObjects objectAtIndex:i] isKindOfClass:[UIBarButtonItem class]]){
                    if([((UIBarButtonItem*)[menuObjects objectAtIndex:i]).title isEqual:[[textOnMenu objectAtIndex:j]substringToIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location]]){
                        [((UIBarButtonItem*)[menuObjects objectAtIndex:i])setTitle:[((UIBarButtonItem*)[menuObjects objectAtIndex:i]).title stringByReplacingOccurrencesOfString:[[textOnMenu objectAtIndex:j]substringToIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location] withString:[[textOnMenu objectAtIndex:j]substringFromIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location+1]]];
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
            }
        }
        [menuObjects removeAllObjects];
        [menuObjects release];
        [textOnMenu removeAllObjects];
    }
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

@end
