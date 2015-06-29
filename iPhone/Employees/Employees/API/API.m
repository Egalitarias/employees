//
//  FITFitnessAPI.m
//  Fitness
//
//  Created by Gary Davies on 5/01/2014.
//  Copyright (c) 2014 Gary Davies. All rights reserved.
//

#import "API.h"
#import "APIRequest.h"
#import "AuthenticationDataModel.h"

//static NSString *kAPIEndPoint = @"http://192.168.0.168:8080/api";
static NSString *kAPIEndPoint = @"http://54.206.53.203:8080/api";

@implementation API {
    AuthenticationDataModel *authenticationDataModel;
}

#pragma mark - Singleton
+ (API *)sharedInstance {
	static API *_sharedClient = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedClient = [[self alloc] init];
    });
    
    return _sharedClient;
}


#pragma mark - Initialization
- (instancetype)init {
	self = [super init];
	if (self) {
        authenticationDataModel = [[AuthenticationDataModel alloc] init];
	}
	return self;
}


#pragma mark - Public methods
- (void)getVersionUsingDictionary:(NSDictionary *)parameters delegate:(id<UpdateDelegate>)delegate {
    NSString *url = [self makeURL:@"version"];
    NSDictionary *requestParameters = @{@"url" : url, @"method" : @"GET" , @"headers" : @{@"Content-Type" : @"application/json; charset=utf-8"}, @"parameters" : parameters};
    
    APIRequest *request = [[APIRequest alloc] init];
    [request submitRequestUsingDictionary:requestParameters delegate:delegate];
}

- (void)setVersionUsingDictionary:(NSDictionary *)parameters delegate:(id<UpdateDelegate>)delegate {
    NSString *url = [self makeURL:@"version"];
    NSDictionary *requestParameters = @{@"url" : url, @"method" : @"POST" , @"headers" : @{@"Content-Type" : @"application/json; charset=utf-8"}, @"parameters" : parameters};
    
    APIRequest *request = [[APIRequest alloc] init];
    [request submitRequestUsingDictionary:requestParameters delegate:delegate];
}

- (void)addEmployeeUsingDictionary:(NSDictionary *)parameters delegate:(id<UpdateDelegate>)delegate {
    NSString *url = [self makeURL:@"employee"];
    NSDictionary *requestParameters = @{@"url" : url, @"method" : @"POST" , @"headers" : @{@"Content-Type" : @"application/json"}, @"parameters" : parameters};
    
    APIRequest *request = [[APIRequest alloc] init];
    [request submitRequestUsingDictionary:requestParameters delegate:delegate];
}

- (void)updateEmployeeUsingDictionary:(NSDictionary *)parameters delegate:(id<UpdateDelegate>)delegate {
    NSString *url = [self makeURL:@"employee"];
    NSDictionary *requestParameters = @{@"url" : url, @"method" : @"PUT" , @"headers" : @{@"Content-Type" : @"application/json; charset=utf-8"}, @"parameters" : parameters};
    
    APIRequest *request = [[APIRequest alloc] init];
    [request submitRequestUsingDictionary:requestParameters delegate:delegate];
}

- (void)addPassportUsingDictionary:(NSDictionary *)parameters delegate:(id<UpdateDelegate>)delegate {
    NSString *url = [self makeURL:@"passport"];
    NSDictionary *requestParameters = @{@"url" : url, @"method" : @"POST" , @"headers" : @{@"Content-Type" : @"application/json"}, @"parameters" : parameters};
    
    APIRequest *request = [[APIRequest alloc] init];
    [request submitRequestUsingDictionary:requestParameters delegate:delegate];
}

- (void)addContactUsingDictionary:(NSDictionary *)parameters delegate:(id<UpdateDelegate>)delegate {
    NSString *url = [self makeURL:@"contact"];
    NSDictionary *requestParameters = @{@"url" : url, @"method" : @"POST" , @"headers" : @{@"Content-Type" : @"application/json"}, @"parameters" : parameters};
    
    APIRequest *request = [[APIRequest alloc] init];
    [request submitRequestUsingDictionary:requestParameters delegate:delegate];
}

- (void)updateBankingUsingDictionary:(NSDictionary *)parameters delegate:(id<UpdateDelegate>)delegate {
    NSString *url = [self makeURL:@"banking"];
    NSDictionary *requestParameters = @{@"url" : url, @"method" : @"PUT" , @"headers" : @{@"Content-Type" : @"application/json"}, @"parameters" : parameters};
    
    APIRequest *request = [[APIRequest alloc] init];
    [request submitRequestUsingDictionary:requestParameters delegate:delegate];
}

- (void)sendEmailsUsingDictionary:(NSDictionary *)parameters delegate:(id<UpdateDelegate>)delegate {
    NSString *url = [self makeURL:@"email"];
    NSDictionary *requestParameters = @{@"url" : url, @"method" : @"GET" , @"headers" : @{@"Content-Type" : @"application/json; charset=utf-8"}, @"parameters" : parameters};
    
    APIRequest *request = [[APIRequest alloc] init];
    [request submitRequestUsingDictionary:requestParameters delegate:delegate];
}

- (NSString *)getPostPhotoURL {
    NSString *url = [self makeURL:@"upload"];
    return url;
}




- (void)registerUserUsingDictionary:(NSDictionary *)parameters delegate:(id<UpdateDelegate>)delegate {
    NSString *url = [self makeURL:@"User/Register"];
    NSDictionary *requestParameters = @{@"url" : url, @"method" : @"PUT" , @"headers" : @{@"Content-Type" : @"application/json; charset=utf-8"}, @"parameters" : parameters};
    
    APIRequest *request = [[APIRequest alloc] init];
    [request submitRequestUsingDictionary:requestParameters delegate:delegate];
}

- (void)loginUsingDictionary:(NSDictionary *)parameters delegate:(id<UpdateDelegate>)delegate {
    NSString *url = [self makeURL:@"User/Login"];
    NSDictionary *requestParameters = @{@"url" : url, @"method" : @"POST" , @"headers" : @{@"Content-Type" : @"application/json; charset=utf-8"}, @"parameters" : parameters};
    
    APIRequest *request = [[APIRequest alloc] init];
    [request submitRequestUsingDictionary:requestParameters delegate:delegate];
}

-(void)loadAuthentication {
    [authenticationDataModel readFromDocuments];
}

- (void)getUserUsingDictionary:(NSDictionary *)parameters delegate:(id<UpdateDelegate>)delegate {
    NSString *url = [self makeURL:@"User/Get"];
    NSString *basicAuthentication = [self makeAuthorization];
    NSDictionary *requestParameters = @{@"url" : url, @"method" : @"GET" , @"headers" : @{@"Content-Type" : @"application/json; charset=utf-8", @"Authorization" : basicAuthentication}, @"parameters" : parameters};
    
    APIRequest *request = [[APIRequest alloc] init];
    [request submitRequestUsingDictionary:requestParameters delegate:delegate];    
}

- (void)deleteUserUsingDictionary:(NSDictionary *)parameters delegate:(id<UpdateDelegate>)delegate {
    NSString *url = [self makeURL:@"User/Delete"];
    NSString *basicAuthentication = [self makeAuthorization];
    NSDictionary *requestParameters = @{@"url" : url, @"method" : @"DELETE" , @"headers" : @{@"Content-Type" : @"application/json; charset=utf-8", @"Authorization" : basicAuthentication}, @"parameters" : parameters};
    
    APIRequest *request = [[APIRequest alloc] init];
    [request submitRequestUsingDictionary:requestParameters delegate:delegate];
}

- (void)getCategoriesUsingDictionary:(NSDictionary *)parameters delegate:(id<UpdateDelegate>)delegate {
    NSString *url = [self makeURL:@"Category/Get"];
    NSString *basicAuthentication = [self makeAuthorization];
    NSDictionary *requestParameters = @{@"url" : url, @"method" : @"GET" , @"headers" : @{@"Content-Type" : @"application/json; charset=utf-8", @"Authorization" : basicAuthentication}, @"parameters" : parameters};
    
    APIRequest *request = [[APIRequest alloc] init];
    [request submitRequestUsingDictionary:requestParameters delegate:delegate];
}

- (void)getExercisesUsingDictionary:(NSDictionary *)parameters delegate:(id<UpdateDelegate>)delegate {
    NSString *url = [self makeURL:@"Exercise/Get"];
    NSString *basicAuthentication = [self makeAuthorization];
    NSDictionary *requestParameters = @{@"url" : url, @"method" : @"GET" , @"headers" : @{@"Content-Type" : @"application/json; charset=utf-8", @"Authorization" : basicAuthentication}, @"parameters" : parameters};
    
    APIRequest *request = [[APIRequest alloc] init];
    [request submitRequestUsingDictionary:requestParameters delegate:delegate];
}

- (void)createProgramUsingDictionary:(NSDictionary *)parameters delegate:(id<UpdateDelegate>)delegate {
    NSString *url = [self makeURL:@"Program/Create"];
    NSString *basicAuthentication = [self makeAuthorization];
    NSDictionary *requestParameters = @{@"url" : url, @"method" : @"PUT" , @"headers" : @{@"Content-Type" : @"application/json; charset=utf-8", @"Authorization" : basicAuthentication}, @"parameters" : parameters};
    
    APIRequest *request = [[APIRequest alloc] init];
    [request submitRequestUsingDictionary:requestParameters delegate:delegate];
}

- (void)getProgramUsingDictionary:(NSDictionary *)parameters delegate:(id<UpdateDelegate>)delegate {
    NSString *url = [self makeURL:@"Program/Get"];
    NSString *basicAuthentication = [self makeAuthorization];
    NSDictionary *requestParameters = @{@"url" : url, @"method" : @"GET" , @"headers" : @{@"Content-Type" : @"application/json; charset=utf-8", @"Authorization" : basicAuthentication}, @"parameters" : parameters};
    
    APIRequest *request = [[APIRequest alloc] init];
    [request submitRequestUsingDictionary:requestParameters delegate:delegate];
}

- (void)deleteProgramUsingDictionary:(NSDictionary *)parameters delegate:(id<UpdateDelegate>)delegate {
    NSString *url = [self makeURL:@"Program/Delete"];
    NSString *basicAuthentication = [self makeAuthorization];
    NSDictionary *requestParameters = @{@"url" : url, @"method" : @"DELETE" , @"headers" : @{@"Content-Type" : @"application/json; charset=utf-8", @"Authorization" : basicAuthentication}, @"parameters" : parameters};
    
    APIRequest *request = [[APIRequest alloc] init];
    [request submitRequestUsingDictionary:requestParameters delegate:delegate];
}

#pragma mark - Private methods
-(NSString *)makeURL:(NSString *) rel {
    NSString *url;
    
    if(_otherEndPoint == nil) {
        url = [NSString stringWithFormat:@"%@/%@", kAPIEndPoint, rel];
    }
    else {
        url = [NSString stringWithFormat:@"%@/%@", _otherEndPoint, rel];
    }
    
    return url;
}

-(NSString*)makeAuthorization {
    NSString *auth = [NSString stringWithFormat:@"Basic %@:%@", authenticationDataModel.email, authenticationDataModel.password];
    return auth;
}

@end
