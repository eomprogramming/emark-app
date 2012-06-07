//
//  PwdRecovViewController.m
//  Shifmark
//
//  Created by David Huynh on 12-05-25.
//  Copyright (c) 2012 EOM. All rights reserved.
//


#import "PwdRecovViewController.h"

@interface PwdRecovViewController ()

@end

@implementation PwdRecovViewController

-(IBAction)resetPassword{
    
}

-(IBAction)getSecureQuestion{
    secureQuestion.frame = CGRectMake(secureQuestion.frame.origin.x, secureQuestion.frame.origin.y*-1, secureQuestion.frame.size.width, secureQuestion.frame.size.height);
    ansSecQuEng.frame = CGRectMake(ansSecQuEng.frame.origin.x,ansSecQuEng.frame.origin.y*-1,ansSecQuEng.frame.size.width,ansSecQuEng.frame.size.height);
    ansSecQuFr.frame = CGRectMake(ansSecQuFr.frame.origin.x,ansSecQuFr.frame.origin.y*-1,ansSecQuFr.frame.size.width,ansSecQuFr.frame.size.height);
    answerField.frame = CGRectMake(answerField.frame.origin.x,answerField.frame.origin.y*-1,answerField.frame.size.width,answerField.frame.size.height);
    submitAnsToQuest.frame = CGRectMake(submitAnsToQuest.frame.origin.x,submitAnsToQuest.frame.origin.y*-1,submitAnsToQuest.frame.size.width,submitAnsToQuest.frame.size.height);
}

-(IBAction)putKeyboardDown:(UIButton*)sender{
        
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
    secureQuestion.frame = CGRectMake(secureQuestion.frame.origin.x, secureQuestion.frame.origin.y*-1, secureQuestion.frame.size.width, secureQuestion.frame.size.height);
    ansSecQuEng.frame = CGRectMake(ansSecQuEng.frame.origin.x,ansSecQuEng.frame.origin.y*-1,ansSecQuEng.frame.size.width,ansSecQuEng.frame.size.height);
    ansSecQuFr.frame = CGRectMake(ansSecQuFr.frame.origin.x,ansSecQuFr.frame.origin.y*-1,ansSecQuFr.frame.size.width,ansSecQuFr.frame.size.height);
    answerField.frame = CGRectMake(answerField.frame.origin.x,answerField.frame.origin.y*-1,answerField.frame.size.width,answerField.frame.size.height);
    submitAnsToQuest.frame = CGRectMake(submitAnsToQuest.frame.origin.x,submitAnsToQuest.frame.origin.y*-1,submitAnsToQuest.frame.size.width,submitAnsToQuest.frame.size.height);
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
