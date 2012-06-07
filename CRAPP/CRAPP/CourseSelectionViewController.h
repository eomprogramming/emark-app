//
//  CourseSelectionViewController.h
//  Shifmark
//
//  Created by David Huynh on 12-04-11.
//  Copyright (c) 2012 EOM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseSelectionViewController : UIViewController{
    IBOutlet UIBarButtonItem *settingsButton;
    IBOutlet UIBarButtonItem *helpButton;
    IBOutlet UIBarButtonItem *logoutButton;
    IBOutlet UIButton *courseOneButton;
    IBOutlet UIButton *courseTwoButton;
    IBOutlet UIButton *courseThreeButton;
    IBOutlet UISegmentedControl *semesterChanger;
    IBOutlet UIBarButtonItem *titleLabel;
//    IBOutlet UIScrollView *scroll;
    
}
/*
 Goes to the settings page
 @return IBAction
 */
-(IBAction)goToSettings;

/*
 Logs user out of the app
 @returns IBAction
 */
-(IBAction)logout;

/*
 Moves onto the Class List, based on the selected class
 */
-(IBAction)getClassList:(id)sender;

/*
 Changes courses for the particular semester
 */
-(IBAction)changeSemester;
@end
