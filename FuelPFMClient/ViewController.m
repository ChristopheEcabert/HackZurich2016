//
//  ViewController.m
//  FuelPFMClient
//
//  Created by Christophe Ecabert on 17/09/16.
//  Copyright © 2016 Christophe Ecabert. All rights reserved.
//

#import "ViewController.h"

@import Firebase;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  
  
  // Authentification
  [[FIRAuth auth] signInWithEmail:@"christophe.ecabert@gmail.com"
                         password:@"toto1234"
                       completion:^(FIRUser*  user, NSError* error) {
                         if (error) {
                           NSLog(@"Error at login : %@",error.localizedDescription);
                         } else {
                           // Push something
                           
                           // Get database references
                           FIRDatabaseReference *rootRef= [[FIRDatabase database] reference];
                           NSString* usrID = [FIRAuth auth].currentUser.uid;
                           
                           NSDictionary* post = @{@"uid" : usrID,
                                                  @"Hello" : @"World"};
                           
                           [rootRef updateChildValues:post];
                           
                           // Unauth
                           //[[FIRAuth auth] signOut:nil];
                         }
                         }];
}

-(void)viewWillDisappear:(BOOL)animated {
  // Sign out
  [[FIRAuth auth] signOut:nil];
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
