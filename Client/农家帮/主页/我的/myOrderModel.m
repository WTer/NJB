//
//  myOrderModel.m
//  农帮乐
//
//  Created by 王朝源 on 15/12/16.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "myOrderModel.h"
#import <objc/runtime.h>

@implementation myOrderModel
@synthesize description;
-(instancetype) initWithInfo:(NSDictionary*)user{
    if (self = [super init]) {
        
        //针对用字典给对象的实例变量复制，要求字典的key必须和对象实例变量名一致
        //        [self setValuesForKeysWithDictionary:user];
        id dict = user[@"ConsigneeInfo"];
        id dict2 = user[@"OrderInfo"];
        id dict3 = user[@"ProductImage"];
        
        if ([dict isKindOfClass:[NSDictionary class]] == YES){
            if ([[dict allKeys] containsObject:@"address"] == YES) {
                self.address = dict[@"address"];
            }
            if ([[dict allKeys] containsObject:@"city"] == YES) {
                self.city = dict[@"city"];
            }
            if ([[dict allKeys] containsObject:@"consumerid"] == YES) {
                self.consumerid = dict[@"consumerid"];
            }
            if ([[dict allKeys] containsObject:@"district"] == YES) {
                self.district = dict[@"district"];
            }
            if ([[dict allKeys] containsObject:@"id"] == YES) {
                self.id = dict[@"id"];
            }
            if ([[dict allKeys] containsObject:@"isdefault"] == YES) {
                self.isdefault = dict[@"isdefault"];
            }
            if ([[dict allKeys] containsObject:@"lastmodifiedtime"] == YES) {
                self.lastmodifiedtime = dict[@"lastmodifiedtime"];
            }
            if ([[dict allKeys] containsObject:@"name"] == YES) {
                self.name = dict[@"name"];
            }
            if ([[dict allKeys] containsObject:@"province"] == YES) {
                self.province = dict[@"province"];
            }
            if ([[dict allKeys] containsObject:@"telephone"] == YES) {
                self.telephone = dict[@"telephone"];
            }
        }
        
        
        if ([dict2 isKindOfClass:[NSDictionary class]] == YES) {
            if ([[dict2 allKeys] containsObject:@"consigneeid"] == YES) {
                self.consigneeid = dict2[@"consigneeid"];
            }
            if ([[dict2 allKeys] containsObject:@"count"] == YES) {
                self.count = dict2[@"count"];
            }
            if ([[dict2 allKeys] containsObject:@"description"] == YES) {
                self.description = dict2[@"description"];
            }
            if ([[dict2 allKeys] containsObject:@"freight"] == YES) {
                self.freight = dict2[@"freight"];
            }
            if ([[dict2 allKeys] containsObject:@"id"] == YES) {
                self.orderID = dict2[@"id"];
            }
            if ([[dict2 allKeys] containsObject:@"name"] == YES) {
                self.orderName = dict2[@"name"];
            }
            if ([[dict2 allKeys] containsObject:@"ordertime"] == YES) {
                self.ordertime = dict2[@"ordertime"];
            }
            if ([[dict2 allKeys] containsObject:@"originalprice"] == YES) {
                self.originalprice = dict2[@"originalprice"];
            }
            if ([[dict2 allKeys] containsObject:@"price"] == YES) {
                self.price = dict2[@"price"];
            }
            if ([[dict2 allKeys] containsObject:@"producerid"] == YES) {
                self.producerid = dict2[@"producerid"];
            }
            if ([[dict2 allKeys] containsObject:@"producerid"] == YES) {
                self.producerid = dict2[@"producerid"];
            }
            if ([[dict2 allKeys] containsObject:@"status"] == YES) {
                self.status = dict2[@"status"];
            }
            if ([[dict2 allKeys] containsObject:@"type"] == YES) {
                self.type = dict2[@"type"];
            }
            if ([[dict2 allKeys] containsObject:@"unit"] == YES) {
                self.unit = dict2[@"unit"];
            }
        }
        
        
        
        
        
        if ([dict3 isKindOfClass:[NSDictionary class]] == YES) {
            if ([[dict3 allKeys] containsObject:@"bigportraiturl"] == YES) {
                self.bigportraiturl = dict3[@"bigportraiturl"];
            }
            if ([[dict3 allKeys] containsObject:@"smallportraiturl"] == YES) {
                self.smallportraiturl = dict3[@"smallportraiturl"];
            }
        }
        
        
        
    
        [self puanduanweizhi];
    }
    return self;
}

#pragma mark  --判断model的属性值是否为空，如果是空的就会设置成@“未知”
- (void )puanduanweizhi
{
//    NSMutableDictionary *dictionaryFormat = [NSMutableDictionary dictionary];
    
    //  取得当前类类型
    Class cls = [self class];
    
    unsigned int ivarsCnt = 0;
    //　获取类成员变量列表，ivarsCnt为类成员数量
    Ivar *ivars = class_copyIvarList(cls, &ivarsCnt);
    
    //　遍历成员变量列表，其中每个变量都是Ivar类型的结构体
    for (const Ivar *p = ivars; p < ivars + ivarsCnt; ++p)
    {
        Ivar const ivar = *p;
        
        //　获取变量名
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        // 若此变量未在类结构体中声明而只声明为Property，则变量名加前缀 '_'下划线
        // 比如 @property(retain) NSString *abc;则 key == _abc;
        
        //　获取变量值
        id value = [self valueForKey:key];
        
        //　取得变量类型
        // 通过 type[0]可以判断其具体的内置类型
//        const char * type = ivar_getTypeEncoding(ivar);
        
        if (!value)
        {
//            [dictionaryFormat setObject:value forKey:key];
            [self setValue:@"未知" forKey:key];
        }
    }
}


@end
