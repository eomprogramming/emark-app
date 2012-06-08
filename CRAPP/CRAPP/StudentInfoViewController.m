//
//  StudentInfoViewController.m
//  Shifmark
//
//  Created by David Huynh on 12-04-12.
//  Copyright (c) 2012 EOM. All rights reserved.
//
//

#import "StudentInfoViewController.h"
#import "SettingsPageViewController.h"
#import "ViewController.h"
#import "ClassListViewController.h"
#import "COPviewerViewController.h"
#import "MenuData.h"
@interface StudentInfoViewController ()

@end

@implementation StudentInfoViewController
#define PROP_FILE_STR @"StudentInfoMenu"

- (IBAction) goToSettings{
    SettingsPageViewController *settings = [[SettingsPageViewController alloc]init];
    [self presentModalViewController:settings animated:YES];
    [settings setPrevMenu:@"StudInfo"];
    [settings passExtraVCinfo:[NSString stringWithFormat:@"Course:%@Student:%@",course.title,studentName.title]];
    [settings release];
}

-(IBAction)logout{
    ViewController *main = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    [self presentModalViewController:main animated:YES];
    [main release];
}

-(IBAction)goToCommunications:(UIButton*)sender{
    COPviewerViewController *viewExp = [[COPviewerViewController alloc]init];
    [self presentModalViewController:viewExp animated:YES];
    [viewExp passExtraInfo:[NSString stringWithFormat:@"Course:%@Student:%@CommunicationType:%@Expectation:999",course.title,studentName.title,sender.titleLabel.text]];
    [viewExp release];
}

-(IBAction)goBack{
    ClassListViewController *classList = [[ClassListViewController alloc]init];
    [self presentModalViewController:classList animated:YES];
    [classList setCourseCode:course.title];
    [classList release];
}

-(void)setExtraInfo:(NSString*)info{
    course.title = [info substringWithRange:NSMakeRange([info rangeOfString:@":"].location+1, [info rangeOfString:@"Student:"].location-[info rangeOfString:@":"].location-1)];
    studentName.title = [info substringWithRange:NSMakeRange([info rangeOfString:@"Student:"].location+8, [info length]-[info rangeOfString:@"Student:"].location-8)];
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
    // Do any additional setup after loading the view from its nib.
    
    if(1+1==2){
        NSMutableArray *menuObjects = [[NSMutableArray alloc]init];
        [menuObjects addObject:products];
        [menuObjects addObject:help];
        [menuObjects addObject:settingsButton];
        [menuObjects addObject:logoutButton];
        
        NSMutableArray *textOnMenu = [MenuData readFile:PROP_FILE_STR];
        
        for(int i=0; i<[menuObjects count]; i++){
            for (int j=0; j<[textOnMenu count]; j++) {
                if([[menuObjects objectAtIndex:i] isKindOfClass:[UIBarButtonItem class]]){
                    if([((UIBarButtonItem*)[menuObjects objectAtIndex:i]).title isEqual:[[textOnMenu objectAtIndex:j]substringToIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location]]){
                        [((UIBarButtonItem*)[menuObjects objectAtIndex:i])setTitle:[((UIBarButtonItem*)[menuObjects objectAtIndex:i]).title stringByReplacingOccurrencesOfString:[[textOnMenu objectAtIndex:j]substringToIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location] withString:[[textOnMenu objectAtIndex:j]substringFromIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location+1]]];
                    }
                }
                else if([[menuObjects objectAtIndex:i] isKindOfClass:[UIButton class]]){
                    if([((UIButton*)[menuObjects objectAtIndex:i]).titleLabel.text isEqual:[[textOnMenu objectAtIndex:j]substringToIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location]]){
                        [((UIButton*)[menuObjects objectAtIndex:i])setTitle:[((UIButton*)[menuObjects objectAtIndex:i]).titleLabel.text stringByReplacingOccurrencesOfString:[[textOnMenu objectAtIndex:j]substringToIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location] withString:[[textOnMenu objectAtIndex:j]substringFromIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location+1]] forState:((UIButton*)[menuObjects objectAtIndex:i]).state];
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
