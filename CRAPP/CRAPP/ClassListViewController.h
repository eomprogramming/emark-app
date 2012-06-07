//
//  ClassListViewController.h
//  Shifmark
//
//  Created by David Huynh on 12-04-12.
//  Copyright (c) 2012 EOM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
//    IBOutlet UIButton *settingsButton;
    IBOutlet UIBarButtonItem *backButton;
    IBOutlet UIBarButtonItem *titleLabel;
    IBOutlet UIBarButtonItem *helpButton;
    IBOutlet UIBarButtonItem *settingsButton;
    IBOutlet UIBarButtonItem *logoutButton;
    IBOutlet UIScrollView *table;
    IBOutlet UIView *viewInsideTable;
//    const NSString *PROP_FILE;
}
-(IBAction) goToSettings; 
-(IBAction)logout;
-(IBAction)goBack;
-(void)setCourseCode:(NSString*)courseCode;
@end
