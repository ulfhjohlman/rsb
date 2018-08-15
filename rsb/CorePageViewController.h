//
//  CorePageViewController.h
//  RouteSetterBuddy
//
//  Created by Ulf Hjohlman on 2018-07-06.
//  Copyright © 2018 FatPinchStudios. All rights reserved.
//

#import <UIKit/UIKit.h>

@import Firebase;

@interface CorePageViewController : UIPageViewController <UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@property NSUserDefaults * userSettings;
@property NSString * pageClimbingType;
@property NSString * gymName;

//@property FIRDatabaseHandle refHandleWallList;
@property (strong, nonatomic) FIRDatabaseReference * ref;
@property (strong, nonatomic) NSMutableArray<NSString *> * wallsList;
@property(strong, nonatomic)  NSMutableDictionary<NSNumber* , UIViewController *> * VCDictionary;
@property NSString * gymBasePath;
@property NSString * gymClimbingTypePath;
@property NSString * wallListPath;

@end
