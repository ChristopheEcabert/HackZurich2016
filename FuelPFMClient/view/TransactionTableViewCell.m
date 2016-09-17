//
//  TransactionTableViewCell.m
//  FuelPFMClient
//
//  Created by Christophe Ecabert on 17/09/16.
//  Copyright © 2016 Christophe Ecabert. All rights reserved.
//

#import "TransactionTableViewCell.h"

@import Firebase;

@interface TransactionTableViewCell()

  /** Reference to cell in db */
  @property (strong, nonatomic) FIRDatabaseReference *TransactionRef;
@end

@implementation TransactionTableViewCell

- (instancetype)initWithFrame:(CGRect)frame {
  return [super initWithFrame:frame];
}

@end
