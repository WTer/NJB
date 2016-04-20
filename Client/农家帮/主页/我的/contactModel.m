//
//  contactModel.m
//  农帮乐
//
//  Created by 王朝源 on 15/12/14.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "contactModel.h"

@implementation contactModel

-(instancetype) initWithInfo:(NSDictionary*)user{
    if (self = [super init]) {
        
        //针对用字典给对象的实例变量复制，要求字典的key必须和对象实例变量名一致
        //        [self setValuesForKeysWithDictionary:user];
        if ([[user allKeys] containsObject:@"address"] == YES) {
            self.address = user[@"address"];
        }
        if ([[user allKeys] containsObject:@"city"] == YES) {
            self.city = user[@"city"];
        }
        if ([[user allKeys] containsObject:@"contacttime"] == YES) {
            self.contacttime = user[@"contacttime"];
        }
        if ([[user allKeys] containsObject:@"displayname"] == YES) {
            self.displayname = user[@"displayname"];
        }
        if ([[user allKeys] containsObject:@"province"] == YES) {
            self.province = user[@"province"];
        }
        if ([[user allKeys] containsObject:@"smallportraiturl"] == YES) {
            self.smallportraiturl = user[@"smallportraiturl"];
        }
        if ([[user allKeys] containsObject:@"telephone"] == YES) {
            self.telephone = user[@"telephone"];
        }
        [self panduanweizhi];
    }
    return self;
}

+(BOOL) propertyIsOptional:(NSString *)propertyName{
    return YES;
}
#pragma mark --当其中某个值为空的时候我们需要将其设置为未知
- (void)panduanweizhi
{
    if (!self.address) {
        self.address = @"未知";
    }
    if (!self.city) {
        self.city = @"未知";
    }
    if (!self.contacttime) {
        self.contacttime = @"未知";
    }
    if (!self.displayname) {
        self.displayname = @"未知";
    }
    if (!self.province) {
        self.province = @"未知";
    }
    if (!self.smallportraiturl) {
        self.smallportraiturl = @"未知";
    }
    if (!self.telephone) {
        self.telephone = @"未知";
    }
    
}

@end
