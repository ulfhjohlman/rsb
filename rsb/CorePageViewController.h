//
//  CorePageViewController.h
//  RouteSetterBuddy
//
//  Created by Ulf Hjohlman on 2018-07-06.
//  Copyright © 2018 FatPinchStudios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CorePageViewController : UIPageViewController <UIPageViewControllerDataSource>
@property NSString * pageClimbingType;
@property NSString * gymName;

@end
