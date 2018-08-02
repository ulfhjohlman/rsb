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

- (IBAction)settingsInstanceConnectionNameEditingChanged:(id)sender {
}
- (IBAction)settingsDatabaseNameEditingChanged:(id)sender {
}
- (IBAction)settingsUserEditingChanged:(id)sender {
}
- (IBAction)settingsPasswordEditingChanged:(id)sender {
}

- (IBAction)settingsCancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

-(void)settingsDoneButtonPressed:(id)sender{
    if([self.settingsFirstName.text length] <= 24){
        [self.userSettings setObject: self.settingsFirstName.text forKey:@"firstName"];
    }
    [self dismissViewControllerAnimated:true completion:nil];
}


- (IBAction)settingsTestConnectionButtonPressed:(id)sender {
}
@end
