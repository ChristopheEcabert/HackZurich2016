//
//  GraphViewController.m
//  FuelPFMClient
//
//  Created by Christophe Ecabert on 17/09/16.
//  Copyright © 2016 Christophe Ecabert. All rights reserved.
//

#import "GraphViewController.h"
#import "Transaction.h"

@interface GraphViewController ()

@end

@implementation GraphViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Init container
  self.data = [[NSMutableArray alloc] init];
  
  // Get reference to database
  NSString* child = [NSString stringWithFormat:@"data2/%@", [self getUid]];
  self.ref = [[[FIRDatabase database] reference] child:child];
}

-(void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  [self queraData];
}

-(void) viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [[self getQuery] removeAllObservers];
}


/** Provide user ID */
- (NSString *) getUid {
  return [FIRAuth auth].currentUser.uid;
}

/** Provide query */
- (FIRDatabaseQuery *) getQuery {
  return [self.ref queryOrderedByChild:@"timestamp"];
}

-(void) queraData {
  // Query all date
  [self.data removeAllObjects];
  [[self getQuery] observeEventType:FIRDataEventTypeChildAdded
                          withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
                            
                            Transaction* transaction = snapshot.value;
                            [self.data addObject:transaction];
                          }];
}

@end
