//
//  JSONModel.h
//  eMyGym
//
//  Created by Gary Davies on 15/02/2014.
//  Copyright (c) 2014 Gary Davies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONModel : NSObject <NSCoding, NSCopying, NSMutableCopying>

- (id)initWithDictionary:(NSDictionary *)dictionary;

- (NSData *)archivedData;
+ (id)jsonModelFromArchivedData:(NSData *)data;

@end
