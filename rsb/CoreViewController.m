//
//  CoreViewController.m
//  RouteSetterBuddy
//
//  Created by Ulf Hjohlman on 2018-07-06.
//  Copyright © 2018 FatPinchStudios. All rights reserved.
//

#import "CoreViewController.h"
#import "CoreTableViewCell.h"

@interface CoreViewController ()
@end

@implementation CoreViewController{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableCellsText = [NSArray arrayWithObjects: @"Bajs på dig", @"row2",@"row3",nil];
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
    cell.textLabel.text = [self.tableCellsText objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableCellsText.count;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
