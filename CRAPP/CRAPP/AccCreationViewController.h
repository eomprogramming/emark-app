//
//  AccCreationViewController.h
//  Shifmark
//
//  Created by David Huynh on 12-05-19.
//  Copyright (c) 2012 EOM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccCreationViewController : UIViewController<UIAlertViewDelegate>{
    IBOutlet UITextField *username;
    IBOutlet UITextField *password;
    IBOutlet UITextField *conPassword;
    IBOutlet UIButton *keyboardCloser;
    IBOutlet UIButton *createUserButton;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UITextField *secQuest;
    IBOutlet UITextField *secAns;
}
/*
 Creates user
 */
-(IBAction)createUser;

/*
 Puts keyboard down
 */
-(IBAction)putKeyboardDown;
@end
