//
//  AddRouteController.h
//  rsb
//
//  Created by Ulf Hjohlman on 2018-08-23.
//  Copyright © 2018 Ulf Hjohlman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddRouteController : UIViewController
- (IBAction)doneButtonPressed:(id)sender;

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



@end
