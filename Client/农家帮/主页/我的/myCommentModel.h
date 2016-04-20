//
//  myCommentModel.h
//  农帮乐
//
//  Created by 王朝源 on 15/12/15.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface myCommentModel : NSObject
//{
//    CommentInfo =             {
//        comment = "\U6c34\U7535\U8d39\U56de\U5bb6\U53ef\U4e0d\U884c";
//        commenttime = "2015-12-15 08:54:05";
//        description = 123;
//        freight = "0.00";
//        id = 62;
//        lastmodifiedtime = "2015-12-14 13:45:59";
//        name = 123;
//        originalprice = "50.00";
//        price = "20.00";
//        productid = 78;
//        type = "\U526f\U98df";
//        unit = "\U4e2a";
//    };
//    ProductImage =             {
//        bigportraiturl = "http://182.92.224.165/App/Images/product/13/067cbe2b266849448269a081fe325dec";
//        id = 115;
//        smallportraiturl = "http://182.92.224.165/App/Images/product/13/78efb66b549a056948981017dbe43277";
//    };
//},

@property (nonatomic, copy)NSString * comment;
@property (nonatomic, copy)NSString * commenttime;
@property (nonatomic, copy)NSString * description;
@property (nonatomic, copy)NSString * freight;
@property (nonatomic, copy)NSString * id;
@property (nonatomic, copy)NSString * lastmodifiedtime;
@property (nonatomic, copy)NSString * name;

@property (nonatomic, copy)NSString * originalprice;
@property (nonatomic, copy)NSString * price;
@property (nonatomic, copy)NSString * productid;
@property (nonatomic, copy)NSString * type;
@property (nonatomic, copy)NSString * unit;
@property (nonatomic, copy)NSString * bigportraiturl;
@property (nonatomic, copy)NSString * productID;
@property (nonatomic, copy)NSString * smallportraiturl;
-(instancetype) initWithInfo:(NSDictionary*)user;
@end
