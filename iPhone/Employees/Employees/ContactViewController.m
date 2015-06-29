//
//  ContactViewController.m
//  Employees
//
//  Created by Gary Davies on 18/04/2014.
//  Copyright (c) 2014 Gary Davies. All rights reserved.
//

#import "ContactViewController.h"
#import "API.h"
#import "MBProgressHUD.h"

@interface ContactViewController ()

@end

@implementation ContactViewController {
    int contactCount;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        contactCount = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(BOOL)validateUI {
    if((_nameTextField.text == nil) || ([_nameTextField.text length] == 0)) {
        [self showInfoAlert:@"Name is a required field"];
        return NO;
    }
    else if((_addressTextField.text == nil) || ([_addressTextField.text length] == 0)) {
        [self showInfoAlert:@"Address is a required field"];
        return NO;
    }
    else if((_telephoneTextField.text == nil) || ([_telephoneTextField.text length] == 0)) {
        [self showInfoAlert:@"Telephone is a required field"];
        return NO;
    }
    else if((_mobileTextField.text == nil) || ([_mobileTextField.text length] == 0)) {
        [self showInfoAlert:@"Mobile is a required field"];
        return NO;
    }
    
    return YES;
}

-(IBAction)addButtonPressed:(id)sender {
    if([self validateUI]) {
        NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *employee = [userdefaults objectForKey:kEmployee];
        NSNumber *employeeId = [employee objectForKey:kEmployeeId];
        NSDictionary *parameters = @{
                                 @"EmployeeId" : employeeId,
                                 @"Name" : _nameTextField.text,
                                 @"Address" : _addressTextField.text,
                                 @"PhoneNo" : _telephoneTextField.text,
                                 @"MobileNo" : _mobileTextField.text,
                                 };
        [self.progressHUD show:YES];
        [[API sharedInstance] addContactUsingDictionary:parameters delegate:self];
    }
}

-(IBAction)nextButtonPressed:(id)sender {
    if(contactCount >= 2) {
        [self performSegueWithIdentifier:@"ContactToBankingSegue" sender:self];
    }
    else {
        [self showInfoAlert:@"At least two contacts are required"];
    }
}

-(IBAction)fillButtonPressed :(id)sender {
    [_nameTextField setText:@"Contact Name"];
    [_addressTextField setText:@"Contact Address"];
    [_telephoneTextField setText:@"0895672345"];
    [_mobileTextField setText:@"045852431"];
}

-(void)update {
    
}

-(void)successUpdate:(NSDictionary *)request response:(NSDictionary *)response {
    [self.progressHUD hide:YES];
    NSNumber *statusCode = [response objectForKey:@"statusCode"];
    NSNumber *value = nil;
    if([statusCode intValue] == 200) {
        NSDictionary *contact = [response objectForKey:@"body"];
        if(contact != nil) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            value = [contact objectForKey:kContactId];
            [userDefaults setObject:value forKey:kContactId];
            [userDefaults synchronize];
            NSLog(@"ContactId %@", value);
            //[self performSegueWithIdentifier:@"FirstToSecondSegue" sender:self];
            [self showInfoAlert:@"Contact Added."];
            [_nameTextField setText:@""];
            [_addressTextField setText:@""];
            [_telephoneTextField setText:@""];
            [_mobileTextField setText:@""];
            ++contactCount;
        }
    }
    else {
        [self showInfoAlert:@"Server is not available, try again later."];
        NSLog(@"Server response: %d", [statusCode intValue]);
    }
}

-(void)failUpdate:(NSDictionary *)request response:(NSDictionary *)response error:(NSError *)error {
    [self.progressHUD hide:YES];
    [self showInfoAlert:@"Server is not available, try again later."];
    NSLog(@"failUpdate");
}


@end
