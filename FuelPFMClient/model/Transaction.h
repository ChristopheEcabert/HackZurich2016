//
//  Transaction.h
//  FuelPFMClient
//
//  Created by Christophe Ecabert on 17/09/16.
//  Copyright © 2016 Christophe Ecabert. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Transaction : NSObject

/** Timestamp */
@property(strong, nonatomic) NSString *timestamp;
/** Vehicle Data */
@property(strong, nonatomic) NSDictionary<NSString*, NSString*>* vehicle_data;

@end
