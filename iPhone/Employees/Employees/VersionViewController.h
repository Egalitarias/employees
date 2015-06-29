//
//  VersionViewController.h
//  Employees
//
//  Created by Gary Davies on 7/04/2014.
//  Copyright (c) 2014 Gary Davies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "UpdateDelegate.h"

@interface VersionViewController : BaseViewController <UITextFieldDelegate,UpdateDelegate>

@property (nonatomic, strong) IBOutlet UITextField *version;

-(IBAction)setButtonPressed:(id)sender;
-(IBAction)getButtonPressed:(id)sender;
-(IBAction)backButtonPressed:(id)sender;

-(void)update;
-(void)successUpdate:(NSDictionary *)request response:(NSDictionary *)response;
-(void)failUpdate:(NSDictionary *)request response:(NSDictionary *)response error:(NSError *)error;

@end
