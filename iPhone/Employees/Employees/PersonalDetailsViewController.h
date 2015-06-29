//
//  ViewController.h
//  Employees
//
//  Created by Gary Davies on 7/04/2014.
//  Copyright (c) 2014 Gary Davies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "UpdateDelegate.h"

@interface PersonalDetailsViewController : BaseViewController <UITextFieldDelegate, UpdateDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) IBOutlet UITextField *familyNameTextField;
@property (nonatomic, strong) IBOutlet UITextField *givenNameTextField;
@property (nonatomic, strong) IBOutlet UITextField *dateOfBirthTextField;
@property (nonatomic, strong) IBOutlet UITextField *titleTextField;
@property (nonatomic, strong) IBOutlet UITextField *addressTextField;
@property (nonatomic, strong) IBOutlet UITextField *telephoneTextField;
@property (nonatomic, strong) IBOutlet UITextField *mobileTextField;
@property (nonatomic, strong) IBOutlet UITextField *emailTextField;
@property (nonatomic, strong) IBOutlet UITextField *taxFileNumberTextField;
@property (nonatomic, strong) IBOutlet UITextField *companyTextField;
@property (nonatomic, strong) IBOutlet UITextField *australianBusinessNumberTextField;

-(IBAction)versionButtonPressed:(id)sender;
-(IBAction)nextButtonPressed:(id)sender;
-(IBAction)cameraButtonPressed :(id)sender;
-(IBAction)photoButtonPressed:(id)sender;
-(IBAction)addButtonPressed:(id)sender;
-(IBAction)clearButtonPressed:(id)sender;
-(IBAction)fillButtonPressed :(id)sender;

@end
