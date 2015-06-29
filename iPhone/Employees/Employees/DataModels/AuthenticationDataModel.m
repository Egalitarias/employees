//
//  Authentication.m
//  eMyGym
//
//  Created by Gary Davies on 28/02/2014.
//  Copyright (c) 2014 Gary Davies. All rights reserved.
//

#import "AuthenticationDataModel.h"

static NSString *kemail = @"email";
static NSString *kpassword = @"password";

static NSString *kFileName = @"Authentications.dat";

@implementation AuthenticationDataModel

-(id)init {
    self = [super init];
    if(self != nil) {
        _email = @"";
        _password = @"";
        _fileName = kFileName;
    }
    return self;
}

-(id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if(self != nil) {
        _fileName = kFileName;
    }
    return self;
}

-(id)initWithJSON:(NSString*) json {
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:kNilOptions
                                                                   error:&error];
    return [[AuthenticationDataModel alloc] initWithDictionary:jsonResponse];
}

#pragma mark - NSCoder methods
- (BOOL)allowsKeyedCoding {
    return YES;
}

#pragma mark - NSCoding protocol methods
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _email = [aDecoder decodeObjectForKey:kemail];
        _password = [aDecoder decodeObjectForKey:kpassword];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_email forKey:kemail];
    [aCoder encodeObject:_password forKey:kpassword];
}


#pragma mark - NSObject protocol methods
- (BOOL)isEqual:(id)object {
    if (object && [object isKindOfClass:[AuthenticationDataModel class]]) {
        AuthenticationDataModel *other = (AuthenticationDataModel *)object;
        return (
        [other.email isEqualToString:self.email]
        && [other.password isEqualToString:self.password]
        );
    }

    return NO;
}

- (NSUInteger)hash {
    NSUInteger emailHash = NSUINTROTATE([self.email hash], HASHAMOUNT);
    NSUInteger passwordHash = NSUINTROTATE([self.password hash], HASHAMOUNT);
	
    return (
        emailHash
        ^ passwordHash
    );
}


#pragma mark - NSCopying protocol methods
- (id)copyWithZone:(NSZone *)zone {
    AuthenticationDataModel *copy = [[AuthenticationDataModel allocWithZone:zone] init];

    [copy setEmail:_email];
    [copy setPassword:_password];

    return copy;
}


#pragma mark - NSMutableCopying protocol methods
- (id)mutableCopyWithZone:(NSZone *)zone {
    AuthenticationDataModel *copy = [[AuthenticationDataModel allocWithZone:zone] init];

    [copy setEmail:_email];
    [copy setPassword:_password];

    return copy;
}

#pragma mark - Class method
+ (AuthenticationDataModel *)jsonModelFromArchivedData:(NSData *)data {
	return [super jsonModelFromArchivedData:data];
}

-(NSArray *)arrayFromDocuments {
    NSString *documentsFolder = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *path = [documentsFolder stringByAppendingPathComponent:_fileName];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSArray *array = [AuthenticationDataModel unarchiveDataToArray:data];
    
    return array;
}

- (void)removeFromDocuments {
    NSString *documentsFolder = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *path = [documentsFolder stringByAppendingPathComponent:_fileName];
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}

-(void)saveJSONArrayToDocuments:(NSString *)jsonArray {
    NSError *error;
    NSData *data = [jsonArray dataUsingEncoding:NSUTF8StringEncoding];
    NSArray* array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    
    NSMutableArray *itemArray = [[NSMutableArray alloc] init];
    AuthenticationDataModel *instance;
    for(NSDictionary *dictionary in array) {
        instance = [[AuthenticationDataModel alloc] initWithDictionary:dictionary];
        [itemArray addObject:instance];
    }

    [self saveArrayToDocuments:itemArray];
}

-(void)saveToDocuments {
    NSArray *array = @[self];
    [self saveArrayToDocuments:array];
}

-(BOOL)readFromDocuments {
    NSArray *array = [self arrayFromDocuments];
    if([array count] > 0) {
        AuthenticationDataModel *instance = [array objectAtIndex:0];
        self.email = instance.email;
        self.password = instance.password;
    }
    return [array count] > 0;
}

- (void)saveArrayToDocuments:(NSArray *)array {
    NSData *data = [AuthenticationDataModel archiveArray:array];
    NSString *documentsFolder = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *path = [documentsFolder stringByAppendingPathComponent:_fileName];
    [data writeToFile:path atomically:YES];
}

+(NSData *)archiveArray:(NSArray *)array {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:array];
    return data;
}

+(NSArray *)unarchiveDataToArray:(NSData *)data {
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return array;
}


#pragma mark - class methods
+(NSArray *)convertArrayOfDictionaryToArrayOfInstances:(NSArray *)arrayOfDictionary {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    AuthenticationDataModel *instance;
    for(NSDictionary *dictionary in arrayOfDictionary) {
        instance = [[AuthenticationDataModel alloc] initWithDictionary:dictionary];
        [array addObject:instance];
    }
    
    return array;
}

+(void)saveArrayToDocuments:(NSArray *)array usingFileName:(NSString *)fileName {
    NSData *data = [AuthenticationDataModel archiveArray:array];
    NSString *documentsFolder = [AuthenticationDataModel applicationDocumentsDirectory];
    NSString *path = [documentsFolder stringByAppendingPathComponent:fileName];
    [data writeToFile:path atomically:YES];
}

+(NSArray *)arrayFromDocuments:(NSString *)fileName {
    NSString *documentsFolder = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *path = [documentsFolder stringByAppendingPathComponent:fileName];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSArray *array = [AuthenticationDataModel unarchiveDataToArray:data];
    
    return array;
}

+ (NSString *) applicationDocumentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

@end
