//
//  ClassListViewController.m
//  Shifmark
//
//  Created by David Huynh on 12-04-12.
//  Copyright (c) 2012 EOM. All rights reserved.
//

#import "ClassListViewController.h"
#import "SettingsPageViewController.h"
#import "CourseSelectionViewController.h"
#import "ViewController.h"
#import "StudentInfoViewController.h"
#import "MenuData.h"
@interface ClassListViewController ()

@end

@implementation ClassListViewController
#define PROP_FILE_STR @"ClassListMenu"

- (IBAction) goToSettings{
    SettingsPageViewController *settings = [[SettingsPageViewController alloc]init];
    [self presentModalViewController:settings animated:YES];
    [settings setPrevMenu:@"Class List"];
    [settings passExtraVCinfo:[titleLabel.title substringFromIndex:[titleLabel.title rangeOfString:@" " options:NSBackwardsSearch].location+1]];
    [settings release];
}

-(IBAction)logout{
    ViewController *main = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    [self presentModalViewController:main animated:YES];
    [main release];
}

-(IBAction)goBack{
    CourseSelectionViewController *courses = [[CourseSelectionViewController alloc]init];
    [self presentModalViewController:courses animated:YES];
    [courses release];
}

-(void)goToStudentInfo:(UIButton*)sender{
    StudentInfoViewController *studInfo = [[StudentInfoViewController alloc]init];
    [self presentModalViewController:studInfo animated:YES];
    [studInfo setExtraInfo:[NSString stringWithFormat:@"Course:%@Student:%@",[titleLabel.title substringFromIndex:[titleLabel.title rangeOfString:@" " options:NSBackwardsSearch].location+1],sender.titleLabel.text]];
    [studInfo release];
}

-(void)setCourseCode:(NSString*)courseCode{
    titleLabel.title = [titleLabel.title stringByAppendingString:courseCode];
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
    NSMutableArray *students = [[[NSMutableArray alloc]init]autorelease];
    [students addObject:@"Amini, Siros"];
    [students addObject:@"Bortnowski, Andrea"];
    [students addObject:@"Clark, Trish"];
    [students addObject:@"Damjanschitz, Zsuzsanna"];
    [students addObject:@"Farmer, CJ"];
    [students addObject:@"Gemmell, Robert"];
    [students addObject:@"Hill, Kelly"];
    [students addObject:@"Inman, Gyro"];
    [students addObject:@"Jamieson, Linda"];
    [students addObject:@"Kelly, William"];
    [students addObject:@"Lecuyer, Adam"];
    
    
    if(1+1==2){
        NSMutableArray *menuObjects = [[NSMutableArray alloc]init];
        [menuObjects addObject:titleLabel];
        [menuObjects addObject:helpButton];
        [menuObjects addObject:settingsButton];
        [menuObjects addObject:logoutButton];
        
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
    
    classListTableView.bounds = CGRectMake(0,0,320,[students count]*40);
    [classListScrollView setContentSize:CGSizeMake(320,[students count]*40)];
    classListScrollView.showsVerticalScrollIndicator = YES;
    for(int i=0; i<[students count]; i++){
        UIButton *student = [[UIButton buttonWithType:UIButtonTypeCustom]retain];
        student.frame = CGRectMake(0,i*40,315,40);
        student.bounds = CGRectMake(0,0,315,40);
        [student setTitleColor:[UIColor yellowColor] forState:student.state];
        
        if(i%2==0)
            student.backgroundColor = [[UIColor alloc]initWithRed:81/255.0 green:0 blue:77/255.0 alpha:1];
        else
            student.backgroundColor = [[UIColor alloc]initWithRed:198/255.0 green:144/255.0 blue:195/255.0 alpha:1];
        
        [student setTitle:[students objectAtIndex:i] forState:student.state];
        student.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [student addTarget:self action:@selector(goToStudentInfo:) forControlEvents:UIControlEventTouchDown];
        
        [classListScrollView addSubview:student];
        //         [student release];
        
    }
    
//    titleLabel.title = course;
//    self.navigationItem.title = [@"Class List for " stringByAppendingFormat:courseCode];
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
