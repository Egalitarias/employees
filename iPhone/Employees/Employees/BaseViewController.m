//
//  BaseViewController.m
//  Employees
//
//  Created by Gary Davies on 7/04/2014.
//  Copyright (c) 2014 Gary Davies. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD.h"

@interface BaseViewController ()

@end

@implementation BaseViewController {
    int photoCount;
}

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Green640x1136.png"]];
    photoCount = 0;
}


#pragma mark - Overridden methods
- (MBProgressHUD *)progressHUD {
	if (_progressHUD == nil) {
		_progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
		[self.view addSubview:_progressHUD];
	}
	return _progressHUD;
}


-(void)showInfoAlert:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (BOOL) isStringInDateFormat:(NSString*)string
{
    if((string == nil) || ([string length] != 10)) {
        return false;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSDate *dateFromString = [[NSDate alloc] init];
    
    dateFromString = [dateFormatter dateFromString:string];
    
    if (dateFromString !=nil) {
        return true;
    }
    else {
        return false;
    }
}

- (NSString *)makeImageName:(NSString *)familyName givenName:(NSString *)givenName type:(NSString *)type employeeId:(int)employeeId {
    NSString *imageName = [[NSString alloc] initWithFormat:@"%@_%@_%@_%d_%d.png", familyName, givenName, type, photoCount, employeeId];
    photoCount++;
    
    return imageName;
}

@end
