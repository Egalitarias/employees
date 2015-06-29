//
//  JSONModel.m
//  eMyGym
//
//  Created by Gary Davies on 15/02/2014.
//  Copyright (c) 2014 Gary Davies. All rights reserved.
//

#import "JSONModel.h"

@implementation JSONModel

- (id)initWithDictionary:(NSDictionary *)dictionary {
	self = [super init];
	if (self) {
		[self setValuesForKeysWithDictionary:dictionary];
	}
	return self;
}


#pragma mark - NSCoding protocol methods
- (BOOL)allowsKeyedCoding {
	return YES;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	// do nothing
}


#pragma mark - NSObject protocol methods
- (BOOL)isEqual:(id)object {
	if (object && [object isKindOfClass:[JSONModel class]]) {
		return YES;
	}
	
	return NO;
}

- (NSUInteger)hash {
	NSUInteger selfHash = NSUINTROTATE([super hash], HASHAMOUNT);
	
	return selfHash;
}


#pragma mark - NSCopying protocol methods
- (id)copyWithZone:(NSZone *)zone {
	// subclass implementation should do a deep mutable copy
	// this class doesn't have any ivars so this is ok
	
	JSONModel *newModel = [[JSONModel allocWithZone:zone] init];
	return newModel;
}


#pragma mark - NSMutableCopying protocol methods
- (id)mutableCopyWithZone:(NSZone *)zone {
	// subclass implementation should do a deep mutable copy
	// this class doesn't have any ivars so this is ok
	
	JSONModel *newModel = [[JSONModel allocWithZone:zone] init];
	return newModel;
}


#pragma mark - NSKeyValueCoding protocol methods
- (id)valueForUndefinedKey:(NSString *)key {
	// subclass implementation should provide correct key value mappings for custom keys
    NSLog(@"Undefined Key: %@", key);
    return nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    // subclass implementation should set the correct key value mappings for custom keys
    NSLog(@"Undefined Key: %@", key);
}


#pragma mark - Public methods
- (NSData *)archivedData {
	return [NSKeyedArchiver archivedDataWithRootObject:self];
}


#pragma mark - Class methods
+ (id)jsonModelFromArchivedData:(NSData *)data {
	return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

@end
