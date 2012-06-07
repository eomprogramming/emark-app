//
//  COPviewerViewController.m
//  Shifmark
//
//  Created by David Huynh on 12-05-14.
//  Copyright (c) 2012 EOM. All rights reserved.
//

#import "COPviewerViewController.h"
#import "SettingsPageViewController.h"
#import "ViewController.h"
#import "COPsubmittingViewController.h"
#import "StudentInfoViewController.h"
#import "ExpSelectionViewController.h"
#import "MenuData.h"
@interface COPviewerViewController ()

@end

@implementation COPviewerViewController
@synthesize expectation;
#define PROP_FILE_STR @"COPviewerMenu"
#define ALL_EXP_NUM @"999"
-(IBAction)goBack{
    
    StudentInfoViewController *studInfo = [[StudentInfoViewController alloc]init];
    [self presentModalViewController:studInfo animated:YES];
   [studInfo setExtraInfo:[NSString stringWithFormat:@"Course:%@Student:%@",[nameCourse.title substringWithRange:NSMakeRange([nameCourse.title rangeOfString:@"("].location+1,[nameCourse.title length]-2-[nameCourse.title rangeOfString:@"("].location)],[nameCourse.title substringWithRange:NSMakeRange(0,[nameCourse.title rangeOfString:@" ("].location)]]];
    [studInfo release];
}

- (IBAction) goToSettings{
    SettingsPageViewController *settings = [[SettingsPageViewController alloc]init];
    [self presentModalViewController:settings animated:YES];
    [settings setPrevMenu:@"COPview"];
    NSString *expNum = expectNum.title;
    if([expectNum.title rangeOfString:@" "].location>[expectNum.title length])
        expNum = ALL_EXP_NUM;
    else
        expNum = [expNum substringFromIndex:[expNum rangeOfString:@" "].location+1];
    [settings passExtraVCinfo:[NSString stringWithFormat:@"Course:%@Student:%@CommunicationType:%@Expectation:%@",[nameCourse.title substringWithRange:NSMakeRange([nameCourse.title rangeOfString:@"("].location+1,[nameCourse.title length]-2-[nameCourse.title rangeOfString:@"("].location)],[nameCourse.title substringWithRange:NSMakeRange(0,[nameCourse.title rangeOfString:@" ("].location)],communiType.title,expNum]];
    [settings release];
}

-(IBAction)logout{
    ViewController *main = [[ViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:nil];
    [self presentModalViewController:main animated:YES];
    [main release];
}


-(IBAction)addNewCommunication{
    COPsubmittingViewController *submission = [[COPsubmittingViewController alloc]init];
    [self presentModalViewController:submission animated:YES];
    [submission passExtraInfo:[NSString stringWithFormat:@"Course:%@Student:%@CommunicationType:%@Expectation:%@",[nameCourse.title substringWithRange:NSMakeRange([nameCourse.title rangeOfString:@"("].location+1,[nameCourse.title length]-2-[nameCourse.title rangeOfString:@"("].location)],[nameCourse.title substringWithRange:NSMakeRange(0,[nameCourse.title rangeOfString:@" ("].location)],communiType.title,expectNum.title]];
    [submission release];
}

-(IBAction)viewOldCommunication:(UIButton*)sender{
    
}

-(IBAction)selectExpectation{
    ExpSelectionViewController *expSel = [[ExpSelectionViewController alloc]init];
    [self presentModalViewController:expSel animated:YES];
    NSString *expNum = expectNum.title;
    
    if([expectNum.title rangeOfString:@" "].location>[expectNum.title length])
        expNum = ALL_EXP_NUM;
    else
        expNum = [expNum substringFromIndex:5];
    
    [expSel passExtraInfo:[NSString stringWithFormat:@"Course:%@Student:%@CommunicationType:%@Expectation:%@",[nameCourse.title substringWithRange:NSMakeRange([nameCourse.title rangeOfString:@"("].location+1,[nameCourse.title length]-2-[nameCourse.title rangeOfString:@"("].location)],[nameCourse.title substringWithRange:NSMakeRange(0,[nameCourse.title rangeOfString:@" ("].location)],communiType.title,expNum]];
    [expSel release];
}

-(void)passExtraInfo:(NSString *)info{
    // Course:MPM2D.-09Student:Siros,AminiCommunicationType:Observations
    nameCourse.title = [[info substringWithRange:NSMakeRange([info rangeOfString:@"Student:"].location+8, [info rangeOfString:@"CommunicationType"].location-[info rangeOfString:@"Student:"].location-8)] stringByAppendingString:[NSString stringWithFormat:@" (%@)",[info substringWithRange:NSMakeRange([info rangeOfString:@":"].location+1, [info rangeOfString:@"Student"].location-[info rangeOfString:@":"].location-1)]]];
    communiType.title = [@"" stringByAppendingString:[info substringWithRange:NSMakeRange([info rangeOfString:@"CommunicationType:"].location+18,[info rangeOfString:@"Expectation:"].location-[info rangeOfString:@"CommunicationType:"].location-18)]];
    expectNum.title = [NSString stringWithFormat:@"%@",[info substringFromIndex:[info rangeOfString:@"Expectation:"].location+12]];
    
    if([expectNum.title integerValue]==999)
        expectNum.title = @"ALL";
    else
        expectNum.title = [NSString stringWithFormat:@"Exp %@",expectNum.title];
    if(1+1==2)
        [self switchToFr];
}

-(void)switchToFr{
    NSMutableArray *menuObjects = [[NSMutableArray alloc]init];
    [menuObjects addObject:communiType];
    [menuObjects addObject:help];
    [menuObjects addObject:settingsButton];
    [menuObjects addObject:logoutButton];
    [menuObjects addObject:expectNum];
    
    NSMutableArray *textOnMenu = [MenuData readFile:PROP_FILE_STR];
    
    for(int i=0; i<[menuObjects count]; i++){
        for (int j=0; j<[textOnMenu count]; j++) {
            if([((UIBarButtonItem*)[menuObjects objectAtIndex:i]).title rangeOfString:[[textOnMenu objectAtIndex:j]substringToIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location]].location<=[((UIBarButtonItem*)[menuObjects objectAtIndex:i]).title length]){
                [((UIBarButtonItem*)[menuObjects objectAtIndex:i])setTitle:[((UIBarButtonItem*)[menuObjects objectAtIndex:i]).title stringByReplacingOccurrencesOfString:[[textOnMenu objectAtIndex:j]substringToIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location] withString:[[textOnMenu objectAtIndex:j]substringFromIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location+1]]];
            }            
        }
    }
    [menuObjects removeAllObjects];
    [menuObjects release];
    [textOnMenu removeAllObjects];
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
