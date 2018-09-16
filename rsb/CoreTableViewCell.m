//
//  CoreTableViewCell.m
//  RouteSetterBuddy
//
//  Created by Ulf Hjohlman on 2018-07-09.
//  Copyright © 2018 FatPinchStudios. All rights reserved.
//

#import "CoreTableViewCell.h"

@implementation CoreTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureDataFromSnapshot:(FIRDataSnapshot *) snapshot{
    NSDictionary<NSString*,NSString*> * snapDictionary = snapshot.value;
    self.r = [snapDictionary[@"R"] intValue];
    self.i = [snapDictionary[@"I"] intValue];
    self.c = [snapDictionary[@"C"] intValue];
    self.setter = snapDictionary[@"setter"];
    self.uploader = snapDictionary[@"uploader"];
    self.color = snapDictionary[@"color"];
    self.location = snapDictionary[@"location"];
    self.difficulty = snapDictionary[@"difficulty"];
    self.onWall = snapDictionary[@"onWall"];
    if( [snapshot hasChild:@"tags"]){
        self.tags = [snapshot childSnapshotForPath:@"tags"].value;
    }
    self.buildDate = snapDictionary[@"build-date"];
    self.uploadDate = snapDictionary[@"post-date"];
    self.notes = snapDictionary[@"notes"];
    
    [self applyDifficultyLabel];
    [self applyColorLabel];
    self.locationLabel.text = self.location;
    self.setterLabel.text = self.setter;
    self.ricLabel.text = [NSString stringWithFormat:@"| %d | %d | %d |",self.r,self.i,self.c];
    self.buildTextLabel.text = self.buildDate;
    self.notesTextLabel.text = self.notes;
    [self applyTags];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)applyDifficultyLabel{
    NSString * str;
    if( [self.difficulty isEqualToString:@"mm"]){
        str = @"--";
    }
    else if( [self.difficulty isEqualToString:@"m"]){
        str = @"-";
    }
    else if( [self.difficulty isEqualToString:@"bm"]){
        str = @"BM";
    }
    else if( [self.difficulty isEqualToString:@"p"]){
        str = @"+";
    }
    else if( [self.difficulty isEqualToString:@"pp"]){
        str = @"++";
    }
    else{
        NSLog(@"Error Setting unknown cell difficulty: %@!", self.difficulty);
        str = @"";
    }
    NSDictionary *attrsDictionary = @{NSStrokeColorAttributeName : UIColor.blackColor ,
                                      NSForegroundColorAttributeName : UIColor.whiteColor,
                                      NSStrokeWidthAttributeName : [NSNumber numberWithDouble:-3.0],
                                      };
    self.difficultyLabel.attributedText = [[NSAttributedString alloc] initWithString:str attributes: attrsDictionary] ;
}

-(void)applyColorLabel{
    if([self.color isEqualToString:@"purple"]){
        self.difficultyLabel.backgroundColor = [UIColor purpleColor];
    }
    else if([self.color isEqualToString:@"white"]){
        self.difficultyLabel.backgroundColor = [UIColor whiteColor];
    }
    else if([self.color isEqualToString:@"blue"]){
        self.difficultyLabel.backgroundColor = [UIColor blueColor];
    }
    else if([self.color isEqualToString:@"black"]){
        self.difficultyLabel.backgroundColor = [UIColor blackColor];
    }
    else if([self.color isEqualToString:@"red"]){
        self.difficultyLabel.backgroundColor = [UIColor redColor];
    }
    else if([self.color isEqualToString:@"orange"]){
        self.difficultyLabel.backgroundColor = [UIColor orangeColor];
    }
    else if([self.color isEqualToString:@"pink"]){
        self.difficultyLabel.backgroundColor = [UIColor magentaColor];
    }
    else if([self.color isEqualToString:@"green"]){
        self.difficultyLabel.backgroundColor = [UIColor greenColor];
    }
    else if([self.color isEqualToString:@"yellow"]){
        self.difficultyLabel.backgroundColor = [UIColor yellowColor];
    }
    else{
        NSLog(@"Error Setting unknown cell color: %@!", self.color);
    }
    self.difficultyLabel.layer.borderColor = [UIColor blackColor].CGColor;
    self.difficultyLabel.layer.borderWidth = 2.0;
}

-(void) applyTags{
    self.tagsTextLabel.text = @"";
    if(self.tags != nil && self.tags.count > 0){
        for(NSString* tag in self.tags){
            self.tagsTextLabel.text = [[self.tagsTextLabel.text stringByAppendingString:tag] stringByAppendingString:@" "];
        }
    }
}

@end
