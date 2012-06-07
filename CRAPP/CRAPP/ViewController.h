//
//  ViewController.h
//  Shifmark
//
//  Created by David Huynh on 12-04-11.
//  Copyright (c) 2012 EOM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIAlertViewDelegate>{
    IBOutlet UIButton *loginButton;
    IBOutlet UIButton *signUpButton;
    IBOutlet UIButton *closeKeyboard;
    IBOutlet UITextField *userField;
    IBOutlet UITextField *pwdField;
    IBOutlet UIButton *pwdRecoveryButton;
}
/*
 Logs user into app
 */
-(IBAction)login;

/*
 Puts the keyboard down
 */
-(IBAction)putKeyboardDown;

/*
 Allows end users to signup for an account on the device
 */
-(IBAction)signUp;

/*
 Allows end users to signup for an account on the device
 */
-(IBAction)pwdRecov;
@end
