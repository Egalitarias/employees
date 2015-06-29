//
//  ContactViewController.h
//  Employees
//
//  Created by Gary Davies on 18/04/2014.
//  Copyright (c) 2014 Gary Davies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "UpdateDelegate.h"

@interface ContactViewController : BaseViewController <UITextFieldDelegate,UpdateDelegate>

@property (nonatomic, weak) IBOutlet UITextField *nameTextField;
@property (nonatomic, weak) IBOutlet UITextField *addressTextField;
@property (nonatomic, weak) IBOutlet UITextField *telephoneTextField;
@property (nonatomic, weak) IBOutlet UITextField *mobileTextField;

-(IBAction)addButtonPressed:(id)sender;
-(IBAction)nextButtonPressed:(id)sender;

@end
