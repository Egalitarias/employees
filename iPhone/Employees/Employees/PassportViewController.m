//
//  SecondViewController.m
//  Employees
//
//  Created by Gary Davies on 18/04/2014.
//  Copyright (c) 2014 Gary Davies. All rights reserved.
//

#import "PassportViewController.h"
#import "API.h"
#import "MBProgressHUD.h"

@interface PassportViewController ()

@end

@implementation PassportViewController {
    UIImage *photoImage;
    int photoCount;
    BOOL photoAdded;
    BOOL passportAdded;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    photoAdded = NO;
    photoCount = 0;
    passportAdded = NO;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if(photoImage != nil) {
        [self.progressHUD show: YES];
        [self postPhoto];
        photoImage = nil;
        [self.progressHUD show: NO];
        photoAdded = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)validateUI {
    if((_passportNumberTextField.text == nil) || ([_passportNumberTextField.text length] == 0)) {
        [self showInfoAlert:@"Passport Number is a required field"];
        return NO;
    }
    else if((_nationailityTextField.text == nil) || ([_nationailityTextField.text length] == 0)) {
        [self showInfoAlert:@"Nationality is a required field"];
        return NO;
    }
    else if((_visaTypeTextField.text == nil) || ([_visaTypeTextField.text length] == 0)) {
        [self showInfoAlert:@"Visa Type is a required field"];
        return NO;
    }
    else if((_visaNumberTextField.text == nil) || ([_visaNumberTextField.text length] == 0)) {
        [self showInfoAlert:@"Visa Number is a required field"];
        return NO;
    }
    else if((_visaIssueDateTextField.text == nil) || ([_visaIssueDateTextField.text length] == 0)) {
        [self showInfoAlert:@"Visa Issue Date is a required field"];
        return NO;
    }
    else if((_visaExpiryDateTextField.text == nil) || ([_visaExpiryDateTextField.text length] == 0)) {
        [self showInfoAlert:@"Visa Expiry Date is a required field"];
        return NO;
    }
    
    if(![self isStringInDateFormat:_visaIssueDateTextField.text]) {
        [self showInfoAlert:@"Visa Issue Date must be in the format DD/MM/YYYY"];
        return NO;
    }
    
    if(![self isStringInDateFormat:_visaExpiryDateTextField.text]) {
        [self showInfoAlert:@"Visa Expiry Date must be in the format DD/MM/YYYY"];
        return NO;
    }

    return YES;
}

-(IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)cameraButtonPressed :(id)sender
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

-(IBAction)photoButtonPressed:(id)sender
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
    photoImage = [info objectForKey:UIImagePickerControllerOriginalImage];
}

-(void)postPhoto {
    
    CGSize newSize = CGSizeMake(photoImage.size.width / 8.0, photoImage.size.height / 8.0);
    UIGraphicsBeginImageContext(newSize);
    [photoImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* small = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImagePNGRepresentation(small);
    NSLog(@"Size: %ld", (unsigned long)[imageData length]);
    
    API *api = [API sharedInstance];
    NSString *urlString = [api getPostPhotoURL];
    NSLog(@"url: %@", urlString);
    
    
    NSURL *yourURL = [[NSURL alloc] initWithString:urlString];
    /*
     NSMutableURLRequest *yourRequest = [NSMutableURLRequest requestWithURL:yourURL
     cachePolicy:NSURLRequestUseProtocolCachePolicy
     timeoutInterval:60.0];
     */
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:yourURL];
    
    //Set request to post
    [request setHTTPMethod:@"POST"];
    
    //Set content type
    [request setValue:@"image/png" forHTTPHeaderField:@"Content-Type"];
    //[yourRequest setValue:@"Employee2Photo.png" forKey:@"name"];
    
    // Set authorization header if required
    //...
    
    // set data
    //[yourRequest setHTTPBody:imageData];
    // set Content-Type in HTTP header
    NSString *boundary = [NSString stringWithString:@"0xKhTmLbOuNdArY"];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    /*
     // add params (all params are strings)
     for (NSString *param in _params) {
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"%@\r\n", [_params objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
     }
     */
    
    NSString *imageName = [self makeImageName:_familyName givenName:_givenName type:@"Passport" employeeId:_employeeId];

    // add image data
    //NSData *imageData = UIImageJPEGRepresentation(imageToPost, 1.0);
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", imageName, imageName] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithString:@"Content-Type: image/png\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // create connection and set delegate if needed
    NSURLConnection *yourConnection = [[NSURLConnection alloc] initWithRequest:request
                                                                      delegate:self
                                                              startImmediately:YES];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    NSLog(@"willCacheResponse");
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    [self.progressHUD hide:YES];
    [self showInfoAlert:@"Photo successfully sent."];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
    [self.progressHUD hide:YES];
    [self showInfoAlert:@"Photo could not be sent."];
}

-(IBAction)addButtonPressed:(id)sender {    
    if([self validateUI] == YES) {
        NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *employee = [userdefaults objectForKey:kEmployee];
        NSNumber *employeeId = [employee objectForKey:kEmployeeId];
        NSDictionary *parameters = @{
                                 @"EmployeeId" : employeeId,
                                 @"PassportNumber" : _passportNumberTextField.text,
                                 @"Nationality" : _nationailityTextField.text,
                                 @"VisaType" : _visaTypeTextField.text,
                                 @"VisaNumber" : _visaNumberTextField.text,
                                 @"VisasIssueDate" : _visaIssueDateTextField.text,
                                 @"VisasExpiryDate" : _visaExpiryDateTextField.text,
                                 };
        [self.progressHUD show:YES];
        [[API sharedInstance] addPassportUsingDictionary:parameters delegate:self];
    }
}

-(IBAction)nextButtonPressed:(id)sender {
    if(passportAdded == NO) {
        [self showInfoAlert:@"Enter passport details and use Add button to submit."];
        return;
    }

    if(photoAdded == NO) {
        [self showInfoAlert:@"Photo of passport is required."];
        return;
    }


    [self performSegueWithIdentifier:@"PassportToContactSegue" sender:self];
}

-(IBAction)fillButtonPressed :(id)sender {
    [_passportNumberTextField setText:@"Passport Number"];
    [_nationailityTextField setText:@"Nationality"];
    [_visaTypeTextField setText:@"Working"];
    [_visaNumberTextField setText:@"88888888"];
    [_visaIssueDateTextField setText:@"02/03/2014"];
    [_visaExpiryDateTextField setText:@"03/04/2014"];
    photoAdded = YES;
}

-(void)update {
    
}

-(void)successUpdate:(NSDictionary *)request response:(NSDictionary *)response {
    [self.progressHUD hide:YES];
    NSNumber *statusCode = [response objectForKey:@"statusCode"];
    NSNumber *value = nil;
    if([statusCode intValue] == 200) {
        NSDictionary *passport = [response objectForKey:@"body"];
        if(passport != nil) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            value = [passport objectForKey:kPassportId];
            [userDefaults setObject:value forKey:kPassportId];
            [userDefaults synchronize];
            NSLog(@"PassportId %@", value);
            //[self performSegueWithIdentifier:@"FirstToSecondSegue" sender:self];
            [self showInfoAlert:@"Passport Added."];
            [_passportNumberTextField setText:@""];
            [_nationailityTextField setText:@""];
            [_visaTypeTextField setText:@""];
            [_visaNumberTextField setText:@""];
            [_visaIssueDateTextField setText:@""];
            [_visaExpiryDateTextField setText:@""];
            passportAdded =YES;
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
