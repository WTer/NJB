//
//  BaseModel.m
//  MyPlay
//
//  Created by 赵波 on 15/8/6.
//  Copyright (c) 2015年 10020. All rights reserved.
//

#import "BaseModel.h"
#import <objc/runtime.h>

@implementation BaseModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        for (NSString *key in [self propertyKeys]) {
            NSString *nKey = [key isEqualToString:@"id"]?@"identifier":key;
            
            id propertyValue = [dictionary valueForKey:key];
            
            if (![propertyValue isKindOfClass:[NSNull class]] && propertyValue) {
                [self setValue:propertyValue forKey:nKey];
            } else {
                unsigned int outCount, i;
                objc_property_t *properties = class_copyPropertyList([self class], &outCount);
                NSString *attribut;
                
                for (i = 0; i < outCount; i++) {
                    objc_property_t property = properties[i];
                    attribut = [[NSString alloc] initWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
                    NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];

                    if ([propertyName isEqualToString:nKey]) {
                        break;
                    }
                }
                
                NSRange range = [attribut rangeOfString:@"Array"];
                
                if (range.length) {
                    [self setValue:[NSArray array] forKey:nKey];
                }
                
                range = [attribut rangeOfString:@"String"];
                
                if (range.length) {
                    [self setValue:@"" forKey:nKey];
                }
                
                range = [attribut rangeOfString:@"Number"];
                
                if (range.length) {
                    [self setValue:[NSNumber numberWithBool:NO] forKey:nKey];
                }
            }
        }
    }
    return self;
}

- (NSArray *)propertyKeys

{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    NSMutableArray *keys = [[NSMutableArray alloc] initWithCapacity:outCount];
    
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        
        [keys addObject:propertyName];
    }

    [keys addObject:@"id"];

    free(properties);
    
    return keys;
}

- (NSString *)getStringValue:(NSDictionary *)dictionary key:(NSString *)key
{
    if ([dictionary valueForKey:key]) {
        return [dictionary valueForKey:key];
    }
    
    return @"";
}

@end
