//
//  myOrderModel.h
//  农帮乐
//
//  Created by 王朝源 on 15/12/16.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface myOrderModel : NSObject
//(
// {
//     ConsigneeInfo =             {
//         address = "\U5c0f\U4e1c\U897f";
//         city = "\U5317\U4eac";
//         consumerid = 30;
//         district = "\U6d77\U6dc0";
//         id = 28;
//         isdefault = true;
//         lastmodifiedtime = "2015-12-15 10:59:05";
//         name = "\U90fd\U662f";
//         province = "\U5317\U4eac";
//         telephone = 11;
//     };
//     OrderInfo =             {
//         consigneeid = 28;
//         consumerid = 30;
//         count = 2;
//         description = 123;
//         freight = "0.00";
//         id = 56;
//         lastmodifiedtime = "2015-12-14 13:45:59";
//         name = 123;
//         ordertime = "2015-12-16 09:01:10";
//         originalprice = "50.00";
//         price = "20.00";
//         producerid = 139;
//         productid = 78;
//         status = 0;
//         type = "\U526f\U98df";
//         unit = "\U4e2a";
//     };
//     ProductImage =             {
//         bigportraiturl = "http://182.92.224.165/App/Images/product/13/067cbe2b266849448269a081fe325dec";
//         id = 115;
//         smallportraiturl = "http://182.92.224.165/App/Images/product/13/78efb66b549a056948981017dbe43277";
//     };
// }
// );
@property (nonatomic, copy)NSString * address;
@property (nonatomic, copy)NSString * city;
@property (nonatomic, copy)NSString * consumerid;
@property (nonatomic, copy)NSString * district;
@property (nonatomic, copy)NSString * id;
@property (nonatomic, copy)NSString * isdefault;
@property (nonatomic, copy)NSString * lastmodifiedtime;
@property (nonatomic, copy)NSString * name;
@property (nonatomic, copy)NSString * province;
@property (nonatomic, copy)NSString * telephone;

@property (nonatomic, copy)NSString * consigneeid;
@property (nonatomic, copy)NSString * count;
@property (nonatomic, copy)NSString * description;
@property (nonatomic, copy)NSString * freight;
@property (nonatomic, copy)NSString * orderID;
@property (nonatomic, copy)NSString * orderName;
@property (nonatomic, copy)NSString * ordertime;
@property (nonatomic, copy)NSString * originalprice;
@property (nonatomic, copy)NSString * price;
@property (nonatomic, copy)NSString * producerid;
@property (nonatomic, copy)NSString * productid;
@property (nonatomic, copy)NSString * status;
@property (nonatomic, copy)NSString * type;
@property (nonatomic, copy)NSString * unit;


@property (nonatomic, copy)NSString * bigportraiturl;
@property (nonatomic, copy)NSString * smallportraiturl;

-(instancetype) initWithInfo:(NSDictionary*)user;
@end
