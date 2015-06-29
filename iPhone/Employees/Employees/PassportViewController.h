//
//  SecondViewController.h
//  Employees
//
//  Created by Gary Davies on 18/04/2014.
//  Copyright (c) 2014 Gary Davies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "UpdateDelegate.h"

@interface PassportViewController : BaseViewController <UITextFieldDelegate, UpdateDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>


@property (nonatomic, weak) IBOutlet UITextField *passportNumberTextField;
@property (nonatomic, weak) IBOutlet UITextField *nationailityTextField;
@property (nonatomic, weak) IBOutlet UITextField *visaTypeTextField;
@property (nonatomic, weak) IBOutlet UITextField *visaNumberTextField;
@property (nonatomic, weak) IBOutlet UITextField *visaIssueDateTextField;
@property (nonatomic, weak) IBOutlet UITextField *visaExpiryDateTextField;

@property (nonatomic, strong) NSString *familyName;
@property (nonatomic, strong) NSString *givenName;
@property (atomic, assign) int employeeId;

-(IBAction)addButtonPressed:(id)sender;
-(IBAction)nextButtonPressed:(id)sender;
-(IBAction)cameraButtonPressed:(id)sender;
-(IBAction)photoButtonPressed:(id)sender;

@end
