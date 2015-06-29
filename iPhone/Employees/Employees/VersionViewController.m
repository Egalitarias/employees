//
//  VersionViewController.m
//  Employees
//
//  Created by Gary Davies on 7/04/2014.
//  Copyright (c) 2014 Gary Davies. All rights reserved.
//

#import "VersionViewController.h"
#import "API.h"
#import "MBProgressHUD.h"

static const int kModeIdle = 0;
static const int kModeGetVersion = 1;
static const int kModeSetVersion = 2;

@interface VersionViewController () {
    int mode;
    NSDictionary *getVersionRequest;
}

@end

@implementation VersionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        mode = kModeIdle;
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

-(IBAction)setButtonPressed:(id)sender {
    [self.progressHUD show:YES];
    mode = kModeSetVersion;
    [[API sharedInstance] setVersionUsingDictionary:@{@"Name" : @"ios", @"Value" : _version.text} delegate:self];
}

-(IBAction)getButtonPressed:(id)sender {
    [self.progressHUD show:YES];
    mode = kModeGetVersion;
    getVersionRequest = [[NSDictionary alloc] init];
    [[API sharedInstance] getVersionUsingDictionary:getVersionRequest delegate:self];
}

-(IBAction)backButtonPressed:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)update {
    NSLog(@"VersionViewController update");
}

-(void)successUpdate:(NSDictionary *)request response:(NSDictionary *)response {
    NSLog(@"VersionViewController successUpdate %@", response);
    [self.progressHUD hide:YES];
    switch(mode) {
        case kModeGetVersion :{
            [self successGetVersion:response];
            break;
        }
        case kModeSetVersion: {
            [self successSetVersion:response];
            break;
        }
    }
    mode = kModeIdle;
}

-(void)successGetVersion:(NSDictionary *)response {
    NSNumber *statusCode = [response objectForKey:@"statusCode"];
    NSString *value = nil;
    if([statusCode intValue] == 200) {
        NSArray *body = [response objectForKey:@"body"];
        if([body count] > 0) {
            NSDictionary *version = [body objectAtIndex:0];
            if(version != nil) {
                value = [version objectForKey:@"Value"];
            }
        }
    }
    
    if((value != nil) && ([value length] > 0)) {
        [_version setText:value];
    }
}

-(void)successSetVersion:(NSDictionary *)response {
    NSNumber *statusCode = [response objectForKey:@"statusCode"];
    if([statusCode intValue] == 200) {
        [_version setText:@"OK"];
    }
    else {
        [_version setText:@"FAIL"];
    }
}

-(void)failUpdate:(NSDictionary *)request response:(NSDictionary *)response error:(NSError *)error {
    NSLog(@"VersionViewController failUpdate");
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

@end
