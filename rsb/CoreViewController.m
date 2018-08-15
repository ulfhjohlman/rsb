//
//  CoreViewController.m
//  RouteSetterBuddy
//
//  Created by Ulf Hjohlman on 2018-07-06.
//  Copyright © 2018 FatPinchStudios. All rights reserved.
//

#import "CoreViewController.h"
#import "CoreTableViewCell.h"
#import "CorePageViewController.h"
@import Firebase;

@interface CoreViewController ()
@end

@implementation CoreViewController{
    FIRDatabaseReference * ref;
    NSString * wallPath;
    FIRDatabaseHandle addListenerHandle;
    FIRDatabaseHandle removeListenerHandle;
    FIRDatabaseHandle changeListenerHandle;
    NSMutableArray<FIRDataSnapshot *> * activeSnapshotArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    activeSnapshotArray = [[NSMutableArray alloc] init];
    
    CorePageViewController* parentVC =((CorePageViewController*) self.parentViewController);
    NSAssert([parentVC isKindOfClass:[CorePageViewController class]], @"WARNING: PrevVC is not a CorePageViewController. How did we get here?");
    
    wallPath = [[parentVC.gymClimbingTypePath stringByAppendingString: @"/"] stringByAppendingString:self.wallName];
    
    [self configDatabase];
    
    
}

-(void)configDatabase{
    ref = [[[FIRDatabase database] reference] child: wallPath];
    addListenerHandle = [ref  observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot *snapshot) {
        [self->activeSnapshotArray addObject:snapshot];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self->activeSnapshotArray.count-1 inSection:0]] withRowAnimation: UITableViewRowAnimationAutomatic];
    }];
}

- (void)dealloc {
    [ref removeObserverWithHandle: addListenerHandle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * reuseID = @"ReuseCellID";
    CoreTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier: reuseID];
    
    if (cell == nil) {
        cell = [[CoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    //cell.textLabel.text = [self.tableCellsText objectAtIndex:indexPath.row];
    
    FIRDataSnapshot * snapshot = activeSnapshotArray[indexPath.row];
    [cell configureDataFromSnapshot: snapshot];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return activeSnapshotArray.count;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
