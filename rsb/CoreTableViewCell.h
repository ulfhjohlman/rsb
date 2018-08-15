//
//  CoreTableViewCell.h
//  RouteSetterBuddy
//
//  Created by Ulf Hjohlman on 2018-07-09.
//  Copyright © 2018 FatPinchStudios. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;

typedef enum{
    left,
    center,
    right
} RouteLocationType;

typedef enum{
    mm,
    m,
    bm,
    p,
    pp
} RouteDifficultyType;

typedef enum {
    purple,
    white,
    blue,
    black,
    red,
    orange,
    pink,
    green,
    yellow
} RouteColorType;


@interface CoreTableViewCell : UITableViewCell

-(void)configureDataFromSnapshot:(FIRDataSnapshot *) snapshot;

@property int r;
@property int i;
@property int c;
@property Boolean onWall;
@property NSString * color;
@property NSString * location;
@property NSString * setter;
@property NSString * uploader;
@property NSString * difficulty;
@property NSArray<NSString * > * tags;
@property NSString * buildDate;
@property NSString * uploadDate;

@property (weak, nonatomic) IBOutlet UILabel *difficultyLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *ricLabel;
@property (weak, nonatomic) IBOutlet UILabel *setterLabel;




@end
