//
//  CorePageViewController.m
//  RouteSetterBuddy
//
//  Created by Ulf Hjohlman on 2018-07-06.
//  Copyright © 2018 FatPinchStudios. All rights reserved.
//

#import "CorePageViewController.h"
#import "CoreViewController.h"

@interface CorePageViewController ()
@end

@implementation CorePageViewController{
    NSMutableArray * VCArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = self;
    NSString * tabTitle = self.tabBarController.tabBar.selectedItem.title;
    if([ tabTitle isEqual: (@"Boulders")]){
        self.pageClimbingType = @"Boulders";
    }else if([ tabTitle isEqual: (@"Routes")]){
        self.pageClimbingType = @"Routes";
    }else{
        [NSException raise: @"Unknown tabTitle: " format: @" %@ ",tabTitle];
    };
    UINavigationController * NavVc0 = [self.storyboard instantiateViewControllerWithIdentifier:@"CoreNavController"];
    CoreViewController * vc0 = (CoreViewController*) NavVc0.topViewController;
    vc0.wallNumberID = 0;
    vc0.wallName = [@(vc0.wallNumberID) stringValue];
    VCArray = [@[NavVc0] mutableCopy];
    [self setViewControllers: VCArray direction: UIPageViewControllerNavigationDirectionForward animated: NO completion: nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    CoreViewController * prevVC = ((CoreViewController *)((UINavigationController*)viewController).topViewController);
    if(prevVC == nil){
        return nil;
    }
    NSUInteger wantedWallNumberID = prevVC.wallNumberID + 1;
    UINavigationController * nextNavVC;
    CoreViewController * nextVC;
    if( (wantedWallNumberID+1) > VCArray.count){
        nextNavVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CoreNavController"];
        nextVC = (CoreViewController*) nextNavVC.topViewController;
        nextVC.wallName = [@(wantedWallNumberID) stringValue];
        nextVC.wallNumberID = wantedWallNumberID;
        [VCArray addObject:nextNavVC];
    } else{
        nextNavVC = [VCArray objectAtIndex: wantedWallNumberID];
    }
    return nextNavVC;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    CoreViewController * prevVC = ((CoreViewController *)((UINavigationController*)viewController).topViewController);
    if(prevVC == nil){
        return nil;
    }
    NSUInteger wantedWallNumberID = prevVC.wallNumberID - 1;
    if(wantedWallNumberID == -1){
        return nil;
    }
    return [VCArray objectAtIndex:wantedWallNumberID];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
