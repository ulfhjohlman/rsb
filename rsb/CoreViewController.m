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
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+FirebaseStorage.h"
@import Firebase;

@interface CoreViewController ()
@end

@implementation CoreViewController{
    FIRDatabaseReference * db_ref;
    FIRDatabaseReference * db_ref_pic;
    FIRStorage * storage;
    FIRStorageReference * storage_ref;
    NSString * wallPath;
    FIRDatabaseHandle picChangeListenerHandle;
    FIRDatabaseHandle addListenerHandle;
    //FIRDatabaseHandle removeListenerHandle;
    //FIRDatabaseHandle changeListenerHandle;
    NSMutableArray<FIRDataSnapshot *> * activeSnapshotArray;
    NSString * wallPicPath;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    activeSnapshotArray = [[NSMutableArray alloc] init];
    
    CorePageViewController* parentVC =((CorePageViewController*) self.parentViewController);
    NSAssert([parentVC isKindOfClass:[CorePageViewController class]], @"WARNING: PrevVC is not a CorePageViewController. How did we get here?");
    
    wallPath = [[parentVC.gymClimbingTypePath stringByAppendingString: @"/"] stringByAppendingString:self.wallName];
    
    storage = [FIRStorage storage];
    [self configDatabase];

    
    
    
    
}

-(void)configDatabase{
    NSString * contentPath = [wallPath stringByAppendingString:@"/content"];
    db_ref = [[[FIRDatabase database] reference] child: contentPath];
    addListenerHandle = [db_ref  observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot *snapshot) {
        [self->activeSnapshotArray addObject:snapshot];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self->activeSnapshotArray.count-1 inSection:0]] withRowAnimation: UITableViewRowAnimationAutomatic];
    }];
    
    //wall picture storage url handling
    db_ref_pic = [[[FIRDatabase database] reference] child: [wallPath stringByAppendingString:@"/picFileName"]];
    picChangeListenerHandle = [db_ref_pic observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *snapshot) {
        if(snapshot.exists){
            self->wallPicPath = [[self->wallPath stringByAppendingString: @"/"] stringByAppendingString:snapshot.value];
            [self refreshPicture];
        }
    }];
}

- (void)dealloc {
    [db_ref removeObserverWithHandle: addListenerHandle];
    [db_ref_pic removeObserverWithHandle:picChangeListenerHandle];
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView beginUpdates];
    if ([indexPath compare:self.expandedIndexPath] == NSOrderedSame) {
        self.expandedIndexPath = nil;
    } else {
        self.expandedIndexPath = indexPath;
    }
    [tableView endUpdates];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath && indexPath.section == 0 &&
        ([indexPath compare:self.expandedIndexPath] == NSOrderedSame)) {
        return 115.0;
    }
    return 42.0;
}


-(void)refreshPicture{
    storage_ref = [storage referenceWithPath: wallPicPath];
    [self.imageView sd_setImageWithStorageReference:storage_ref placeholderImage:nil];
    [self.view setNeedsDisplay];
}

@end
