//
//  CloudController.m
//  FuelPFMClient
//
//  Created by Christophe Ecabert on 17/09/16.
//  Copyright © 2016 Christophe Ecabert. All rights reserved.
//

#import "CloudController.h"

@interface CloudController () <UITextFieldDelegate>

/** Data login account */
@property NSString* email;
/** Database pwd */
@property NSString* pwd;


/**
 *  @name updateUserTextField
 *  @brief  Update textField with new informations
 */
-(void) updateUserTextField;

/**
 *  @name updateUserConfigFile
 *  @brief  Update entries saved into config file
 */
-(void) updateUserConfigFile;

@end


@implementation CloudController

@synthesize rootController;

- (void)viewDidLoad {
  [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  NSLog(@"Config shows up");
  
  // Check if field are set
  if ([_email length] != 0 && [_pwd length] != 0) {
    [self updateUserTextField];
  } else {
    // Querry from file to see if something exist
    NSString* conf = [[NSBundle mainBundle] pathForResource:@"user_info"
                                                     ofType:@"plist"];
    NSDictionary* user_data = [[NSDictionary alloc]
                               initWithContentsOfFile:conf];
    if (user_data) {
      NSString* email = [user_data objectForKey:@"email"];
      NSString* pwd = [user_data objectForKey:@"pwd"];
      if ([email length] != 0 && [pwd length] != 0) {
        _email = email;
        _pwd = pwd;
        [self updateUserTextField];
      }
    }
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



#pragma mark -
#pragma mark Update TextField

/**
 *  @name updateUserTextField
 *  @brief  Update textField with new informations
 */
-(void) updateUserTextField {
  [_emailTextField setText:_email];
  [_passwordTextField setText:_pwd];
}

/**
 *  @name updateUserConfigFile
 *  @brief  Update entries saved into config file
 */
-(void) updateUserConfigFile {
  
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                       NSUserDomainMask,
                                                       YES);
  NSString *documentsDirectory = [paths objectAtIndex:0];
  NSString *path = [documentsDirectory stringByAppendingPathComponent:@"user_info.plist"];
  NSFileManager *fileManager = [NSFileManager defaultManager];
  if ([fileManager fileExistsAtPath:path]) {
    
    NSMutableDictionary* data = [[NSMutableDictionary alloc]
                                 initWithContentsOfFile:path];
    if (data) {
      [data setValue:_email forKey:@"email"];
      [data setValue:_pwd forKey:@"pwd"];
      
      
      
      BOOL succes = [data writeToFile:path atomically:YES];
      int a = 0;
    }
  }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
  // Show button
  [_validtaionButton setHidden:NO];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
  // User finished typing (hit return): hide the keyboard.
  [textField resignFirstResponder];
  return YES;
}

-(void) textFieldDidEndEditing:(UITextField *)textField {
  NSLog(@"Something change : %@", textField.text);
  
  // Update edited entry
  if (textField == _emailTextField) {
    _email = textField.text;
  } else {
    _pwd = textField.text;
  }
}
- (IBAction)saveUserChanges:(id)sender {
  // Update config file and go to back to menu 1
  _email = [_emailTextField text];
  _pwd = [_passwordTextField text];
  [self updateUserConfigFile];
  // Try to connect
  if (rootController) {
    [rootController connectToDatabase];
    [rootController setSelectedIndex:0];
  }
}

@end
