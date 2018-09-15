//
//  AddRouteController.h
//  rsb
//
//  Created by Ulf Hjohlman on 2018-08-23.
//  Copyright © 2018 Ulf Hjohlman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddRouteController : UIViewController <UITextFieldDelegate>
- (IBAction)doneButtonPressed:(id)sender;

@property NSUserDefaults * userDefaults;


@property (weak, nonatomic) IBOutlet UIButton *purpleButton;
- (IBAction)purpleButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *whiteButton;
- (IBAction)whiteButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *blueButton;
- (IBAction)blueButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *blackButton;
- (IBAction)blackButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *redButton;
- (IBAction)redButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *orangeButton;
- (IBAction)orangeButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *pinkButton;
- (IBAction)pinkButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *greenButton;
- (IBAction)greenButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *yellowButton;
- (IBAction)yellowButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UISegmentedControl *difficultySelector;
@property (weak, nonatomic) IBOutlet UISegmentedControl *locationSelector;
@property (weak, nonatomic) IBOutlet UISegmentedControl *rSelector;
@property (weak, nonatomic) IBOutlet UISegmentedControl *iSelector;
@property (weak, nonatomic) IBOutlet UISegmentedControl *cSelector;
@property (weak, nonatomic) IBOutlet UITextField *setterTextField;
@property (weak, nonatomic) IBOutlet UITextField *tagsTextField;
@property (weak, nonatomic) IBOutlet UITextField *notesTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *buildDateSelector;


@end
