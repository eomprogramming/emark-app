//
//  SettingsPageViewController.h
//  Shifmark
//
//  Created by David Huynh on 12-04-12.
//  Copyright (c) 2012 EOM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsPageViewController : UIViewController{
    IBOutlet UIButton *changePwdButton;
    IBOutlet UIBarButtonItem *helpButton;
    IBOutlet UIBarButtonItem *logoutButton;
    IBOutlet UISegmentedControl *langSegCont;
    IBOutlet UISegmentedControl *updateSegCont;
    IBOutlet UIBarButtonItem *backButton;
    IBOutlet UISegmentedControl *colBlindSegCont;
    IBOutlet UIBarButtonItem *titleLabel;
    IBOutlet UILabel *autoUpdateLabel;
    IBOutlet UILabel *colBlindLabel;
    IBOutlet UIButton *udpateButton;
    NSMutableArray *menuObjects;
    NSMutableArray *textOnMenu;
}

/*
 Goes back to previous ViewController
 */
-(IBAction)goBack;

/*
 Logs user out
 */
-(IBAction)logout;

/*
 Method saves the previous menu
 */
-(void)setPrevMenu:(NSString*)name;

/*
 Method saves data needed for previous menus, if applicable
 */
-(void)passExtraVCinfo:(NSString*)params;

/*
 Change the password of an user
 */
-(IBAction)changePwd;

/*
 Switch from English to French and vice versa
 */
-(IBAction)switchLang;

-(void)switchToFr;

-(void)switchToEng;
@end
