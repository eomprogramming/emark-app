//
//  ExpSelectionViewController.h
//  Shifmark
//
//  Created by David Huynh on 12-05-19.
//  Copyright (c) 2012 EOM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpSelectionViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    IBOutlet UIBarButtonItem *titleLabel;
    NSMutableArray *expectations;
}
/*
 Info for the COPviewerViewController (Course, student name, type of communication, and expectation #)
 */
-(void)passExtraInfo:(NSString*)info;
@end
