//
//  myCollectionModel.m
//  农帮乐
//
//  Created by 王朝源 on 15/12/16.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "myCollectionModel.h"

@implementation myCollectionModel
//t
//bigportraiturl;
//smallportraiturl;
//freight;
//name;
//price;
//productid;
//type;
//unit;
//id;

- (void)panduanQingqiuShuju
{
    if (!self.name) {
        self.name = @"未知";
    }
    if (!self.bigportraiturl) {
        self.bigportraiturl = @"未知";
    }
    if (!self.smallportraiturl) {
        self.smallportraiturl = @"未知";
    }
    if (!self.freight) {
        self.freight = @"未知";
    }
    if (!self.price) {
        self.price = @"未知";
    }
    if (!self.type) {
        self.type = @"未知";
    }
    if (!self.unit) {
        self.unit = @"未知";
    }
    if (!self.id) {
        self.id = @"未知";
    }
}

@end
