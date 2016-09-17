//
//  TransactionDataSource.m
//  FuelPFMClient
//
//  Created by Christophe Ecabert on 17/09/16.
//  Copyright © 2016 Christophe Ecabert. All rights reserved.
//

#import "TransactionDataSource.h"

@import Firebase;

@implementation TransactionDataSource

- (BOOL)tableView:(UITableView *)tableView
canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  return YES;
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    [[self refForIndex:indexPath.row] removeValue];
  }
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  if ([self count] != 0) {
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.backgroundView   =  nil;
  }
  return [self count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  UILabel *noDataLabel         = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, tableView.bounds.size.height)];
  noDataLabel.text             = @"No entry yet";
  noDataLabel.textColor        = [UIColor blackColor];
  noDataLabel.textAlignment    = NSTextAlignmentCenter;
  tableView.backgroundView = noDataLabel;
  tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  return 1;
}

@end
