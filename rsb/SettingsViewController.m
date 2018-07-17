//
//  SettingsViewController.m
//  RouteSetterBuddy
//
//  Created by Ulf Hjohlman on 2018-07-11.
//  Copyright © 2018 FatPinchStudios. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
-(void)fillInUserDefaults;
@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userSettings = NSUserDefaults.standardUserDefaults;
    [self fillInUserDefaults];

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

-(void)settingsDoneButtonPressed:(id)sender{
    [self dismissViewControllerAnimated:true completion:nil];
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
    if([self.settingsFirstName.text length] < 24){
        [self.userSettings setObject: self.settingsFirstName.text forKey:@"firstName"];
    } else {
        self.settingsFirstName.text = @"Max allowed name length is 24 chars :P";
    }
}

- (IBAction)settingsInstanceConnectionNameEditingChanged:(id)sender {
}
- (IBAction)settingsDatabaseNameEditingChanged:(id)sender {
}
- (IBAction)settingsUserEditingChanged:(id)sender {
}
- (IBAction)settingsPasswordEditingChanged:(id)sender {
}

- (IBAction)settingsTestConnectionButtonPressed:(id)sender {
}
@end
