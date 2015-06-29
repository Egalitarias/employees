//
//  FITAPIRequest.m
//  Fitness
//
//  Created by Gary Davies on 12/01/2014.
//  Copyright (c) 2014 Gary Davies. All rights reserved.
//

//#import "AppDelegate.h"
#import "APIRequest.h"
#import "NSDictionary+JSON.h"
#import "UpdateDelegate.h"

@implementation APIRequest {
    NSDictionary *request;
    id<UpdateDelegate> delegate;
    NSMutableData *responseData;
    //NSDictionary *response;
    NSDictionary *headers;
    long statusCode;
}

-(void)submitRequestUsingDictionary:(NSDictionary *)requestParameters delegate:(id<UpdateDelegate>)theDelegate {
    delegate = theDelegate;

    //AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    request = requestParameters;
    delegate = theDelegate;
    /*
     NSArray *objects = [NSArray arrayWithObjects:[[NSUserDefaults standardUserDefaults]valueForKey:@"StoreNickName"],
     [[UIDevice currentDevice] uniqueIdentifier], [dict objectForKey:@"user_question"],     nil];
     NSArray *keys = [NSArray arrayWithObjects:@"nick_name", @"UDID", @"user_question", nil];
     NSDictionary *questionDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
     NSDictionary *jsonDict = [NSDictionary dictionaryWithObject:questionDict forKey:@"question"];
     
     NSString *jsonRequest = [jsonDict JSONRepresentation];
     
     NSLog(@"jsonRequest is %@", jsonRequest);
     */
    
    NSString *apiPath = [requestParameters objectForKey: @"url"];
    NSString *method = [requestParameters objectForKey: @"method"];
    
    if(([method isEqualToString:@"GET"]) || ([method isEqualToString:@"DELETE"])) {
        NSDictionary *getParameters = [requestParameters objectForKey: @"parameters"];
        NSString *query = @"";
        NSString *value = nil;
        for(NSString *key in getParameters) {
            value = [getParameters objectForKey:key];
            if([query length] == 0) {
                query = [NSString stringWithFormat:@"%@=%@", key, value];
            }
            else {
                query = [NSString stringWithFormat:@"%@&%@=%@", query, key, value];
            }
        }
        NSString *getApiPath = [NSString stringWithFormat:@"%@?%@", apiPath, query];
        apiPath = getApiPath;
    }
    NSLog(@"%@", apiPath);
    
    NSDictionary *requestHeaders = [requestParameters objectForKey:@"headers"];
    NSDictionary *parameters = [requestParameters objectForKey:@"parameters"];
    NSString *jsonRequest = [parameters json:NO];
    
    //NSString *para = [[NSString alloc] init];
    //jsonRequest = [jsonRequest stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:apiPath];
    
    NSLog(@"web service URL: %@", url);
    //[appDelegate logMessage:apiPath];

    //NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
    //                                                       cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString * value = nil;
    for(NSString *key in requestHeaders) {
        value = [requestHeaders objectForKey:key];
        [urlRequest setValue:value forHTTPHeaderField:key];
        //[appDelegate logMessage:@"Header: [%@] [%@]" first:key second:value];
    };
    
    //[appDelegate logMessage:@"jsonRequest: [%@]" first:jsonRequest];
    
    [urlRequest setHTTPMethod:method];
    //[appDelegate logMessage:@"Method: [%@]" first:method];

    //[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    //[request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //[request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    if(([method isEqualToString:@"GET"] == false) && ([method isEqualToString:@"DELETE"] == false)) {
        NSData *requestData = [jsonRequest dataUsingEncoding:NSUTF8StringEncoding];
        [urlRequest setHTTPBody: requestData];
    }
    
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:urlRequest delegate:self];
    if (connection) {
        responseData = [NSMutableData data];
        NSLog(@"Connection OK");
    }
    else {
        NSLog(@"Connection failed");
    }
}

#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    headers = [httpResponse allHeaderFields];
    statusCode = [httpResponse statusCode];
    
    //AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    //[appDelegate logMessage:@"Response StatusCode: [%ld]" longValue:statusCode];
    NSLog(@"statusCode: %ld", statusCode);

    NSString * value = nil;
    for(NSString *key in headers) {
        value = [headers objectForKey:key];
        //[appDelegate logMessage:@"Response Header: [%@] [%@]" first:key second:value];
    };

    NSLog(@"didReceiveResponse");
    responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    NSLog(@"didReceiveData");
    [responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    NSLog(@"connectionDidFinishLoading");
    
    NSError *error;
    NSDictionary *body = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    if(body == nil) {
        body = @{};
    }
    
    //AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //[appDelegate logMessage:@"Response body: [%@]" dictionary:body];

    NSDictionary *response = @{ @"statusCode" : [NSNumber numberWithInteger:statusCode], @"headers" : headers, @"body" : body};
    
    NSLog(@"Response length %lu", (unsigned long)[responseData length]);
    [delegate successUpdate:request response:response];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
    NSLog(@"didFailWithError");
    if(headers == nil) {
        headers = @{};
    }
    NSDictionary *response = @{ @"statusCode" : [NSNumber numberWithInteger:9000], @"headers" : headers, @"body" : @{}};
    [delegate failUpdate:request response:response error:error];
}

-(NSDictionary *)submitSynchronousRequestUsingDictionary:(NSDictionary *)requestParameters {
    NSURLResponse *urlResponse = nil;
    NSError *error = nil;
    NSMutableURLRequest *urlRequest = [self buildRequest:requestParameters];
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&urlResponse error:&error];

    // body must not be nil
    NSDictionary *body = @{};
    if((data != nil) && ([data length] > 0)) {
        NSDictionary *tmp = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if(tmp != nil) {
            body = tmp;
        }
    }
    
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)urlResponse;
    headers = [httpResponse allHeaderFields];
    if(headers == nil) {
        headers = @{};
    }
    statusCode = [httpResponse statusCode];

    NSDictionary *response = @{ @"statusCode" : [NSNumber numberWithInteger:statusCode], @"headers" : headers, @"body" : body};
    return response;

}


#pragma mark - Private methods
-(NSMutableURLRequest *)buildRequest:(NSDictionary *)requestParameters {
    request = requestParameters;
    /*
     NSArray *objects = [NSArray arrayWithObjects:[[NSUserDefaults standardUserDefaults]valueForKey:@"StoreNickName"],
     [[UIDevice currentDevice] uniqueIdentifier], [dict objectForKey:@"user_question"],     nil];
     NSArray *keys = [NSArray arrayWithObjects:@"nick_name", @"UDID", @"user_question", nil];
     NSDictionary *questionDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
     NSDictionary *jsonDict = [NSDictionary dictionaryWithObject:questionDict forKey:@"question"];
     
     NSString *jsonRequest = [jsonDict JSONRepresentation];
     
     NSLog(@"jsonRequest is %@", jsonRequest);
     */
    
    NSString *apiPath = [requestParameters objectForKey: @"url"];
    NSString *method = [requestParameters objectForKey: @"method"];
    NSDictionary *requestHeaders = [requestParameters objectForKey:@"headers"];
    NSDictionary *parameters = [requestParameters objectForKey:@"parameters"];

    if([method isEqualToString:@"GET"]) {
        NSString * getParameters = @"";
        NSString *value = nil;
        for(NSString *key in parameters) {
            value = [parameters objectForKey:key];
            if([getParameters length] == 0) {
                getParameters = [NSString stringWithFormat:@"%@=%@", key, value];
            }
            else {
                getParameters = [NSString stringWithFormat:@"%@&%@=%@", getParameters, key, value];
            }
        }
        if([getParameters length] > 0) {
            NSString *getApiPath = [NSString stringWithFormat:@"%@?%@", apiPath, getParameters];
            apiPath = getApiPath;
        }
    }
    
    NSString *jsonRequest = [parameters json:NO];
    
    //NSString *para = [[NSString alloc] init];
    //jsonRequest = [jsonRequest stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:apiPath];
    
    NSLog(@"web service URL: %@", url);
    
    //NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
    //                                                       cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString * value = nil;
    for(NSString *key in requestHeaders) {
        value = [requestHeaders objectForKey:key];
        [urlRequest setValue:value forHTTPHeaderField:key];
    };
    
    NSData *requestData = [jsonRequest dataUsingEncoding:NSUTF8StringEncoding];
    
    [urlRequest setHTTPMethod:method];
    
    //[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    //[request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //[request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    if([method isEqualToString:@"GET"] ==  false) {
        [urlRequest setHTTPBody: requestData];
    }
    
    return urlRequest;
}
@end
