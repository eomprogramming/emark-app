//
//  PwdRecovViewController.h
//  Shifmark
//
//  Created by David Huynh on 12-05-25.
//  Copyright (c) 2012 EOM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PwdRecovViewController : UIViewController{
    IBOutlet UITextView *secureQuestion;
    IBOutlet UIButton *showSecQuestion;
    IBOutlet UIButton *submitAnsToQuest;
    IBOutlet UIButton *keyboardDownButton1;
    IBOutlet UIButton *keyboardDownButton2;
    IBOutlet UILabel *ansSecQuEng;
    IBOutlet UILabel *ansSecQuFr;
    IBOutlet UITextField *usernameField;
    IBOutlet UITextField *answerField;
}

-(IBAction)resetPassword;
-(IBAction)getSecureQuestion;
-(IBAction)putKeyboardDown:(UIButton*)sender;
@end
