//
//  BankingViewController.m
//  Employees
//
//  Created by Gary Davies on 18/04/2014.
//  Copyright (c) 2014 Gary Davies. All rights reserved.
//

#import "BankingViewController.h"
#import "API.h"
#import "MBProgressHUD.h"

const int kModeBankingDetails = 0;
const int kModeEmail = 1;

@interface BankingViewController () {
    UIImageView *myImageView;
    BOOL added;
}

@end

@implementation BankingViewController {
    int mode;
    bool bankingDetailsAdded;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        bankingDetailsAdded = false;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    added = NO;
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

-(IBAction)addButtonPressed:(id)sender {
    mode = kModeBankingDetails;
    
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *employee = [userdefaults objectForKey:kEmployee];
    NSNumber *employeeId = [employee objectForKey:kEmployeeId];
    NSDictionary *parameters = @{
                                 @"EmployeeId" : employeeId,
                                 @"BSBNumber" : _bsbNumberTextField.text,
                                 @"AccountNumber" : _accountNumberTextField.text,
                                 @"BankName" : _bankNameTextField.text,
                                 @"BankBranch" : _bankBranchTextField.text,
                                 @"AccountName" : _accountNameTextField.text,
                                 
                                 
                                 @"SuperFundName" : _superFundNameTextField.text,
                                 @"MemberNumber" : _superMemberNumberTextField.text,
                                 
                                 @"QantasFrequentFlyerNumber" : _qantasFFNumberTextField.text,
                                 @"VirginVelocityNumber" : _virginVelocityTextField.text,
                                 @"EmiratesSkywardsNumber" : _emiratesSkywardsNumberTextField.text,
                                 @"OthersNumber" : _othersTextField.text
                                 };
    [self.progressHUD show:YES];
    [[API sharedInstance] updateBankingUsingDictionary:parameters delegate:self];
}

-(IBAction)completeButtonPressed:(id)sender {
    if(added == NO) {
        [self showInfoAlert:@"Enter details and submit using the Add button."];
        return;
    }
    mode = kModeEmail;
    
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *employee = [userdefaults objectForKey:kEmployee];
    NSNumber *employeeId = [employee objectForKey:kEmployeeId];
    NSDictionary *parameters = @{
                                 @"EmployeeId" : employeeId,
                                 };
    [self.progressHUD show:YES];
    [[API sharedInstance] sendEmailsUsingDictionary:parameters delegate:self];
}

-(IBAction)fillButtonPressed:(id)sender {
    [_bsbNumberTextField setText:@"066123"];
    [_accountNumberTextField setText:@"1234567890"];
    [_bankNameTextField setText:@"Common"];
    [_bankBranchTextField setText:@"Perth"];
    [_accountNameTextField setText:@"John Jones"];

    [_superFundNameTextField setText:@"HostPlus"];
    [_superMemberNumberTextField setText:@"0987654321"];
    
    [_qantasFFNumberTextField setText:@"12341234"];
    [_virginVelocityTextField setText:@"6789067890"];
    [_emiratesSkywardsNumberTextField setText:@"2468024680"];
    [_othersTextField setText:@"11223344"];
}

-(void)update {
    
}

-(void)successUpdate:(NSDictionary *)request response:(NSDictionary *)response {
    [self.progressHUD hide:YES];
    switch(mode) {
        case kModeBankingDetails: {
            [self successUpdateBankingDetails:request response:response];
            break;
        }
        case kModeEmail: {
            [self successUpdateEmail:request response:response];
            break;
        }
    }
}

-(void)successUpdateBankingDetails:(NSDictionary *)request response:(NSDictionary *)response {
    NSNumber *statusCode = [response objectForKey:@"statusCode"];
    if([statusCode intValue] == 200) {
        [self showInfoAlert:@"Banking details added."];
        added = YES;
    }
    else {
        [self showInfoAlert:@"Server is not available, try again later."];
        NSLog(@"Server response: %d", [statusCode intValue]);
    }
}

-(void)successUpdateEmail:(NSDictionary *)request response:(NSDictionary *)response {
    NSNumber *statusCode = [response objectForKey:@"statusCode"];
    if([statusCode intValue] == 200) {
        [self showInfoAlert:@"Complete."];
        [[self navigationController] popToRootViewControllerAnimated:YES];
    }
    else {
        [self showInfoAlert:@"Server is not available, try again later."];
        NSLog(@"Server response: %d", [statusCode intValue]);
    }
}

// not sure why banking details succeeds but returns failure
-(void)failUpdate:(NSDictionary *)request response:(NSDictionary *)response error:(NSError *)error {
    [self.progressHUD hide:YES];
    [self showInfoAlert:@"Server is not available, try again later."];
    switch(mode) {
        case kModeBankingDetails: {
            NSLog(@"failUpdate banking");
            break;
        }
        case kModeEmail: {
            NSLog(@"failUpdate email");
            break;
        }
    }
}

-(IBAction)photoButtonPressed :(id)sender

{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    
    // image picker needs a delegate,
    [imagePickerController setDelegate:self];
    
    // Place image picker on the screen
    [self presentModalViewController:imagePickerController animated:YES];
}



-(IBAction)chooseFromLibrary:(id)sender
{
    
    UIImagePickerController *imagePickerController= [[UIImagePickerController alloc] init];
    [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
    // image picker needs a delegate so we can respond to its messages
    [imagePickerController setDelegate:self];
    
    // Place image picker on the screen
    [self presentModalViewController:imagePickerController animated:YES];
    
}

//delegate methode will be called after picking photo either from camera or library
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissModalViewControllerAnimated:YES];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [myImageView setImage:image];    // "myImageView" name of any UIImageView.
}

@end
