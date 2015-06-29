//
//  FITFitnessAPI.h
//  Fitness
//
//  Created by Gary Davies on 5/01/2014.
//  Copyright (c) 2014 Gary Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UpdateDelegate.h"

@interface API : NSObject

@property (nonatomic, strong) NSString *otherEndPoint;

+ (API *)sharedInstance;

-(void)loadAuthentication;

- (void)getVersionUsingDictionary:(NSDictionary *)parameters delegate:(id<UpdateDelegate>)delegate;
- (void)setVersionUsingDictionary:(NSDictionary *)parameters delegate:(id<UpdateDelegate>)delegate;
- (void)addEmployeeUsingDictionary:(NSDictionary *)parameters delegate:(id<UpdateDelegate>)delegate;
- (void)updateEmployeeUsingDictionary:(NSDictionary *)parameters delegate:(id<UpdateDelegate>)delegate;
- (void)addPassportUsingDictionary:(NSDictionary *)parameters delegate:(id<UpdateDelegate>)delegate;
- (void)addContactUsingDictionary:(NSDictionary *)parameters delegate:(id<UpdateDelegate>)delegate;
- (void)updateBankingUsingDictionary:(NSDictionary *)parameters delegate:(id<UpdateDelegate>)delegate;
- (void)sendEmailsUsingDictionary:(NSDictionary *)parameters delegate:(id<UpdateDelegate>)delegate;

- (NSString *)getPostPhotoURL;

- (void)registerUserUsingDictionary:(NSDictionary *)parameters delegate:(id<UpdateDelegate>)delegate;
- (void)loginUsingDictionary:(NSDictionary *)parameters delegate:(id<UpdateDelegate>)delegate;
- (void)getUserUsingDictionary:(NSDictionary *)parameters delegate:(id<UpdateDelegate>)delegate;
- (void)deleteUserUsingDictionary:(NSDictionary *)parameters delegate:(id<UpdateDelegate>)delegate;
- (void)getCategoriesUsingDictionary:(NSDictionary *)parameters delegate:(id<UpdateDelegate>)delegate;
- (void)getExercisesUsingDictionary:(NSDictionary *)parameters delegate:(id<UpdateDelegate>)delegate;
- (void)createProgramUsingDictionary:(NSDictionary *)parameters delegate:(id<UpdateDelegate>)delegate;
- (void)getProgramUsingDictionary:(NSDictionary *)parameters delegate:(id<UpdateDelegate>)delegate;
- (void)deleteProgramUsingDictionary:(NSDictionary *)parameters delegate:(id<UpdateDelegate>)delegate;

@end
