//
//  AddRouteController.m
//  rsb
//
//  Created by Ulf Hjohlman on 2018-08-23.
//  Copyright © 2018 Ulf Hjohlman. All rights reserved.
//

#import "AddRouteController.h"
#import "CoreViewController.h"
@import Firebase;

@interface AddRouteController ()
@end


@implementation AddRouteController
UIButton * selectedColorButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userDefaults = NSUserDefaults.standardUserDefaults;
    if([[self tabBarItem].title isEqualToString:@"Boulders"]){
        self.navigationItem.title = @"Add new problem";
    } else {
        self.navigationItem.title = @"Add new route";
    }
    NSString * name = [self.userDefaults stringForKey:@"firstName"];
    if(name != nil){
        self.setterTextField.text = name;
    }
    //TODO if edditing existing route other initilization required
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
    
    NSArray<UIViewController *> * viewsArr = [[self navigationController] viewControllers];
    CorePageViewController * pageViewCntrlr  = (CorePageViewController *) viewsArr[0];
    CoreViewController * coreViewCntrlr = [pageViewCntrlr viewControllers][0];
    NSString * path  = [coreViewCntrlr.wallPath stringByAppendingString:@"/content"];
    FIRDatabaseReference * ref = [[[FIRDatabase database] reference] child:path];
    FIRDatabaseReference * postRef = [ref childByAutoId];
    
    if(![self checkPostReady]){
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Must select a color!" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    NSDictionary * post = [self buildPost];
    
    [postRef setValue: post];
    [[self navigationController] popViewControllerAnimated:true];
}

- (IBAction)purpleButtonPressed:(id)sender {
    selectedColorButton = self.purpleButton;
    [self displaySelectedButton];
}
- (IBAction)whiteButtonPressed:(id)sender {
    selectedColorButton = self.whiteButton;
    [self displaySelectedButton];
}
- (IBAction)blueButtonPressed:(id)sender {
    selectedColorButton = self.blueButton;
    [self displaySelectedButton];
}
- (IBAction)blackButtonPressed:(id)sender {
    selectedColorButton = self.blackButton;
    [self displaySelectedButton];
}
- (IBAction)redButtonPressed:(id)sender {
    selectedColorButton = self.redButton;
    [self displaySelectedButton];
}
- (IBAction)orangeButtonPressed:(id)sender {
    selectedColorButton = self.orangeButton;
    [self displaySelectedButton];
}
- (IBAction)pinkButtonPressed:(id)sender {
    selectedColorButton = self.pinkButton;
    [self displaySelectedButton];
}
- (IBAction)greenButtonPressed:(id)sender {
    selectedColorButton = self.greenButton;
    [self displaySelectedButton];
}
- (IBAction)yellowButtonPressed:(id)sender {
    selectedColorButton = self.yellowButton;
    [self displaySelectedButton];
}

-(void) displaySelectedButton{
    [self clearSelectedButtonText];

    NSDictionary *attrsDictionary = @{NSStrokeColorAttributeName : UIColor.blackColor ,
                                      NSForegroundColorAttributeName : UIColor.whiteColor,
                                      NSStrokeWidthAttributeName : [NSNumber numberWithDouble:-2.0],
                                      };
    NSAttributedString * attributedString = [[NSAttributedString alloc] initWithString:@"X" attributes: attrsDictionary];
    [selectedColorButton setAttributedTitle: attributedString forState:UIControlStateNormal];
}

-(void) clearSelectedButtonText{
    //NSAttributedString * attStr;
    [self.purpleButton setAttributedTitle:nil forState:UIControlStateNormal];
    [self.whiteButton setAttributedTitle:nil forState:UIControlStateNormal];
    [self.blueButton setAttributedTitle:nil forState:UIControlStateNormal];
    [self.blackButton setAttributedTitle:nil forState:UIControlStateNormal];
    [self.redButton setAttributedTitle:nil forState:UIControlStateNormal];
    [self.orangeButton setAttributedTitle:nil forState:UIControlStateNormal];
    [self.pinkButton setAttributedTitle:nil forState:UIControlStateNormal];
    [self.greenButton setAttributedTitle:nil forState:UIControlStateNormal];
    [self.yellowButton setAttributedTitle:nil forState:UIControlStateNormal];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return true;
}

-(bool) checkPostReady{
    return (selectedColorButton != nil);
}

-(NSDictionary *) buildPost{
    
    NSString * tagsText = self.tagsTextField.text;
    NSArray<NSString*> * tagsArray = [tagsText componentsSeparatedByString:@" "];
    NSDate * buildDate = self.buildDateSelector.date;
    NSDate * postDate = [NSDate date];
    NSString * setterString = self.setterTextField.text;
    if( setterString == nil || [setterString isEqualToString: @""] ){
        setterString = @"unknown";
    }
    NSString *buildDateString = [NSDateFormatter localizedStringFromDate: buildDate
                                                               dateStyle:NSDateFormatterShortStyle
                                                               timeStyle:NSDateFormatterNoStyle];
    NSString *postDateString = [NSDateFormatter localizedStringFromDate: postDate
                                                               dateStyle:NSDateFormatterShortStyle
                                                               timeStyle:NSDateFormatterNoStyle];
    NSString * difficultyString = [self parseDifficultyString:[self.difficultySelector titleForSegmentAtIndex: [self.difficultySelector selectedSegmentIndex]]];
    
    
    NSDictionary * dic = @{
                           @"R" : @([[self.rSelector titleForSegmentAtIndex: [self.rSelector selectedSegmentIndex]] integerValue]),
                           @"I" : @([[self.iSelector titleForSegmentAtIndex: [self.iSelector selectedSegmentIndex]] integerValue]),
                           @"C" : @([[self.cSelector titleForSegmentAtIndex: [self.cSelector selectedSegmentIndex]] integerValue]),
                           @"difficulty" : difficultyString,
                           @"location" : [self.locationSelector titleForSegmentAtIndex: [self.locationSelector selectedSegmentIndex]],
                           @"color" : [self determineSelectedColor],
                           @"build-date": buildDateString,
                           @"notes" : self.notesTextField.text,
                           @"onWall" : @"true",
                           @"post-date" : postDateString,
                           @"setter" : setterString,
                           @"tags" : tagsArray,
                           @"uploader" : [FIRAuth auth].currentUser.uid
                           };
    return dic;
}

-(NSString *) parseDifficultyString: (NSString *) str {
    if([str isEqualToString: @"--"]){
        return @"mm";
    }
    if([str isEqualToString: @"-"]){
        return @"m";
    }
    if([str isEqualToString: @"BM"]){
        return @"bm";
    }
    if([str isEqualToString: @"+"]){
        return @"p";
    }
    if([str isEqualToString: @"++"]){
        return @"pp";
    }
    return nil;
}

-(NSString *) determineSelectedColor{
    if(selectedColorButton == self.purpleButton){
        return @"purple";
    }
    if(selectedColorButton == self.whiteButton){
        return @"white";
    }
    if(selectedColorButton == self.blueButton){
        return @"blue";
    }
    if(selectedColorButton == self.blackButton){
        return @"black";
    }
    if(selectedColorButton == self.redButton){
        return @"red";
    }
    if(selectedColorButton == self.orangeButton){
        return @"orange";
    }
    if(selectedColorButton == self.pinkButton){
        return @"pink";
    }
    if(selectedColorButton == self.greenButton){
        return @"green";
    }
    if(selectedColorButton == self.yellowButton){
        return @"yellow";
    }
    return nil;
}

@end
