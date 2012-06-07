//
//  ExpSelectionViewController.m
//  Shifmark
//
//  Created by David Huynh on 12-05-19.
//  Copyright (c) 2012 EOM. All rights reserved.
//
//

#import "ExpSelectionViewController.h"
#import "COPviewerViewController.h"
#import "MenuData.h"
@interface ExpSelectionViewController ()

@end

@implementation ExpSelectionViewController
#define PROP_FILE_STR @"ExpectationSelectionMenu"
#define EXPECTATION_SEL_INT 0
#define EXPECTATION_TR_INT 1
#define ALL 2

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    expectations = [[[NSMutableArray alloc]init]autorelease];
    for(int i=0; i<10; i++)
        [expectations addObject:[NSString stringWithFormat:@"Expectation %i",(i+1)]];
    [expectations addObject:@"ALL"];
    NSMutableArray *textOnMenu = [MenuData readFile:PROP_FILE_STR];
    
    if(1+1==2){
        titleLabel.title = [textOnMenu objectAtIndex:EXPECTATION_SEL_INT];
        for(int i=0; i<[expectations count]-1; i++){
            [expectations replaceObjectAtIndex:i withObject:@""];
            [NSString stringWithFormat:@"%@%@",[textOnMenu objectAtIndex:EXPECTATION_TR_INT],[[expectations objectAtIndex:i]substringFromIndex:[[expectations objectAtIndex:i]rangeOfString:@" "].location+1]];
        }
        [expectations replaceObjectAtIndex:[expectations count]-1 withObject:[textOnMenu objectAtIndex:ALL]];
    }

    // Do any additional setup after loading the view from its nib.
}

-(void)passExtraInfo:(NSString*)info{
    titleLabel.accessibilityHint = [info substringToIndex:[info rangeOfString:@"Expectation"].location];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [@"" autorelease];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [expectations count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@""];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""] autorelease];
    }
    
    // Configure the cell...
    
    cell.textLabel.text = @"EVENT NAME";
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    return cell;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
