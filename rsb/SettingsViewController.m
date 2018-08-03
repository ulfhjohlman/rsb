//
//  SettingsViewController.m
//  RouteSetterBuddy
//
//  Created by Ulf Hjohlman on 2018-07-11.
//  Copyright © 2018 FatPinchStudios. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()<GIDSignInUIDelegate>{
    
}
-(void)fillInUserDefaults;
@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [GIDSignIn sharedInstance].uiDelegate = self;
    self.authStateHandle = [[FIRAuth auth]
                            addAuthStateDidChangeListener:^(FIRAuth *_Nonnull auth, FIRUser *_Nullable user) {
                                
                                if (user) {
                                    [FIRAnalytics logEventWithName:kFIREventLogin parameters:nil];
                                    [self showLoggedIn:user];
                                }
                                else{
                                    [self showLoggedOut];
                                }
                            }];
    
    FIRUser* user = [[FIRAuth auth] currentUser];
    if(user == nil){
        NSLog(@"No current Loggin, atempting silent login.");
        [[GIDSignIn sharedInstance] signInSilently];
    }
    else {
        NSLog(@"Already logged in.");
    }
    self.userSettings = NSUserDefaults.standardUserDefaults;
    [self fillInUserDefaults];

}

-(void)showLoggedIn: (FIRUser *) user{
    self.settingsSignOutButton.hidden = false;
    NSString * name = user.displayName;
    if(name){
        self.settingsSignedInAsLabel.text = [NSString stringWithFormat:@"%@ %@", @"Logged in as:",name];;
    } else {
        self.settingsSignedInAsLabel.text = @"unknown";
    }
    //TODO show editing privelages?
    
}
-(void)showLoggedOut{
    self.settingsSignOutButton.hidden = true;
    self.settingsSignedInAsLabel.text = @"Not signed in";
}

- (void)dealloc {
    [[FIRAuth auth] removeAuthStateDidChangeListener:_authStateHandle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fillInUserDefaults{
    NSString * cur_firstName = [self.userSettings stringForKey:@"firstName"];
    if(cur_firstName != nil){
        [self.settingsFirstName setText:cur_firstName];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return true;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)settingsFirstNameEditingChanged:(id)sender {
    if([self.settingsFirstName.text length] > 24){
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Invalid Name" message:@"Max 24 chars allowed :P" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}

-(IBAction)settingsCancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

-(void)settingsDoneButtonPressed:(id)sender{
    if([self.settingsFirstName.text length] <= 24){
        [self.userSettings setObject: self.settingsFirstName.text forKey:@"firstName"];
    }
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)settingsSignOutButtonPressed:(id)sender {
    NSError *signOutError;
    BOOL status = [[FIRAuth auth] signOut:&signOutError];
    if (!status) {
        NSLog(@"Error signing out: %@", signOutError);
        return;
    }
    [[GIDSignIn sharedInstance] signOut];
    
}
@end
