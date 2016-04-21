//
//  contactModel2.h
//  农帮乐
//
//  Created by 王朝源 on 15/12/14.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface contactModel2 : NSObject
//ContactInfo =             {
//    address = "";
//    city = "";
//    consumerid = 30;
//    contactid = 13;
//    contacttime = "2015-12-08 17:02:44";
//    displayname = "\U5bf9\U5bf9\U5bf9";
//    province = "";
//    smallportraiturl = "http://182.92.224.165/App/Images/consumer/13/a3164c418dff3a59db356d1cea5d104c";
//    telephone = "";
//};
@property (nonatomic, copy)NSString * address;
@property (nonatomic, copy)NSString * city;
@property (nonatomic, copy)NSString * consumerid;
@property (nonatomic, copy)NSString * contactid;
@property (nonatomic, copy)NSString * contacttime;
@property (nonatomic, copy)NSString * displayname;
@property (nonatomic, copy)NSString * province;
@property (nonatomic, copy)NSString * smallportraiturl;
@property (nonatomic, copy)NSString * telephone;

@end
