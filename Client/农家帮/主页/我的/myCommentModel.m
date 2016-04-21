//
//  myCommentModel.m
//  农帮乐
//
//  Created by 王朝源 on 15/12/15.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "myCommentModel.h"
#import <objc/runtime.h>
@implementation myCommentModel
@synthesize description;
//comment;
//commenttime;
//description;
//freight;
//id;
//lastmodifiedtime;
//name;
//originalprice;
//price;
//productid;
//type;
//unit;
//bigportraiturl;
//productID;
//smallportraiturl;
-(instancetype) initWithInfo:(NSDictionary*)user{
    if (self = [super init]) {
        
        //针对用字典给对象的实例变量复制，要求字典的key必须和对象实例变量名一致
        //        [self setValuesForKeysWithDictionary:user];
        if ([[user[@"CommentInfo"] allKeys] containsObject:@"comment"] == YES) {
            self.comment = user[@"CommentInfo"][@"comment"];
        }
        if ([[user[@"CommentInfo"] allKeys] containsObject:@"commenttime"] == YES) {
             self.commenttime = user[@"CommentInfo"][@"commenttime"];
        }
        if ([[user[@"CommentInfo"] allKeys] containsObject:@"description"] == YES) {
            self.description = user[@"CommentInfo"][@"description"];
        }
        if ([[user[@"CommentInfo"] allKeys] containsObject:@"freight"] == YES) {
            self.freight = user[@"CommentInfo"][@"freight"];
        }
        if ([[user[@"CommentInfo"] allKeys] containsObject:@"id"] == YES) {
            self.id = user[@"CommentInfo"][@"id"];
        }
        if ([[user[@"CommentInfo"] allKeys] containsObject:@"lastmodifiedtime"] == YES) {
            self.lastmodifiedtime = user[@"CommentInfo"][@"lastmodifiedtime"];
        }
        if ([[user[@"CommentInfo"] allKeys] containsObject:@"name"] == YES) {
            self.name = user[@"CommentInfo"][@"name"];
        }
        if ([[user[@"CommentInfo"] allKeys] containsObject:@"originalprice"] == YES) {
            self.originalprice = user[@"CommentInfo"][@"originalprice"];
        }
        if ([[user[@"CommentInfo"] allKeys] containsObject:@"price"] == YES) {
            self.price = user[@"CommentInfo"][@"price"];
        }
        if ([[user[@"CommentInfo"] allKeys] containsObject:@"productid"] == YES) {
             self.productid = user[@"CommentInfo"][@"productid"];
        }
        if ([[user[@"CommentInfo"] allKeys] containsObject:@"type"] == YES) {
            self.type = user[@"CommentInfo"][@"type"];
        }
        if ([[user[@"CommentInfo"] allKeys] containsObject:@"unit"] == YES) {
            self.unit = user[@"CommentInfo"][@"unit"];
        }
        
        
        if ([user[@"ProductImage"] isKindOfClass:[NSDictionary class]] == YES) {
            if ([[user[@"ProductImage"] allKeys] containsObject:@"bigportraiturl"] == YES) {
                self.bigportraiturl = user[@"ProductImage"][@"bigportraiturl"];
            }
            
            if ([[user[@"ProductImage"] allKeys] containsObject:@"smallportraiturl"] == YES) {
               self.smallportraiturl = user[@"ProductImage"][@"smallportraiturl"];
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
            [self setValue:@"未知" forKey:key];
        }
    }
}

@end
