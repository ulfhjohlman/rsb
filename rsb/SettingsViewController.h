//
//  SettingsViewController.h
//  RouteSetterBuddy
//
//  Created by Ulf Hjohlman on 2018-07-11.
//  Copyright © 2018 FatPinchStudios. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleSignIn;
@import Firebase;

@interface SettingsViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *settingsFirstName;
- (IBAction)settingsFirstNameEditingChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *settingsDoneButton;
- (IBAction)settingsDoneButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *settingsCancelButton;
- (IBAction)settingsCancelButtonPressed:(id)sender;

@property NSUserDefaults * userSettings;

@property (weak, nonatomic) IBOutlet UIButton *settingsSignOutButton;
- (IBAction)settingsSignOutButtonPressed:(id)sender;

@property(weak, nonatomic) IBOutlet GIDSignInButton *signInButton;
@property(strong, nonatomic) FIRAuthStateDidChangeListenerHandle authStateHandle;
@property (weak, nonatomic) IBOutlet UILabel *settingsSignedInAsLabel;

@end
