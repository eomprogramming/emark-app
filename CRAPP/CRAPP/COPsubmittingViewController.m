//
//  COPsubmittingViewController.m
//  Shifmark
//
//  Created by David Huynh on 12-05-14.
//  Copyright (c) 2012 EOM. All rights reserved.
//

#import "COPsubmittingViewController.h"
#import "COPviewerViewController.h"
#import "MenuData.h"
@interface COPsubmittingViewController ()

@end

@implementation COPsubmittingViewController
#define PROP_FILE_STR @"COPsubmittingMenu"
#define ACT_TYPE_STR @"Activity Type"
#define LEARN_SKILL_STR @"Learning Skill"
#define LEVEL_STR @"Level"
#define WORK_TYPE_STR @"Work Type"
#define EXPEC_STR @"Expectation"
#define EXPEC_DES_STR @"Expectation Description"
#define ALL_EXPECT_NUM @"999"

-(IBAction)keyboardDown{
    [commScroll resignFirstResponder];
    keyboardButton.frame = CGRectMake(0,-44,320,44);
    commScroll.frame = CGRectMake(0,315,320,62);
    commScroll.bounds = CGRectMake(0,0,320,62);
}

-(IBAction)selectList:(UIButton*)sender{
    buttonSelected = sender.accessibilityHint;
    
    [dropDownMenuList removeAllObjects];
    if([sender isEqual:activityTypeButton])
        dropDownMenuList = [MenuData readFile:ACT_TYPE_STR];
    else if([sender isEqual:learningSkillButton])
        dropDownMenuList = [MenuData readFile:LEARN_SKILL_STR];
    else if([sender isEqual:workTypeButton])
        dropDownMenuList = [MenuData readFile:WORK_TYPE_STR];
    else if([sender isEqual:levelButton])
        dropDownMenuList = [MenuData readFile:LEVEL_STR];
    [dropDownMenuList retain];
    
    if(1+1==2){ //FRENCH
        for(int i=0; i<[dropDownMenuList count]; i++){
            [dropDownMenuList replaceObjectAtIndex:i withObject:[[dropDownMenuList objectAtIndex:i]substringFromIndex:[[dropDownMenuList objectAtIndex:i]rangeOfString:@"/"].location+1]];
        }
    }
    else if(1+2==3){ //ENGLISH
        for(int i=0; i<[dropDownMenuList count]; i++){
            [dropDownMenuList replaceObjectAtIndex:i withObject:[[dropDownMenuList objectAtIndex:i]substringToIndex:[[dropDownMenuList objectAtIndex:i]rangeOfString:@"/"].location]];
        }
    }
    
    dropDownMenu.frame = CGRectMake(0,dropDownMenu.frame.origin.y*-1,dropDownMenu.frame.size.width,dropDownMenu.frame.size.height);
    
    [dropDownMenu reloadAllComponents];
}

-(void)selectExpectation{
        
}

-(IBAction)save:(UIButton*)toSyncOrNotToSync{
    
}

-(IBAction)moveTextField{
    commScroll.frame = CGRectMake(0,44,320,200);
    commScroll.bounds = CGRectMake(0,44,320,200);
    keyboardButton.frame = CGRectMake(0,0,320,44);
    [commScroll becomeFirstResponder];
}

-(void)passExtraInfo:(NSString*)info{
    
    nameCourse.title = [[info substringWithRange:NSMakeRange([info rangeOfString:@"Student:"].location+8, [info rangeOfString:@"CommunicationType"].location-[info rangeOfString:@"Student:"].location-8)] stringByAppendingString:[NSString stringWithFormat:@" (%@)",[info substringWithRange:NSMakeRange([info rangeOfString:@":"].location+1, [info rangeOfString:@"Student"].location-[info rangeOfString:@":"].location-1)]]];
    nameCourse.accessibilityHint = [info substringWithRange:NSMakeRange([info rangeOfString:@"CommunicationType:"].location+18,[info rangeOfString:@"Expectation"].location-[info rangeOfString:@"CommunicationType:"].location-18)];
    backButton.accessibilityHint = [info substringFromIndex:[info rangeOfString:@"Expectation:"].location+12];
}

-(IBAction)goBack{
    COPviewerViewController *copViewer = [[COPviewerViewController alloc]init];
    [self presentModalViewController:copViewer animated:YES];
    NSString*expectNum = backButton.accessibilityHint;
    if([expectNum rangeOfString:@" "].location>[expectNum length])
        expectNum = ALL_EXPECT_NUM;
    else
        expectNum = [expectNum substringFromIndex:[expectNum rangeOfString:@" "].location+1];
    
    [copViewer passExtraInfo:[NSString stringWithFormat:@"Course:%@Student:%@CommunicationType:%@Expectation:%@",[nameCourse.title substringWithRange:NSMakeRange([nameCourse.title rangeOfString:@"("].location+1,[nameCourse.title rangeOfString:@")"].location-[nameCourse.title rangeOfString:@"("].location-1)],[nameCourse.title substringToIndex:[nameCourse.title rangeOfString:@" ("].location],nameCourse.accessibilityHint,expectNum]];
    [copViewer release];
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
    
    dropDownMenuList = [[NSMutableArray alloc]init];
//    for(int i=0; i<10; i++)
//        [dropDownMenuList addObject:@" "];
    
    descriptionSelected = NO;

    dropDownMenu.frame = CGRectMake(0,dropDownMenu.frame.origin.y*-1,dropDownMenu.frame.size.width,dropDownMenu.frame.size.height);
    keyboardButton.frame = CGRectMake(0,-44,177,44);
    
    dropDownMenu.dataSource = self;
    
    activityTypeButton.accessibilityHint = ACT_TYPE_STR;
    learningSkillButton.accessibilityHint = LEARN_SKILL_STR;
    workTypeButton.accessibilityHint = WORK_TYPE_STR;
    expectButton.accessibilityHint = EXPEC_STR;
    expectDesButton.accessibilityHint = EXPEC_DES_STR;
    levelButton.accessibilityHint = LEVEL_STR;
    
    if(1+1==2){
        NSMutableArray *menuObjects = [[NSMutableArray alloc]init];
        [menuObjects addObject:expectDesButton];
        [menuObjects addObject:expectButton];
        [menuObjects addObject:levelButton];
        [menuObjects addObject:activityTypeButton];
        [menuObjects addObject:learningSkillButton];
        [menuObjects addObject:workTypeButton];
        [menuObjects addObject:commentLabel];
        [menuObjects addObject:save];
        [menuObjects addObject:saveAndSync];
        
        NSMutableArray *textOnMenu = [MenuData readFile:PROP_FILE_STR];
        
        for(int i=0; i<[menuObjects count]; i++){
            for (int j=0; j<[textOnMenu count]; j++) {
                if([[menuObjects objectAtIndex:i] isKindOfClass:[UIBarButtonItem class]]){
                    if([((UIBarButtonItem*)[menuObjects objectAtIndex:i]).title rangeOfString:[[textOnMenu objectAtIndex:j]substringToIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location]].location<=[((UIBarButtonItem*)[menuObjects objectAtIndex:i]).title length]){
                        [((UIBarButtonItem*)[menuObjects objectAtIndex:i])setTitle:[((UIBarButtonItem*)[menuObjects objectAtIndex:i]).title stringByReplacingOccurrencesOfString:[[textOnMenu objectAtIndex:j]substringToIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location] withString:[[textOnMenu objectAtIndex:j]substringFromIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location+1]]];
                    }
                }
                else if([[menuObjects objectAtIndex:i] isKindOfClass:[UIButton class]]){
                    if([((UIButton*)[menuObjects objectAtIndex:i]).titleLabel.text rangeOfString:[[textOnMenu objectAtIndex:j]substringToIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location]].location<=[((UIButton*)[menuObjects objectAtIndex:i]).titleLabel.text length]){
                        [((UIButton*)[menuObjects objectAtIndex:i])setTitle:[((UIButton*)[menuObjects objectAtIndex:i]).titleLabel.text stringByReplacingOccurrencesOfString:[[textOnMenu objectAtIndex:j]substringToIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location] withString:[[textOnMenu objectAtIndex:j]substringFromIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location+1]] forState:((UIButton*)[menuObjects objectAtIndex:i]).state];
                    }
                }
                else if([[menuObjects objectAtIndex:i] isKindOfClass:[UILabel class]]){
                    if([((UILabel*)[menuObjects objectAtIndex:i]).text rangeOfString:[[textOnMenu objectAtIndex:j]substringToIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location]].location<=[((UILabel*)[menuObjects objectAtIndex:i]).text length]){
                        ((UILabel*)[menuObjects objectAtIndex:i]).text = [((UILabel*)[menuObjects objectAtIndex:i]).text stringByReplacingOccurrencesOfString:[[textOnMenu objectAtIndex:j]substringToIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location] withString:[[textOnMenu objectAtIndex:j]substringFromIndex:[[textOnMenu objectAtIndex:j]rangeOfString:@"/"].location+1]];
                    }
                }
            }
        }
    }
    
    
    // Do any additional setup after loading the view from its nib.

}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
	return [dropDownMenuList count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
	return [dropDownMenuList objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if([buttonSelected isEqual:EXPEC_DES_STR]){
        
    }
    else{
        if([buttonSelected isEqual:expectButton.accessibilityHint]){
            [expectButton setTitle:[NSString stringWithFormat:@"%@%@",[expectButton.titleLabel.text substringToIndex:[expectButton.titleLabel.text rangeOfString:@":"].location+1],[dropDownMenuList objectAtIndex:row]] forState:expectButton.state];
        }
        else if([buttonSelected isEqual:learningSkillButton.accessibilityHint]){
            [learningSkillButton setTitle:[NSString stringWithFormat:@"%@%@",[learningSkillButton.titleLabel.text substringToIndex:[learningSkillButton.titleLabel.text rangeOfString:@":"].location+1],[dropDownMenuList objectAtIndex:row]] forState:learningSkillButton.state];
        }
        else if([buttonSelected isEqual:workTypeButton.accessibilityHint]){
             [workTypeButton setTitle:[NSString stringWithFormat:@"%@%@",[workTypeButton.titleLabel.text substringToIndex:[workTypeButton.titleLabel.text rangeOfString:@":"].location+1],[dropDownMenuList objectAtIndex:row]] forState:workTypeButton.state];
        }
        else if([buttonSelected isEqual:activityTypeButton.accessibilityHint]){
            [activityTypeButton setTitle:[NSString stringWithFormat:@"%@%@",[activityTypeButton.titleLabel.text substringToIndex:[activityTypeButton.titleLabel.text rangeOfString:@":"].location+1],[dropDownMenuList objectAtIndex:row]] forState:activityTypeButton.state];
        }
        else if([buttonSelected isEqual:levelButton.accessibilityHint]){
            [levelButton setTitle:[NSString stringWithFormat:@"%@%@",[levelButton.titleLabel.text substringToIndex:[levelButton.titleLabel.text rangeOfString:@":"].location+1],[dropDownMenuList objectAtIndex:row]] forState:levelButton.state];
        }
    }
    
    dropDownMenu.frame = CGRectMake(0,dropDownMenu.frame.origin.y*-1,dropDownMenu.frame.size.width,dropDownMenu.frame.size.height);
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
