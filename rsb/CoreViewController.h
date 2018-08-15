//
//  CoreViewController.h
//  RouteSetterBuddy
//
//  Created by Ulf Hjohlman on 2018-07-06.
//  Copyright © 2018 FatPinchStudios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePageViewController.h"

@interface CoreViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView * imageView;
@property (strong, nonatomic) IBOutlet UITableView * tableView;
@property NSString * wallName;
@property NSString * wallID;

@property (strong, nonatomic) NSIndexPath *expandedIndexPath;

@end
