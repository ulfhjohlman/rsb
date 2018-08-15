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
    self.onWall = [snapDictionary[@"onWall"] boolValue];
    self.tags = [snapshot childSnapshotForPath:@"tags"].value;
    self.buildDate = snapDictionary[@"build-date"];
    self.uploadDate = snapDictionary[@"post-date"];
    
    self.textLabel.text = [NSString stringWithFormat: @"%@ %@ %@ %@ %@ (RIC: %d,%d,%d)",self.color, self.difficulty, self.setter, self.location, self.buildDate, self.r, self.i, self.c];
}

@end
