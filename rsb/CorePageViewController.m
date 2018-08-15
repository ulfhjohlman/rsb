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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = self;
    self.delegate = self;
    
    [self configureClimbingType];
    [self configureGymName];
    self.gymBasePath = [NSString stringWithFormat: @"gyms/%@",self.gymName];
    self.gymClimbingTypePath = [NSString stringWithFormat: @"%@/%@",self.gymBasePath,self.pageClimbingType];
    self.wallListPath = [NSString stringWithFormat: @"%@/WALL_LIST",self.gymClimbingTypePath];
    
    
    self.wallsList = [[NSMutableArray alloc] init];
    self.VCDictionary =  [[NSMutableDictionary alloc] init];
    [self configureDatabase];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    CoreViewController * prevVC = (CoreViewController *)viewController;
    CoreViewController * nextVC;
    NSAssert([prevVC isKindOfClass:[CoreViewController class]], @"WARNING: PrevVC is not a CoreViewController. How did we get here?");
    
    NSUInteger wanted = [self.wallsList indexOfObject:prevVC.wallName] + 1;
    NSNumber * wantedWallIndex = [[NSNumber alloc] initWithUnsignedLong:wanted];
    if( wantedWallIndex.intValue == self.wallsList.count){
        wantedWallIndex = [NSNumber numberWithInt: 0];
    }
    nextVC = (CoreViewController*)[self.VCDictionary objectForKey:wantedWallIndex];
    
    if(nextVC == nil){
        nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CoreViewController"];
        nextVC.wallName = self.wallsList[wantedWallIndex.intValue];
        nextVC.wallID = [self.pageClimbingType stringByAppendingString: nextVC.wallName];
        [self.VCDictionary setObject:nextVC forKey:wantedWallIndex];
        //build arr
    }
    return nextVC;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    CoreViewController * prevVC = (CoreViewController *)viewController;
    CoreViewController * nextVC;
    NSAssert([prevVC isKindOfClass:[CoreViewController class]], @"WARNING: PrevVC is not a CoreViewController. How did we get here?");
    
    NSUInteger wanted = [self.wallsList indexOfObject:prevVC.wallName] - 1;
    NSNumber * wantedWallIndex = [[NSNumber alloc] initWithUnsignedLong:wanted];
    if( wantedWallIndex.intValue == -1){
        wantedWallIndex = [NSNumber numberWithUnsignedLong: self.wallsList.count-1];
    }
    nextVC =  (CoreViewController*)[self.VCDictionary objectForKey:wantedWallIndex];
    
    if(nextVC == nil){
        nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CoreViewController"];
        nextVC.wallName = self.wallsList[wantedWallIndex.intValue];
        nextVC.wallID = [self.pageClimbingType stringByAppendingString: nextVC.wallName];
        [self.VCDictionary setObject:nextVC forKey:wantedWallIndex];
        //build arr
    }
    return nextVC;
}

-(void)configureDatabase{
    self.ref = [[FIRDatabase database] reference];
    // Listen for new messages in the Firebase database
    [[self.ref child:self.wallListPath] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *snapshot) {
        NSEnumerator *children = [snapshot children];
        FIRDataSnapshot *child;
        while (child = [children nextObject]) {
            [self.wallsList addObject:child.value];
        }

        
        //TODO wall wise view controller logic
        CoreViewController * vc0 = [self.storyboard instantiateViewControllerWithIdentifier:@"CoreViewController"];
        
        vc0.wallName = self.wallsList[0];
        vc0.wallID = [self.pageClimbingType stringByAppendingString: vc0.wallName];
        
        [self.VCDictionary setObject:vc0 forKey: [[NSNumber alloc] initWithInt:0]];
        [self setViewControllers: @[vc0] direction: UIPageViewControllerNavigationDirectionForward animated: NO completion: nil];
        
        self.navigationItem.title = vc0.wallName;
    }];

}

// ====== not needed with observeSINGLEevent... ====
//- (void)dealloc {
//    [[self.ref child:wallListPath] removeObserverWithHandle: self.refHandleWallList];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)configureGymName{
    self.userSettings = NSUserDefaults.standardUserDefaults;
    self.gymName = [self.userSettings stringForKey:@"currentGym"];
    if(self.gymName == nil){
        NSLog(@"No gym selected, defualting to KLC");
        //TODO gym selection
        self.gymName = @"fysiken-klatterlabbet-centrum";
        [self.userSettings setObject:@"fysiken-klatterlabbet-centrum" forKey:@"currentGym"];
    }
}

-(void)configureClimbingType{
    NSString * tabTitle = self.tabBarController.tabBar.selectedItem.title;
    if([ tabTitle isEqual: (@"Boulders")]){
        self.pageClimbingType = @"boulders";
    }else if([ tabTitle isEqual: (@"Routes")]){
        self.pageClimbingType = @"routes";
    }else{
        [NSException raise: @"Unknown tabTitle: " format: @" %@ ",tabTitle];
    };
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    if(completed){
        self.navigationItem.title = ((CoreViewController *)self.viewControllers.firstObject).wallName;
    }
}
@end
