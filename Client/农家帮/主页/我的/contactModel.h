//
//  contactModel.h
//  农帮乐
//
//  Created by 王朝源 on 15/12/14.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface contactModel : NSObject
//address = "\U4e2d\U5c71\U8def1";
//city = "\U5317\U4eac";
//contactid = 14;
//contacttime = "2015-12-08 10:46:39";
//displayname = "\U6c47\U4e30\U519c\U573a";
//producerid = 110;
//province = "\U5317\U4eac";
//smallportraiturl = "http://182.92.224.165/App/Images/producer/8/e10b84b2728e43f10021613863aa2242";
//telephone = 18600089738;
@property (nonatomic, strong) NSString * address;
@property (nonatomic, strong) NSString * city;
@property (nonatomic, strong) NSString * contactid;
@property (nonatomic, strong) NSString * contacttime;
@property (nonatomic, strong) NSString * displayname;
@property (nonatomic, strong) NSString * producerid;
@property (nonatomic, strong) NSString * province;
@property (nonatomic, strong) NSString * smallportraiturl;
@property (nonatomic, strong) NSString * telephone;
-(instancetype) initWithInfo:(NSDictionary*)user;
@end
