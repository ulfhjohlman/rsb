//
//  CoreViewController.h
//  RouteSetterBuddy
//
//  Created by Ulf Hjohlman on 2018-07-06.
//  Copyright © 2018 FatPinchStudios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoreViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *ImageView;
@property (strong, nonatomic) IBOutlet UITableView *TableView;
@property (strong, nonatomic) IBOutlet UINavigationItem *navItem;
@property NSString * wallName;
@property NSUInteger wallNumberID;
@property NSArray * tableCellsText;

@end
