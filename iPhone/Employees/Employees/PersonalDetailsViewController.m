//
//  ViewController.m
//  Employees
//
//  Created by Gary Davies on 7/04/2014.
//  Copyright (c) 2014 Gary Davies. All rights reserved.
//

#import "PersonalDetailsViewController.h"
#import "API.h"
#import "MBProgressHUD.h"
#import "PassportViewController.h"

@interface PersonalDetailsViewController ()

@end

@implementation PersonalDetailsViewController {
    UIImage *photoImage;
    BOOL photoAdded;
    int employeeId;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    photoImage = nil;
    photoAdded = NO;
    employeeId = 0;
}

-(void)setupScrollView {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    if((screenRect.size.height > 567.0) && (screenRect.size.height < 569.0)) {
        self.scrollView.scrollEnabled = YES;
        // [self.scrollView setContentSize: CGSizeMake(320, 500)];
        [self.scrollView setContentSize: CGSizeMake(320, 650)];
    }
    else if((screenRect.size.height > 479.0) && (screenRect.size.height < 481.0)) {
        self.scrollView.scrollEnabled = YES;
        //[self.scrollView setContentSize: CGSizeMake(320, 600)];
        [self.scrollView setContentSize: CGSizeMake(320, 750)];
    }
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self setupScrollView];
    
    if(photoImage != nil) {
        [self.progressHUD show: YES];
        [self postPhoto];
        photoImage = nil;
        [self.progressHUD show: NO];
        photoAdded = YES;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self setupScrollView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.scrollView.contentOffset = CGPointZero;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self setupScrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)versionButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"PersonalDetailsToVersionSegue" sender:self];
}

-(BOOL)validateUI {
    if((_familyNameTextField.text == nil) || ([_familyNameTextField.text length] == 0)) {
        [self showInfoAlert:@"Family Name is a required field"];
        return NO;
    }
    else if((_givenNameTextField.text == nil) || ([_givenNameTextField.text length] == 0)) {
        [self showInfoAlert:@"Given Name is a required field"];
        return NO;
    }
    else if((_dateOfBirthTextField.text == nil) || ([_dateOfBirthTextField.text length] == 0)) {
        [self showInfoAlert:@"Date Of Birth is a required field"];
        return NO;
    }
    else if((_titleTextField.text == nil) || ([_titleTextField.text length] == 0)) {
        [self showInfoAlert:@"Title is a required field"];
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
    else if((_emailTextField.text == nil) || ([_emailTextField.text length] == 0)) {
        [self showInfoAlert:@"Email is a required field"];
        return NO;
    }
    else if((_taxFileNumberTextField.text == nil) || ([_taxFileNumberTextField.text length] == 0)) {
        [self showInfoAlert:@"Tax File Number is a required field"];
        return NO;
    }
    else if((_companyTextField.text == nil) || ([_companyTextField.text length] == 0)) {
        [self showInfoAlert:@"Company is a required field"];
        return NO;
    }
    else if((_australianBusinessNumberTextField.text == nil) || ([_australianBusinessNumberTextField.text length] == 0)) {
        [self showInfoAlert:@"Australian Business Number is a required field"];
        return NO;
    }
    
    if(![self isStringInDateFormat:_dateOfBirthTextField.text]) {
        [self showInfoAlert:@"Date Of Birth must be in the format DD/MM/YYYY"];
        return NO;
    }
    
    return YES;
}

-(IBAction)addButtonPressed:(id)sender {
    if([self validateUI] == YES) {
        NSDictionary *parameters = @{
            @"FamilyName" : _familyNameTextField.text,
            @"GivenName" : _givenNameTextField.text,
            @"DateOfBirth" : _dateOfBirthTextField.text,
            @"Title" : _titleTextField.text,
            @"Address" : _addressTextField.text,
            @"Telephone" : _telephoneTextField.text,
            @"Mobile" : _mobileTextField.text,
            @"Email" : _emailTextField.text,
            @"TaxFileNumber" : _taxFileNumberTextField.text,
            @"CompanyName" : _companyTextField.text,
            @"AustralianBusinessNumber" : _australianBusinessNumberTextField.text,
        };
        [self.progressHUD show:YES];
        [[API sharedInstance] addEmployeeUsingDictionary:parameters delegate:self];
    }
}

-(IBAction)clearButtonPressed:(id)sender {
    [_familyNameTextField setText: @""];
    [_givenNameTextField setText: @""];
    [_dateOfBirthTextField setText: @""];
    [_titleTextField setText: @""];
    [_addressTextField setText: @""];
    [_telephoneTextField setText: @""];
    [_mobileTextField setText: @""];
    [_emailTextField setText: @""];
    [_taxFileNumberTextField setText: @""];
    [_companyTextField setText: @""];
    [_australianBusinessNumberTextField setText: @""];
}

-(IBAction)nextButtonPressed:(id)sender {
    if(employeeId == 0) {
        [self showInfoAlert:@"Enter details and submit using the Add button."];
        return;
    }

    if(photoAdded == NO) {
        [self showInfoAlert:@"Photo of yourself is required"];
        return;
    }
    
    [self performSegueWithIdentifier:@"PersonalDetailsToPassportSegue" sender:self];
}

-(void)update {
    
}

-(void)successUpdate:(NSDictionary *)request response:(NSDictionary *)response {
    [self.progressHUD hide:YES];
    NSNumber *statusCode = [response objectForKey:@"statusCode"];
    NSNumber *value = nil;
    if([statusCode intValue] == 200) {
        NSDictionary *employee = [response objectForKey:@"body"];
        if(employee != nil) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:employee forKey:kEmployee];
            value = [employee objectForKey:kEmployeeId];
            employeeId = value.intValue;
            NSLog(@"EmployeeId %d", employeeId);
            [self showInfoAlert:@"Personal details added."];
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

-(IBAction)fillButtonPressed :(id)sender {
    [_familyNameTextField setText:@"FamilyName"];
    [_givenNameTextField setText:@"GivenName"];
    [_dateOfBirthTextField setText:@"01/01/2014"];
    [_titleTextField setText:@"Mr"];
    [_addressTextField setText:@"1 First St Perth"];
    [_telephoneTextField setText:@"089345123"];
    [_mobileTextField setText:@"0466596234"];
    [_emailTextField setText:@"mail@gmail.com"];
    [_taxFileNumberTextField setText:@"123789456"];
    [_companyTextField setText:@"Acme Inc"];
    [_australianBusinessNumberTextField setText:@"12345667890"];
    photoAdded = YES;
}

-(IBAction)cameraButtonPressed :(id)sender
{
    if(employeeId == 0) {
        [self showInfoAlert:@"Submit personal details before submitting photos"];
        return;
    }

    NSString *familyName = _familyNameTextField.text;
    NSString *givenName = _givenNameTextField.text;
    
    if((familyName == nil) || ([familyName length] == 0) || (givenName == nil) || ([givenName length] == 0)) {
        [self showInfoAlert:@"Given and Family name is required"];
        return;
    }
    
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
    if(employeeId == 0) {
        [self showInfoAlert:@"Submit personal details before submitting photos"];
        return;
    }

    NSString *familyName = _familyNameTextField.text;
    NSString *givenName = _givenNameTextField.text;

    if((familyName == nil) || ([familyName length] == 0) || (givenName == nil) || ([givenName length] == 0)) {
        [self showInfoAlert:@"Given and Family name is required"];
        return;
    }

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
    
    // add image data
    //NSData *imageData = UIImageJPEGRepresentation(imageToPost, 1.0);
    
    NSString *imageName = [self makeImageName:_familyNameTextField.text givenName:_givenNameTextField.text type:@"PersonalDetails" employeeId:employeeId];
    
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"PersonalDetailsToPassportSegue"])
    {
        // Get reference to the destination view controller
        PassportViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        vc.familyName = _familyNameTextField.text;
        vc.givenName = _givenNameTextField.text;
        vc.employeeId = employeeId;
    }
}

@end
