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
    addListenerHandle = [db_ref  observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *snapshot) {
        [self->activeSnapshotArray removeAllObjects];
        for (FIRDataSnapshot* child in snapshot.children){
                [self->activeSnapshotArray addObject:child];
        }
        self.expandedIndexPath = nil;
        [self.tableView reloadData];
        //[self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self->activeSnapshotArray.count-1 inSection:0]] withRowAnimation: UITableViewRowAnimationAutomatic];
        [self sortActiveSnapshotArray];
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

-(void)sortActiveSnapshotArray{
    [activeSnapshotArray sortUsingComparator:^NSComparisonResult(id a, id b) {
        NSDictionary<NSString*,NSString*> * aSnapDictionary = ((FIRDataSnapshot *)a).value;
        NSDictionary<NSString*,NSString*> * bSnapDictionary = ((FIRDataSnapshot *)b).value;
        NSString *firstColor = aSnapDictionary[@"color"];
        NSString *secondColor = bSnapDictionary[@"color"];
        NSString *firstDiff = aSnapDictionary[@"difficulty"];
        NSString *secondDiff = bSnapDictionary[@"difficulty"];
        
        if(secondColor == nil){
            return NSOrderedAscending;
        }
        if(firstColor == nil){
            return NSOrderedDescending;
        }
        NSComparisonResult result = [CoreViewController compareColorDiff:firstColor To:secondColor];
        if( result == NSOrderedSame){
            if(secondDiff == nil){
                return NSOrderedAscending;
            }
            if(firstDiff == nil){
                return NSOrderedDescending;
            }
            return [CoreViewController compareDifficulty:firstDiff To:secondDiff];
        }
        else return result;
    }];
}

+ (NSComparisonResult) compareColorDiff: (NSString*) firstColor To:(NSString*) secondColor{
    return [[CoreViewController colorDiffToInt:firstColor] compare:[CoreViewController colorDiffToInt:secondColor]];
}

+(NSNumber *) colorDiffToInt: (NSString *) color{
    if([color isEqualToString:@"purple"]){
        return [NSNumber numberWithInt:0];
    }
    if([color isEqualToString:@"white"]){
        return [NSNumber numberWithInt:1];
    }
    if([color isEqualToString:@"blue"]){
        return [NSNumber numberWithInt:2];
    }
    if([color isEqualToString:@"black"]){
        return [NSNumber numberWithInt:3];
    }
    if([color isEqualToString:@"red"]){
        return [NSNumber numberWithInt:4];
    }
    if([color isEqualToString:@"orange"]){
        return [NSNumber numberWithInt:5];
    }
    if([color isEqualToString:@"pink"]){
        return [NSNumber numberWithInt:6];
    }
    if([color isEqualToString:@"green"]){
        return [NSNumber numberWithInt:7];
    }
    if([color isEqualToString:@"yellow"]){
        return [NSNumber numberWithInt:8];
    }
    NSLog(@"WARNING unknown color: %@, converted to int :S!!!", color);
    return nil;
}

+(NSComparisonResult) compareDifficulty: (NSString *) firstDiff To: (NSString *) secondDiff{
    return [[CoreViewController diffToInt:firstDiff] compare:[CoreViewController diffToInt:secondDiff]];
}

+(NSNumber *) diffToInt: (NSString*) diff{
    if( [diff isEqualToString:@"mm"]){
        return [NSNumber numberWithInt:0];
    }
    if( [diff isEqualToString:@"m"]){
        return [NSNumber numberWithInt:1];
    }
    if( [diff isEqualToString:@"bm"]){
        return [NSNumber numberWithInt:2];
    }
    if( [diff isEqualToString:@"p"]){
        return [NSNumber numberWithInt:3];
    }
    if( [diff isEqualToString:@"pp"]){
        return [NSNumber numberWithInt:4];
    }
    NSLog(@"WARNING unknown difficulty: %@, converted to int :S!!!", diff);
    return nil;
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
