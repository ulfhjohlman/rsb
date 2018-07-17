//
//  SettingsViewController.h
//  RouteSetterBuddy
//
//  Created by Ulf Hjohlman on 2018-07-11.
//  Copyright © 2018 FatPinchStudios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *settingsFirstName;
- (IBAction)settingsFirstNameEditingChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *settingsInstanceConnectionName;
- (IBAction)settingsInstanceConnectionNameEditingChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *settingsDatabaseName;
- (IBAction)settingsDatabaseNameEditingChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *settingsUser;
- (IBAction)settingsUserEditingChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *settingsPassword;
- (IBAction)settingsPasswordEditingChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *settingsDoneButton;
- (IBAction)settingsDoneButtonPressed:(id)sender;

- (IBAction)settingsTestConnectionButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *testConnectionActivitySpinner;

@property NSUserDefaults * userSettings;

@end
