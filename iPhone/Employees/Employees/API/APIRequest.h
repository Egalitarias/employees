//
//  FITAPIRequest.h
//  Fitness
//
//  Created by Gary Davies on 12/01/2014.
//  Copyright (c) 2014 Gary Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UpdateDelegate.h"

@interface APIRequest : NSObject

-(void)submitRequestUsingDictionary:(NSDictionary *)requestParameters delegate:(id<UpdateDelegate>)theDelegate;
-(NSDictionary *)submitSynchronousRequestUsingDictionary:(NSDictionary *)requestParameters;

@end
