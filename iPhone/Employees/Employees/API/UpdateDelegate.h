//
//  FITUpdateDelegate.h
//  Fitness
//
//  Created by Gary Davies on 12/01/2014.
//  Copyright (c) 2014 Gary Davies. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UpdateDelegate <NSObject>

@optional
-(void)update;
-(void)successUpdate:(NSDictionary *)request response:(NSDictionary *)response;
-(void)failUpdate:(NSDictionary *)request response:(NSDictionary *)response error:(NSError *)error;

@end
