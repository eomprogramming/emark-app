//
//  StudentInfoViewController.h
//  Shifmark
//
//  Created by David Huynh on 12-04-12.
//  Copyright (c) 2012 EOM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentInfoViewController : UIViewController{
    IBOutlet UIButton* products; // will be implemented when product API is out.
    IBOutlet UIButton* convos;
    IBOutlet UIButton* observ;
    IBOutlet UIBarButtonItem *studentName;
    IBOutlet UIBarButtonItem *course;
    IBOutlet UIBarButtonItem *backButton;
    IBOutlet UIBarButtonItem *help;
    IBOutlet UIBarButtonItem *settingsButton;
    IBOutlet UIBarButtonItem *logoutButton;
//    const NSString *PROP_FILE;
}

-(IBAction)logout;
-(IBAction)goToCommunications:(UIButton*)sender;
-(IBAction)goToSettings;
-(IBAction)goBack;
-(void)setExtraInfo:(NSString*)info;

@end
