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

-(void)viewDidLayoutSubviews{
  [super viewDidLayoutSubviews];
  // Init plot
  //[self initPlot];
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
  [[self getQuery] observeEventType:FIRDataEventTypeValue
                          withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
                            
                            Transaction* transaction = snapshot.value;
                            [self.data addObject:transaction];
                          }];
}

#pragma mark -
#pragma mark Initialize plot

-(double) maxValue {
  double maxValue = 0.0;
  for (Transaction* transaction in _data) {
    double v = [[transaction.vehicle_data objectForKey:@"lt_pump"] doubleValue];
    if (v > maxValue) {
      maxValue = v;
    }
  }
  return maxValue;
}

-(void)initPlot {
  [self configureHostView];
  [self configureGraph];
  [self configureChart];
  [self configureLegend];
}

-(void)configureHostView {
  _hostGraphView.allowPinchScaling = NO;
  
}

-(void)configureGraph {
  // 1 - Create and configure the graph
  CPTXYGraph* graph = [[CPTXYGraph alloc] initWithFrame: [_hostGraphView frame]];
  _hostGraphView.hostedGraph = graph;
  graph.fill = [[CPTFill alloc] initWithColor:[CPTColor clearColor]];
  graph.paddingLeft = 10.0;
  graph.paddingTop = 30.0;
  graph.paddingRight = 10.0;
  graph.paddingBottom = 30.0;
  graph.axisSet = nil;

  
  // 2 - Create text style
  CPTMutableTextStyle* textStyle = [[CPTMutableTextStyle alloc] init];
  textStyle.color = [CPTColor blackColor];
  textStyle.fontName = @"HelveticaNeue";
  textStyle.fontSize = 12;
  textStyle.textAlignment = CPTTextAlignmentCenter;
  
  // 3 - Set graph title and text style
  graph.title = @"Test TOTO";
  graph.titleTextStyle = textStyle;
  graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
  
  // 4 - Set up plot space
  double xmin = 0;
  double xmax = [self.data count];
  double ymin = 0;
  double ymax = 1.4 * [self maxValue];
  CPTXYPlotSpace* space = (CPTXYPlotSpace *)graph.defaultPlotSpace;
  space.xRange = [[CPTPlotRange alloc]
                  initWithLocationDecimal:CPTDecimalFromDouble(xmin)
                  lengthDecimal:CPTDecimalFromDouble(xmax - xmin)];
  
  space.yRange = [[CPTPlotRange alloc]
                  initWithLocationDecimal:CPTDecimalFromDouble(ymin)
                  lengthDecimal:CPTDecimalFromDouble(ymax - ymin)];
  
  
}

-(void)configureChart {
  // 1 - Set up the three plots
  CPTBarPlot* plot = [[CPTBarPlot alloc] init];
  plot.fill = [[CPTFill alloc]
               initWithColor:[CPTColor colorWithComponentRed:0.92f
                                                       green:0.28f
                                                        blue:0.25f
                                                       alpha:1.f]];
  // 2 - Set up line style
  CPTMutableLineStyle* style = [[CPTMutableLineStyle alloc] init];
  style.lineColor = [CPTColor grayColor];
  style.lineWidth = 0.5;
  
  // 3 - Add plots to graph
  CPTGraph* graph = _hostGraphView.hostedGraph;
  plot.dataSource = self;
  plot.delegate = self;
  plot.barWidth = [NSNumber numberWithInt:5];
  plot.barOffset = [NSNumber numberWithInt:5];
  plot.lineStyle = style;
  [graph addPlot:plot toPlotSpace:graph.defaultPlotSpace];
}

-(void)configureLegend {
  
}

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot {
  return [_data count];
}



@end
