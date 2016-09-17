//
//  HistoryViewController.m
//  FuelPFMClient
//
//  Created by Christophe Ecabert on 17/09/16.
//  Copyright © 2016 Christophe Ecabert. All rights reserved.
//

#import "HistoryViewController.h"
#import "TransactionDataSource.h"
#import "TransactionTableViewCell.h"
#import "Transaction.h"

@interface HistoryViewController ()

@end

@implementation HistoryViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Create database reference
  NSString* child = [NSString stringWithFormat:@"data2/%@", [self getUid]];
  self.ref = [[[FIRDatabase database] reference] child:child];
  
  // Populate tableview
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
  NSDate* today = [NSDate date];
  __block NSInteger total_fuel = 0;
  self.dataSource = [[TransactionDataSource alloc] initWithQuery:[self getQuery]
                                                  modelClass:[Transaction class]
                                                    nibNamed:@"TransactionTableViewCell"
                                         cellReuseIdentifier:@"transaction"
                                                        view:self.tableView];
  [self.dataSource populateCellWithBlock:^void(TransactionTableViewCell *__nonnull cell,
                                              Transaction *__nonnull transaction) {

  
    cell.quantityLabel.text = [transaction.vehicle_data objectForKey:@"lt_pump"];
    cell.dateLabel.text = transaction.timestamp;
    
    // Get time interval
    NSDate* date = [dateFormatter dateFromString:transaction.timestamp];
    NSDateComponents* comp = [[NSCalendar currentCalendar]
                              components:(NSCalendarUnitDay)
                              fromDate:date
                              toDate:today options:0];
    if([comp day] < 30) {
      total_fuel += [cell.quantityLabel.text integerValue];
      
      // Update conso
      self.averageGazeLabel.text = [NSString stringWithFormat:@"%ld", (long)total_fuel];

    }
  }];
  self.tableView.dataSource = self.dataSource;
  self.tableView.delegate = self;
  
  
}

-(void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  // Reload data
  [self.tableView reloadData];
}

- (NSString *) getUid {
  return [FIRAuth auth].currentUser.uid;
}

- (FIRDatabaseQuery *) getQuery {
  return [self.ref queryOrderedByChild:@"timestamp"];
  //return self.ref;
}

/*-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 150;
}*/

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
