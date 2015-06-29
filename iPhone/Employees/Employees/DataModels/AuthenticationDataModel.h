//
//  Authentication.h
//  eMyGym
//
//  Created by Gary Davies on 28/02/2014.
//  Copyright (c) 2014 Gary Davies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface AuthenticationDataModel : JSONModel <NSCoding, NSCopying, NSMutableCopying>

@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *password;

// Not part of the model, name of file in the documents folder
@property (nonatomic, strong) NSString *fileName;

+(NSData *)archiveArray:(NSArray *)array;
+(NSArray *)unarchiveDataToArray:(NSData *)data;

-(void)saveToDocuments;
-(BOOL)readFromDocuments;

-(NSArray *)arrayFromDocuments;
-(void)saveJSONArrayToDocuments:(NSString *)jsonArray;
-(void)saveArrayToDocuments:(NSArray *)array;
-(void)removeFromDocuments;

-(id)init;
-(id)initWithDictionary:(NSDictionary *)dictionary;
-(id)initWithJSON:(NSString*) json;
-(id)initWithCoder:(NSCoder *)aDecoder;

+(NSArray *)convertArrayOfDictionaryToArrayOfInstances:(NSArray *)arrayOfDictionary;
+(void)saveArrayToDocuments:(NSArray *)array usingFileName:(NSString *)fileName;
+(NSArray *)arrayFromDocuments:(NSString *)fileName;

@end
