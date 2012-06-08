//
//  COPviewerViewController.h
//  Shifmark
//
//  Created by David Huynh on 12-05-14.
//  Copyright (c) 2012 EOM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface COPviewerViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    IBOutlet UIBarButtonItem *nameCourse;
    IBOutlet UIBarButtonItem *expectNum;
    IBOutlet UIBarButtonItem *communiType;
    IBOutlet UIBarButtonItem *addNewComm;
    IBOutlet UIBarButtonItem *help;
    IBOutlet UIBarButtonItem *settingsButton;
    IBOutlet UIBarButtonItem *logoutButton;
    IBOutlet UIButton *backButton;
    IBOutlet UIScrollView *table;
    IBOutlet UIView *viewInsideTable;
//    const NSString *PROP_FILE;
}
@property (assign, nonatomic)int expectation;
-(IBAction)goBack;
-(IBAction)goToSettings;
-(IBAction)logout;
-(IBAction)addNewCommunication;
-(IBAction)viewOldCommunication:(UIButton*)sender;
-(IBAction)selectExpectation;
-(void)passExtraInfo:(NSString*)info;
-(void)switchToFr;
@end
