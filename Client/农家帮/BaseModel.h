//
//  BaseModel.h
//  MyPlay
//
//  Created by 赵波 on 15/8/6.
//  Copyright (c) 2015年 10020. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

@property (nonatomic, copy) NSString *identifier;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (NSArray *)propertyKeys;
- (NSString *)getStringValue:(NSDictionary *)dictionary key:(NSString *)key;

@end
