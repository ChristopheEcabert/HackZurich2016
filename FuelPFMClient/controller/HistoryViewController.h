//
//  HistoryViewController.h
//  FuelPFMClient
//
//  Created by Christophe Ecabert on 17/09/16.
//  Copyright © 2016 Christophe Ecabert. All rights reserved.
//

#import <UIKit/UIKit.h>

@import FirebaseDatabaseUI;
@import Firebase;

@interface HistoryViewController : UIViewController <UITableViewDelegate>

/** Reference to data base */
@property (strong, nonatomic) FIRDatabaseReference* ref;
/** Reference to UI */
@property (strong, nonatomic) FirebaseTableViewDataSource* dataSource;
/** Reference to UI */
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/** Total gas */
@property (weak, nonatomic) IBOutlet UILabel *totalGazeLabel;

@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;

/** Provide user ID */
- (NSString *) getUid;

@end
