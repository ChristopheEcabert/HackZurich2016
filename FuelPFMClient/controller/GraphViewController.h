//
//  GraphViewController.h
//  FuelPFMClient
//
//  Created by Christophe Ecabert on 17/09/16.
//  Copyright © 2016 Christophe Ecabert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CorePlot.h>

@import Firebase;


@interface GraphViewController : UIViewController<CPTBarPlotDataSource, CPTBarPlotDelegate>

/** Reference to data base */
@property (strong, nonatomic) FIRDatabaseReference* ref;
/** All date queried */
@property (strong, nonatomic) NSMutableArray* data;


@property (weak, nonatomic) IBOutlet CPTGraphHostingView *hostGraphView;

/** Provide user ID */
- (NSString *) getUid;

@end
