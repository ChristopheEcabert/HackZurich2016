//
//  RootTabController.m
//  FuelPFMClient
//
//  Created by Christophe Ecabert on 17/09/16.
//  Copyright © 2016 Christophe Ecabert. All rights reserved.
//

#import "RootTabController.h"
#import "CloudController.h"

@import Firebase;

//typedef void (^authCallback)(FIRUser* user, NSError* error);

@interface RootTabController () <UITabBarControllerDelegate>

/** Database reference */
@property (strong, nonatomic) FIRDatabaseReference* rootRef;

@end


@implementation RootTabController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  
  self.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  // Close database connection
  [[FIRAuth auth] signOut:nil];
}

-(void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  [self connectToDatabase];
  
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

/*// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  // Get the new view controller using [segue destinationViewController].
  // Pass the selected object to the new view controller.
  NSLog(@"Tag : %@", [segue identifier]);
  int a = 0;
 }*/

#pragma mark -
#pragma mark Database connection

-(void) connectToDatabase {
  // Open plist and check for user
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                       NSUserDomainMask,
                                                       YES);
  NSString *documentsDirectory = [paths objectAtIndex:0];
  NSString *path = [documentsDirectory stringByAppendingPathComponent:@"user_info.plist"];
  NSFileManager *fileManager = [NSFileManager defaultManager];
  NSDictionary* user_info;
  if (![fileManager fileExistsAtPath:path]) {
    id obj[] = {@"", @""};
    id key[] = {@"email",@"pwd"};
    user_info = [NSDictionary dictionaryWithObjects:obj forKeys:key count:2];
    [user_info writeToFile:path atomically:YES];
  } else {
    user_info = [[NSDictionary alloc]
                 initWithContentsOfFile:path];
  }
  NSString* email = [user_info objectForKey:@"email"];
  NSString* pwd = [user_info objectForKey:@"pwd"];
  if ([email length] != 0 && [pwd length] != 0) {
    // Connect to data base with stored login
    [[FIRAuth auth] signInWithEmail:email
                           password:pwd
                         completion:^(FIRUser* user, NSError* error){
                           
                           
                           
                           NSLog(@"Log : %@", error.localizedDescription);
                           
                           /*FIRDatabaseReference* ref = [[FIRDatabase database] reference];
                            
                            FIRDatabaseQuery* users = [ref child:@"data2/Ws9PLZoJfiM3GEBReLJf5qYQkL02"];
                            
                            //FIRDatabaseQuery* spec = [users queryEqualToValue:@"christophe"];
                            
                            [users observeEventType:FIRDataEventTypeChildAdded
                            withBlock:^(FIRDataSnapshot* snapshot) {
                            
                            NSLog(@"key was : %@", snapshot.key);
                            
                            
                            
                            }];
                            
                            int a = 0;*/
                           
                           
                           
                           
                         }];
    
    
  } else {
    // Switch to config tab
    UIViewController* obj = [[self viewControllers] objectAtIndex:2];
    CloudController* ctrl = (CloudController*)obj;
    ctrl.rootController = self;
    [self setSelectedIndex:2];
  }
}

@end
