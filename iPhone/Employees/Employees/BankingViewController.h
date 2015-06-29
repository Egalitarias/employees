//
//  BankingViewController.h
//  Employees
//
//  Created by Gary Davies on 18/04/2014.
//  Copyright (c) 2014 Gary Davies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "UpdateDelegate.h"

@interface BankingViewController : BaseViewController <UITextFieldDelegate,UpdateDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, weak) IBOutlet UITextField *bsbNumberTextField;
@property (nonatomic, weak) IBOutlet UITextField *accountNumberTextField;
@property (nonatomic, weak) IBOutlet UITextField *bankNameTextField;
@property (nonatomic, weak) IBOutlet UITextField *bankBranchTextField;
@property (nonatomic, weak) IBOutlet UITextField *accountNameTextField;

@property (nonatomic, weak) IBOutlet UITextField *superFundNameTextField;
@property (nonatomic, weak) IBOutlet UITextField *superMemberNumberTextField;

@property (nonatomic, weak) IBOutlet UITextField *qantasFFNumberTextField;
@property (nonatomic, weak) IBOutlet UITextField *virginVelocityTextField;
@property (nonatomic, weak) IBOutlet UITextField *emiratesSkywardsNumberTextField;
@property (nonatomic, weak) IBOutlet UITextField *othersTextField;

-(IBAction)addButtonPressed:(id)sender;
-(IBAction)completeButtonPressed:(id)sender;
-(IBAction)fillButtonPressed:(id)sender;

@end
