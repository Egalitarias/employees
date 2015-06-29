//
//  NSDictionary+JSONString.h
//  Fitness
//
//  Created by Gary Davies on 11/01/2014.
//  Copyright (c) 2014 Gary Davies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JSONString)

-(NSString*)jsonStringWithPrettyPrint:(BOOL) prettyPrint;

@end
