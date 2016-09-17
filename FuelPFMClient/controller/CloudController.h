//
//  CloudController.h
//  FuelPFMClient
//
//  Created by Christophe Ecabert on 17/09/16.
//  Copyright © 2016 Christophe Ecabert. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RootTabController.h"

@interface CloudController : UIViewController

/** Email textView reference */
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

/** Password textView reference */
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

/** User data ackowledge */
@property (weak, nonatomic) IBOutlet UIButton *validtaionButton;

@property RootTabController* rootController;




@end
