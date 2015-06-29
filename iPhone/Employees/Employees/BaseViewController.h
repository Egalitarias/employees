//
//  BaseViewController.h
//  Employees
//
//  Created by Gary Davies on 7/04/2014.
//  Copyright (c) 2014 Gary Davies. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBProgressHUD;

@interface BaseViewController : UIViewController

@property (nonatomic, strong) MBProgressHUD *progressHUD;

- (void)showInfoAlert:(NSString *)message;
- (BOOL) isStringInDateFormat:(NSString*)string;
- (NSString *)makeImageName:(NSString *)familyName givenName:(NSString *)givenName type:(NSString *)type employeeId:(int)employeeId;

@end
