//
//  TransactionTableViewCell.h
//  FuelPFMClient
//
//  Created by Christophe Ecabert on 17/09/16.
//  Copyright © 2016 Christophe Ecabert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransactionTableViewCell : UITableViewCell
/** Referenece to date */
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
/** Referenece to date */
@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;
/** Reference to price */
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
