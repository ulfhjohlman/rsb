//
//  AddRouteController.m
//  rsb
//
//  Created by Ulf Hjohlman on 2018-08-23.
//  Copyright © 2018 Ulf Hjohlman. All rights reserved.
//

#import "AddRouteController.h"
#import "CoreViewController.h"

@interface AddRouteController ()

@end

@implementation AddRouteController

- (void)viewDidLoad {
    [super viewDidLoad];
    if([[self tabBarItem].title isEqualToString:@"Boulders"]){
        self.navigationItem.title = @"Add new problem";
    } else {
        self.navigationItem.title = @"Add new route";
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)doneButtonPressed:(id)sender {
    
}
- (IBAction)purpleButtonPressed:(id)sender {
}
- (IBAction)whiteButtonPressed:(id)sender {
}
- (IBAction)blueButtonPressed:(id)sender {
}
- (IBAction)blackButtonPressed:(id)sender {
}
- (IBAction)redButtonPressed:(id)sender {
}
- (IBAction)orangeButtonPressed:(id)sender {
}
- (IBAction)pinkButtonPressed:(id)sender {
}
- (IBAction)greenButtonPressed:(id)sender {
}
- (IBAction)yellowButtonPressed:(id)sender {
}
@end
