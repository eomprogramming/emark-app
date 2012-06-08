//
//  ClassListViewController.h
//  Shifmark
//
//  Created by David Huynh on 12-04-12.
//  Copyright (c) 2012 EOM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassListViewController : UIViewController{
//    IBOutlet UIButton *settingsButton;
    IBOutlet UIBarButtonItem *backButton;
    IBOutlet UIBarButtonItem *titleLabel;
    IBOutlet UIBarButtonItem *helpButton;
    IBOutlet UIBarButtonItem *settingsButton;
    IBOutlet UIBarButtonItem *logoutButton;
    IBOutlet UIScrollView *classListScrollView;
    IBOutlet UIView *classListTableView;
//    const NSString *PROP_FILE;
}
-(IBAction) goToSettings; 
-(IBAction)logout;
-(IBAction)goBack;
@end
