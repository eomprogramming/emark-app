//
//  COPsubmittingViewController.h
//  Shifmark
//
//  Created by David Huynh on 12-05-14.
//  Copyright (c) 2012 EOM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface COPsubmittingViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>{
    
    IBOutlet UIBarButtonItem *nameCourse;
    IBOutlet UIButton *backButton;
    IBOutlet UILabel *expecLabel;
    IBOutlet UILabel *commentLabel;
    IBOutlet UITextView *commScroll;
    IBOutlet UIButton *save;
    IBOutlet UIButton *saveAndSync;
    IBOutlet UIButton *moveTextUp;
    IBOutlet UIView *view;
    IBOutlet UIButton *keyboardButton;
    IBOutlet UIPickerView *dropDownMenu;
    IBOutlet UIButton *workTypeButton;
    IBOutlet UIButton *learningSkillButton;
    IBOutlet UIButton *activityTypeButton;
    IBOutlet UIButton *levelButton;
    IBOutlet UIButton *expectDesButton;
    IBOutlet UIButton *expectButton;
    BOOL *descriptionSelected;
    NSMutableArray *dropDownMenuList;
    NSString *buttonSelected;
}
-(IBAction)keyboardDown;
-(IBAction)selectList:(UIButton*)submit;
-(void)selectExpectation;
-(IBAction)save:(UIButton*)toSyncOrNotToSync;
-(void)passExtraInfo:(NSString*)info;
-(IBAction)moveTextField;
-(IBAction)goBack;
@end
