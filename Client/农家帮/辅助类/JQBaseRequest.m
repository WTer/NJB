//
//  JQBaseRequest.m
//  csNet
//
//  Created by 王朝源 on 15/12/1.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "JQBaseRequest.h"


@implementation JQBaseRequest
//post请求
-(void) POSTrequestWitUrlString:(NSString *)urlString para:(NSDictionary *)dict complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    //指定响应格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    //请求
    [manager POST:urlString parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        finish(dictionary);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSDictionary * dict = [self dictionaryWithJsonString:operation.responseString];
        failure(error, dict[@"error"]);
    }];

}

//put请求
-(void) PUTrequestWitUrlString:(NSString *)urlString para:(NSDictionary *)dict complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    //指定响应格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //请求
    [manager PUT:urlString parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        finish(dictionary);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSDictionary * dict = [self dictionaryWithJsonString:operation.responseString];
        failure(error, dict[@"error"]);
    }];
}

//get请求
-(void) GETrequestWitUrlString:(NSString *)urlString para:(NSString *)str complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    //指定响应格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:urlString parameters:str success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        finish(dictionary);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSDictionary * dict = [self dictionaryWithJsonString:operation.responseString];
        failure(error, dict[@"error"]);
    }];
}

//delete请求
-(void) DELETErequestWitUrlString:(NSString *)urlString para:(NSString *)str complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    //指定响应格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager DELETE:urlString parameters:str success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        finish(dictionary);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSDictionary * dict = [self dictionaryWithJsonString:operation.responseString];
        failure(error, dict[@"error"]);
    }];
}






















#pragma mark --7.9 删除农场主的商品收藏
- (void)deleteProducerShouCangProductWithFavoriteId:(NSString *)FavoriteId Complete:(SuccessBlock)finish fail:(FailureBlock)failure {

    [self DELETErequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Favorite/Producer/Product/%@",FavoriteId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];

}
#pragma mark --7.10 删消费者的商品收藏
//https://<endpoint>/Favorite/Consumer/Product/[FavoriteId]
- (void)deleteConsumerShouCangProductWithFavoriteId:(NSString *)FavoriteId Complete:(SuccessBlock)finish fail:(FailureBlock)failure {

    [self DELETErequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Favorite/Consumer/Product/%@",FavoriteId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];

}
#pragma mark --7.11 删消费者的农场主收藏
//https://<endpoint>/Favorite/Consumer/Producer/[FavoriteId]
- (void)deleteConsumerShouCangProducerWithFavoriteId:(NSString *)FavoriteId Complete:(SuccessBlock)finish fail:(FailureBlock)failure {


    [self DELETErequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Favorite/Consumer/Producer/%@",FavoriteId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
    
}
#pragma mark -6.1 新增订单
- (void)PostProductOrderWithConsumerId:(NSString *)ConsumerId ProductId:(NSString *)ProductId Count:(NSString *)Count Unit:(NSString *)Unit Description:(NSString *)Description ConsigneeId:(NSString *)ConsigneeId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    NSString *str = [Unit stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * dict = @{@"Count":Count,@"Unit":str,@"Description":Description,@"ConsigneeId":ConsigneeId};
    [self POSTrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Order/ConsumerId/%@/ProductId/%@",ConsumerId,ProductId] para:dict complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
    
}

#pragma mark --4.1 商品发布—基本信息文字信息(商品发布的接口)
- (void)ShangPinFaBuByPostRequestWithName:(NSString *)name Description:(NSString *)description Type:(NSString *)type Price:(NSString *)price OriginalPrice:(NSString *)OriginalPrice Unit:(NSString *)unit Freight:(NSString *)Freight ProducerId:(NSString *)ProducerId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    NSDictionary * dict = @{@"Name":name, @"Description":description, @"Type":type, @"Price":price, @"OriginalPrice":OriginalPrice, @"Unit":unit, @"Freight":Freight, @"ProducerId":ProducerId};
    [self POSTrequestWitUrlString:@"http://182.92.224.165/Product/BasicInfo/" para:dict complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}
#pragma mark --4.5 商品发布/修改—图片
//图片描述Description和图片idImageId
- (void)ShangPinFaBUImageByPutRequestWithProductId:(NSString *)ProductId Count:(NSInteger)count List:(NSArray *)list complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < list.count; i++) {
        UIImage *image = list[i];
        NSString *encodedImageStr = [[self resetSizeOfImageData:image maxSize:50] base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        NSDictionary *dict = @{@"ImageId":@"", @"Description":@"", @"BigPicture":encodedImageStr,@"SmallPicture":encodedImageStr};
        [array addObject:dict];
    }
    NSDictionary *dict = @{@"Count":[NSString stringWithFormat:@"%ld",(long)count], @"List":array};
    [self PUTrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Product/Images/%@",ProductId] para:dict complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}


#pragma mark -7.1 农场主新增商品收藏
- (void)ProducerShouCangProductWithProducerId:(NSString *)ProducerId ProductId:(NSString *)ProductId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self POSTrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Favorite/Producer/%@/Product/%@",ProducerId,ProductId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}

#pragma mark -7.2 查询农场主商品收藏列表
//http://182.92.224.165/Favorite/Producer/139/Product/?offset=0&limit=15&desc=false
//http://182.92.224.165/Favorite/Producer/139
- (void)GetProducerShouCangProductWithProducerId:(NSString *)ProducerId OffSet:(NSString *)offerset limit:(NSString *)limit complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Favorite/Producer/%@/Product/?offset=%@&limit=%@&desc=false",ProducerId,offerset,limit] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}
#pragma mark -7.4 消费者新增商品收藏
- (void)ConsumerShouCangProductWithConsumerId:(NSString *)ConsumerId ProductId:(NSString *)ProductId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self POSTrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Favorite/Consumer/%@/Product/%@",ConsumerId,ProductId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}
#pragma mark -7.5 查询消费者商品收藏列表
//http://182.92.224.165/Favorite/Producer/139/Product/?offset=0&limit=15&desc=false
//http://182.92.224.165/Favorite/Producer/139
- (void)GetConsumerShouCangProductWithConsumerId:(NSString *)ConsumerId OffSet:(NSString *)offerset limit:(NSString *)limit complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Favorite/Consumer/%@/Product/?offset=%@&limit=%@&desc=false",ConsumerId,offerset,limit] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}

#pragma mark -7.3 农场主商品收藏总数查询
- (void)ProducerShouCangTotalProductWithProducerId:(NSString *)ProducerId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Favorite/Producer/%@/Count",ProducerId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}
#pragma mark -7.6 消费者商品收藏总数查询
- (void)ConsumerShouCangTotalProductWithConsumerId:(NSString *)ConsumerId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Favorite/Consumer/%@/Count",ConsumerId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}

#pragma mark -5.1 新增商品论评
- (void)PostProductCommentWithConsumerId:(NSString *)ConsumerId ProductId:(NSString *)ProductId Comment:(NSString *)Comment complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    NSDictionary * dict = @{@"ProductId":ProductId,@"Comment":Comment,@"ConsumerId":ConsumerId};
    [self POSTrequestWitUrlString:@"http://182.92.224.165/ProductComment/" para:dict complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}
#pragma mark -5.3 查询商品评论—列表ID
- (void)GetProductCommentWithProductId:(NSString *)ProductId OffSet:(NSString *)offerset limit:(NSString *)limit complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/ProductComment/List/%@/?offset=%@&limit=%@&desc=false",ProductId,offerset,limit] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}

#pragma mark -- 农场主注册—基本信息(post) https://<endpoint>/Producer/BasicInfo/
- (void) FarmOwnerRegisterBaseMassage:(NSDictionary *)dictMessage complete:(SuccessBlock)finish fail:(FailureBlock)failure
{
//    NSString * str = [self dictionaryToJson:dictMessage];
    [self POSTrequestWitUrlString:@"http://182.92.224.165/Producer/BasicInfo/" para:dictMessage complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}

#pragma mark -- 农场主修改—基本信息(put)  https://<endpoint>/Producer/BasicInfo/[ProducerId]
- (void)FarmerOwnerAlertBaseMessageWithProducerID:(NSString *)producerID dictMessage:(NSDictionary *)dictMessage complete:(SuccessBlock)finish fail:(FailureBlock)failure
{
    [self PUTrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Producer/BasicInfo/%@", producerID] para:dictMessage complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}

#pragma mark --  农场主查询—基本信息 (get) https://<endpoint>/Producer/BasicInfo/[ProducerId]
- (void)FarmerOwnerSelectedBaseMessageWithProducerID:(NSString *)producerID complete:(SuccessBlock)finish fail:(FailureBlock)failure
{
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Producer/BasicInfo/%@", producerID] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}


#pragma mark --  农场主注册/修改—头像 (put)  https://<endpoint>/Producer/Portrait/[ProducerId]
//传入的是{"BigPortrait":"用户大头像","SmallPortrait":"用户小头像"｝
- (void)FarmerOwnerRegisterOrAlertHeaderImageWithProducerID:(NSString *)producerID dictMessage:(NSDictionary *)dictMessage complete:(SuccessBlock)finish fail:(FailureBlock)failure
{
    
    NSData *data1 = UIImageJPEGRepresentation([[ImageTool shareTool]resizeImageToSize:CGSizeMake(150, 150) sizeOfImage:dictMessage[@"BigPortrait"]], 1.0f);
    NSData *data2 = UIImageJPEGRepresentation([[ImageTool shareTool]resizeImageToSize:CGSizeMake(150, 150) sizeOfImage:dictMessage[@"SmallPortrait"]], 1.0f);
    NSString *encodedImageStr1 = [data1 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *encodedImageStr2 = [data2 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSDictionary * dict = @{@"BigPortrait":encodedImageStr1, @"SmallPortrait":encodedImageStr2};
    [self PUTrequestWitUrlString:[NSString stringWithFormat:@"%@/Producer/Portrait/%@", BaseURL, producerID] para:dict complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}

#pragma mark -- 农场主查询—头像(get)  https://<endpoint>/Producer/Portrait/[ProducerId]
- (void)FarmerOwnerSelectedHeaderImageWithProducerID:(NSString *)producerID complete:(SuccessBlock)finish fail:(FailureBlock)failure
{
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"%@/Producer/Portrait/%@", BaseURL, producerID] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}

#pragma mark --农场主注册/修改—扩展信息(put)  https://<endpoint>/Producer/RichInfo/[ProducerId]
- (void)FarmerOwnerRegisterOrAlertExtensionMessageWithProducerID:(NSString *)producerID dictMessage:(NSDictionary *)dictMessage complete:(SuccessBlock)finish fail:(FailureBlock)failure
{
    [self PUTrequestWitUrlString:[NSString stringWithFormat:@"%@/Producer/RichInfo/%@", BaseURL, producerID] para:dictMessage complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}

#pragma mark -- 2.7农场主查询—扩展信息(get)  https://<endpoint>/Producer/RichInfo/[ProducerId]
- (void)FarmerOwnerSelectedExtensiobMessageWithProducerID:(NSString *)producerID complete:(SuccessBlock)finish fail:(FailureBlock)failure
{
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"%@/Producer/RichInfo/%@", BaseURL, producerID] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}


#pragma mark -- 2.8 农场主注册/修改—认证证书(put) https://<endpoint>/Producer/Certificate/[ProducerId]
- (void)FarmerOwnerRegisterOrAlertConfirmBookWithProducerID:(NSString *)ProducerID dictMessage:(NSDictionary *)dictMessage complete:(SuccessBlock)finish fail:(FailureBlock)failure;
{
    [self PUTrequestWitUrlString:[NSString stringWithFormat:@"%@/Producer/Certificate/%@", BaseURL, ProducerID] para:dictMessage complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}

#pragma mark --农场主查询—认证证书(get)https://<endpoint>/Producer/Certificate/[ProducerId]
- (void)FarmerSelectedConfirmBookWithProducerID:(NSString *)ProducerID complete:(SuccessBlock)finish fail:(FailureBlock)failure
{
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"%@/Producer/Certificate/%@", BaseURL, ProducerID] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}

#pragma mark --删除证书（delete） https://<endpoint>/Producer/Certificate/[CertificateId]
- (void)FarmerOwnerDeleteConfirmBookWithCertificationID:(NSString *)certificateId complete:(SuccessBlock)finish fail:(FailureBlock)failure
{
    [self DELETErequestWitUrlString:[NSString stringWithFormat:@"%@/Producer/Certificate/%@" ,BaseURL, certificateId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}


#pragma mark --农场主登录(get)  https://<endpoint>/Producer/LoginName/[LoginName]/SessionKey/[SessionKey]
- (void)FarmerOwnerLoginWithLoginName:(NSString *)loginName  SessionKey:(NSString *)sessionKey complete:(SuccessBlock)finish fail:(FailureBlock)failure
{
    NSString * str1 = [self JSONString:loginName];
    NSString * str2 = [self JSONString:sessionKey];
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"%@/Producer/LoginName/%@/SessionKey/%@", BaseURL, str1, str2] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}
#pragma mark  --- 验证农场主注册手机号是否存在(get) https://<endpoint>/Producer/LoginNameCheck/[LoginName]
- (void)ConfirmFarmerOwnerPhoneNumberWithLoginName:(NSString *)loginName omplete:(SuccessBlock)finish fail:(FailureBlock)failure
{
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"%@/Producer/LoginNameCheck/%@", BaseURL, loginName] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}

#pragma mark  --- 农场主修改密码(put) https://<endpoint>/Producer/Password/[ProducerId]
- (void)FarmerOwnerAlertPassWordWithProducerId:(NSString *)producerId OldPassword:(NSString *)oldPassword NewPassword:(NSString *)newPassword complete:(SuccessBlock)finish fail:(FailureBlock)failure
{
    NSDictionary * dict = @{@"OldPassword":oldPassword, @"NewPassword":newPassword};
    [self PUTrequestWitUrlString:[NSString stringWithFormat:@"%@/Producer/Password/%@", BaseURL, producerId] para:dict complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}

#pragma mark  ---发送短信验证码(post) https://<endpoint>/Producer/SmsCode/
- (void)senderTextMessageWithTelephonNumber:(NSString *)telephoneNumber complete:(SuccessBlock)finish fail:(FailureBlock)failure
{
    NSDictionary * dict = @{@"Telephone":telephoneNumber};
    [self POSTrequestWitUrlString:@"http://182.92.224.165/Producer/SmsCode/" para:dict complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}

#pragma mark  ---验证短信码 (get) https://<endpoint>/Producer/SmsCode/[SmsCodeId]/[UserSmsCode]/[Telephone]
- (void)confirmTextMessageWithSmsCodeId:(NSString *)smsCodeId UserSmsCode:(NSString *)userSmsCode TelephoneNumber:(NSString *)telephoneNumber complete:(SuccessBlock)finish fail:(FailureBlock)failure
{
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"%@/Producer/SmsCode/%@/%@/%@", BaseURL, smsCodeId, userSmsCode, telephoneNumber] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~/
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~消费者~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~～～～～~/
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~/

#pragma mark --消费者注册—基本信息(post)  https://<endpoint>/Consumer/BasicInfo/
- (void)ConsumerRegisterBaseMessageWithMessageDict:(NSDictionary *)dictMessage complete:(SuccessBlock)finish fail:(FailureBlock)failure
{
    [self POSTrequestWitUrlString:@"http://182.92.224.165/Consumer/BasicInfo/" para:dictMessage complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
    
}

#pragma mark --消费者修改—基本信息(put) https://<endpoint>/Consumer/BasicInfo/[ConsumerId]
- (void)ConsumerAlertBaseMessageWithConsumerID:(NSString *)consumerID ConsumerDictMessage:(NSDictionary *)dictMessage complete:(SuccessBlock)finish fail:(FailureBlock)failure
{
    [self PUTrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Consumer/BasicInfo/%@", consumerID] para:dictMessage complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}

#pragma mark --消费者查询—基本信息(get) https://<endpoint>/Consumer/BasicInfo/[ConsumerId]
- (void)ConsumerSelectedBaseMessageWithConsumerID:(NSString *)consumerID complete:(SuccessBlock)finish fail:(FailureBlock)failure
{
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Consumer/BasicInfo/%@", consumerID] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}

#pragma mark --消费者注册/修改—头像(put) https://<endpoint>/Consumer/Portrait/[ConsumerId]
- (void)ConsumerRegisterOrAlertHeaderImageWithConsumerID:(NSString *)consumerID ConsumerDictMessage:(NSDictionary *)dictMessage complete:(SuccessBlock)finish fail:(FailureBlock)failure
{
//    dictMessage[@"BigPortrait"] dictMessage[@"SmallPortrait"]
    NSData *data1 = [self resetSizeOfImageData:[[ImageTool shareTool]resizeImageToSize:CGSizeMake(150, 150) sizeOfImage:dictMessage[@"BigPortrait"]] maxSize:150];
    NSData *data2 = [self resetSizeOfImageData:[[ImageTool shareTool]resizeImageToSize:CGSizeMake(150, 150) sizeOfImage:dictMessage[@"SmallPortrait"]] maxSize:150];
    NSString *encodedImageStr1 = [data1 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *encodedImageStr2 = [data2 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSDictionary * dict = @{@"BigPortrait":encodedImageStr1, @"SmallPortrait":encodedImageStr2};
    [self PUTrequestWitUrlString:[NSString stringWithFormat:@"%@/Consumer/Portrait/%@", BaseURL, consumerID] para:dict complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
    
}

#pragma mark -- 消费者查询—头像(get) https://<endpoint>/Consumer/Portrait/[ConsumerId]
- (void)ConsumerSelectedHeaderImageWithConsumerID:(NSString *)consumerID complete:(SuccessBlock)finish fail:(FailureBlock)failure
{
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Consumer/Portrait/%@", consumerID] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}

#pragma mark --消费者注册/修改—扩展信息 (put) https://<endpoint>/Consumer/RichInfo/[ConsumerId]
- (void)ConsumerRegisterOrAlertExtensionMessageWithConsumerId:(NSString *)consurmerId  ConsumerDictMessage:(NSDictionary *)dictMessage complete:(SuccessBlock)finish fail:(FailureBlock)failure
{
    [self PUTrequestWitUrlString:[NSString stringWithFormat:@"%@/Consumer/RichInfo/%@", BaseURL, consurmerId] para:dictMessage complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}

#pragma mark --消费者查询—扩展信息(get) https://<endpoint>/Consumer/RichInfo/[ConsumerId]
- (void)ConsumerSelecterExtensionMessageWithConsumerID:(NSString *)ConsumerID complete:(SuccessBlock)finish fail:(FailureBlock)failure
{
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"%@/Consumer/RichInfo/%@", BaseURL, ConsumerID] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}

#pragma mark --3.8 消费者登录(get) https://<endpoint>/Consumer/LoginName/[LoginName]/SessionKey/[SessionKey]

- (void)ConsumerLoginWithLoginName:(NSString *)loginName SessionKey:(NSString *)sessionkey complete:(SuccessBlock)finish fail:(FailureBlock)failure
{
    NSString * str1 = [self JSONString:loginName];
    NSString * str2 = [self JSONString:sessionkey];
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"%@/Consumer/LoginName/%@/SessionKey/%@", BaseURL, str1, str2] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}
#pragma mark  ---验证消费者注册手机号是否存在(get) https://<endpoint>/Consumer/LoginNameCheck/[LoginName]
- (void)ConfirmConsumerOwnerPhoneNumberWithLoginName:(NSString *)loginName omplete:(SuccessBlock)finish fail:(FailureBlock)failure
{
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"%@/Consumer/LoginNameCheck/%@", BaseURL, loginName] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}

#pragma mark  --消费者修改密码(put)  https://<endpoint>/Consumer/Password/[ConsumerId]
- (void)ConsumerAlertPassWordWithConsumerId:(NSString *)consumerId OldPassword:(NSString *)oldPassword NewPassword:(NSString *)newPassword complete:(SuccessBlock)finish fail:(FailureBlock)failure;
{
    NSDictionary * dict = @{@"OldPassword":oldPassword, @"NewPassword":newPassword};
    [self PUTrequestWitUrlString:[NSString stringWithFormat:@"%@/Consumer/Password/%@", BaseURL, consumerId] para:dict complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}

#pragma mark   ---发送短信验证码(post)  https://<endpoint>/Consumer/SmsCode/
- (void)senderTextMessageWithTelephonNumberOfConsumer:(NSString *)telephoneNumber complete:(SuccessBlock)finish fail:(FailureBlock)failure
{
    NSDictionary * dict = @{@"Telephone":telephoneNumber};
    [self POSTrequestWitUrlString:@"http://182.92.224.165/Consumer/SmsCode/" para:dict complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}

#pragma mark  ---验证短信码 (get) https://<endpoint>/Consumer/SmsCode/[SmsCodeId]/[UserSmsCode]/[Telephone]
- (void)confirmTextMessageOfConsumerWithSmsCodeId:(NSString *)smsCodeId UserSmsCode:(NSString *)userSmsCode TelephoneNumber:(NSString *)telephoneNumber complete:(SuccessBlock)finish fail:(FailureBlock)failure; {
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"%@/Consumer/SmsCode/%@/%@/%@", BaseURL, smsCodeId, userSmsCode, telephoneNumber] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}
#pragma mark  商品发布－基本信息(post) https://<endpoint>/Product/BasicInfo/
- (void)GoodsIsureBaseMessageWithGoodsName:(NSString *)Name
                          GoodsDescription:(NSString *)description
                                 GoodsType:(NSString *)type
                                GoodsPrice:(NSString *)price
                        GoodsOriginalPrice:(NSString *)originalPrice
                                 GoodsUnit:(NSString *)unit
                                   Freight:(NSString *)freight
                                ProducerId:(NSString *)producerId complete:(SuccessBlock)finish fail:(FailureBlock)failure
{
    
}

#pragma mark  -- 4.4 商品列表查询—基本信息(get)  https://<endpoint>/Product/BasicInfo/List/?UserId=&UserType=C/P&Province=&City=&Address=&ProductType=&ProductName=&ProductDesc=&offset=0&limit=15&desc=true
- (void)GoodsListSelectedBaseMessageWithUserID:(NSString *)UserId IsFarmer:(BOOL)isFarmer OffSet:(NSString *)offerset limit:(NSString *)limit complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    NSString * str = isFarmer?@"P":@"C";
   
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Product/BasicInfo/List/?UserId=%@&UserType=%@/P&Province=&City=&Address=&ProductType=&ProductName=&ProductDesc=&offset=%@&limit=%@&desc=false", UserId, str, offerset, limit] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}

#pragma mark --10.1 查询省市区列表
- (void)getWeiZhiComplete:(SuccessBlock)finish fail:(FailureBlock)failure {
    [self GETrequestWitUrlString:@"http://182.92.224.165/Common/ProvinceCityList" para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}
#pragma mark --4.8 商品查询—热门搜索词
- (void)getSouSuoReBangComplete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self GETrequestWitUrlString:@"http://182.92.224.165/Product/HotSearchWord/?limit=10" para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}

#pragma mark --4.8 商品查询 
- (void)SearchGoodsListWithUserID:(NSString *)UserId IsFarmer:(BOOL)isFarmer ProductName:(NSString *)ProductName ProductDesc:(NSString *)ProductDesc OffSet:(NSString *)offerset limit:(NSString *)limit complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    NSString *ProductNameStr = [ProductName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *ProductDescStr = [ProductDesc stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * str = isFarmer?@"P":@"C";
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Product/BasicInfo/List/?UserId=%@&UserType=%@/P&Province=&City=&Address=&ProductType=&ProductName=%@&ProductDesc=%@&offset=%@&limit=%@&desc=false", UserId, str, ProductNameStr, ProductDescStr,offerset, limit] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];

}
#pragma mark -5.5 查询某个用户的全部商品评论(get) https://<endpoint>/ProductComment/UserCommentList/[ConsumerId]/?offset=0&limit=15
- (void)SelectedSomeBodyAllGoodsCommentsWithConsumerId:(NSString *)consumerId Offset:(NSString *)offset Limit:(NSString *)limit complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/ProductComment/UserCommentList/%@/?offset=%@&limit=%@", consumerId, offset, limit] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}

#pragma mark   6.11 查询热门快递(get) https://<endpoint>/Order/HotExpress/?limit=10
- (void)selectedHotKuaiDiWithLimit:(NSString *)limit complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Order/HotExpress/?limit=%@", limit] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}
#pragma mark  8.2 查询农场主的消费者联系人列表(get) https://<endpoint>/Contact/Producer/[ProducerId]/Consumer
- (void)selectedFarmerOwnerContactListWithProducerId:(NSString *)ProducerId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Contact/Producer/%@/Consumer", ProducerId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error ,errorString);
    }];
}


#pragma mark   8.8 查询消费者的农场主联系人列表(get)  https://<endpoint>/Contact/Consumer/[ConsumerId]/Count/
- (void)ConsumerContactPeopleSelectedWithConsumerId:(NSString *)consumerID complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Contact/Consumer/%@/Producer", consumerID] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}
#pragma mark --9.4 查询消费者的收货人列表
- (void)getShouHuoDiZhiListConsumerId:(NSString *)ConsumerId Complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Order/Consignee/Consumer/%@",ConsumerId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}
#pragma mark --9.1 增加收货人
- (void)postShouHuoRenConsumerId:(NSString *)ConsumerId name:(NSString *)Name telephone:(NSString *)Telephone province:(NSString *)Province city:(NSString *)City district:(NSString *)District address:(NSString *)Address isDefault:(BOOL)IsDefault Complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    NSString * str = IsDefault?@"true":@"false";
    NSDictionary *dict = @{@"Name":Name,@"Telephone":Telephone,@"Province":Province,@"City":City,@"District":District,@"Address":Address,@"IsDefault":str};
    [self POSTrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Order/Consignee/%@",ConsumerId] para:dict complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}
#pragma mark --9.2 修改收货人信息
- (void)putXiuGaiShouHuoRenConsigneeId:(NSString *)ConsigneeId name:(NSString *)Name telephone:(NSString *)Telephone province:(NSString *)Province city:(NSString *)City district:(NSString *)District address:(NSString *)Address isDefault:(BOOL)IsDefault Complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    NSString * str = IsDefault?@"true":@"false";
    NSDictionary *dict = @{@"Name":Name,@"Telephone":Telephone,@"Province":Province,@"City":City,@"District":District,@"Address":Address,@"IsDefault":str};
    [self PUTrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Order/Consignee/%@",ConsigneeId] para:dict complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}
#pragma mark --9.5 删除收货人
- (void)deleteShouHuoRenWithConsigneeId:(NSString *)ConsigneeId Complete:(SuccessBlock)finish fail:(FailureBlock)failure {

    [self DELETErequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Order/Consignee/%@",ConsigneeId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];

    
}



#pragma mark v2接口
#pragma mark 1.1 获取潜在消费者客户列表
- (void)qianZaiXiaoFeiZheLieBiaoWithWithProducerId:(NSString *)producerId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Producer/%@/MatchUser/List/",producerId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}

#pragma mark 1.2 向匹配客户发出邀请
- (void)piPeiKeHuFaChuYaoQingWithProducerId:(NSString *)producerId consumerId:(NSString *)consumerId  message:(NSString *)message complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    NSDictionary * dict = @{@"Message":message};
    [self POSTrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Producer/%@/MatchUser/%@",producerId,consumerId] para:dict complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}

#pragma mark 1.3 获取匹配邀请消息列表
- (void)piPeiYaoQingXiaoXiLieBiaoWithProducerId:(NSString *)producerId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Producer/%@/MatchUser/Request",producerId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}

#pragma mark 1.6 农场主创建二维码
- (void)chuangJian2WeiMaWithProducerId:(NSString *)producerId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self POSTrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Producer/QRCode/%@",producerId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}

#pragma mark 1.7 农场主查询二维码
- (void)chaXun2WeiMaWithProducerId:(NSString *)producerId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Producer/QRCode/%@",producerId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}

#pragma mark 1.8 农场主删除二维码
- (void)shanChu2WeiMaWithProducerId:(NSString *)producerId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self DELETErequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Producer/QRCode/%@",producerId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];

}
#pragma mark 2.9 消费者创建二维码
- (void)chuangJian2WeiMaWithConsumerId:(NSString *)consumerId complete:(SuccessBlock)finish fail:(FailureBlock)failure {

    [self POSTrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Consumer/QRCode/%@",consumerId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];

}

#pragma mark 2.10 消费者查询二维码
- (void)chaXun2WeiMaWithConsumerId:(NSString *)consumerId complete:(SuccessBlock)finish fail:(FailureBlock)failure {

    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Consumer/QRCode/%@",consumerId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}

#pragma mark 2.11 消费者删除二维码
- (void)shanChu2WeiMaWithConsumerId:(NSString *)consumerId complete:(SuccessBlock)finish fail:(FailureBlock)failure {

    [self DELETErequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Consumer/QRCode/%@",consumerId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
    
    
}
#pragma mark 1.10 提交实名认证请求
- (void)tiJiaoShiMingRenZhengQingQiuWithProducerId:(NSString *)producerId title:(NSString *)title pic:(UIImage *)pic  complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    NSData *data1 = [self resetSizeOfImageData:[[ImageTool shareTool]resizeImageToSize:CGSizeMake(150, 150) sizeOfImage:pic] maxSize:150];
    NSData *data2 = [self resetSizeOfImageData:[[ImageTool shareTool]resizeImageToSize:CGSizeMake(150, 150) sizeOfImage:pic] maxSize:150];
    NSString *encodedImageStr1 = [data1 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *encodedImageStr2 = [data2 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSDictionary * dict = @{@"Title": title, @"BigPicture":encodedImageStr1, @"SmallPicture":encodedImageStr2};
    NSArray *array = [NSArray arrayWithObject:dict];
    NSDictionary *para = @{@"Count":@"1", @"List":array};
    [self POSTrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Producer/Auth/%@",producerId] para:para complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}

#pragma mark 1.11 查询实名认证请求状态
- (void)chaXunShiMimgRenZhengWith:(NSString *)producerId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Producer/Auth/%@",producerId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];

}

#pragma mark 1.12 新建物流模板
- (void)wuLiuBanKuaiWithDic:(NSDictionary *)dic complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self POSTrequestWitUrlString:@"http://182.92.224.165/Producer/Logistics" para:dic complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];

}

#pragma mark 1.13 更新物流板块
- (void)gengXinWuLiuBanKuaiLogisticsId:(NSString *)logisticsId name:(NSString *)Name type:(NSString *)Type address:(NSString *)Address telephone:(NSString *)Telephone discount:(NSString *)Discount description:(NSString *)Description complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    NSDictionary *dict = @{@"Name":Name,@"Type":Type,@"Address":Address,@"Telephone":Telephone,@"Discount":Discount,@"Description":Description};
    [self PUTrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Producer/Logistics/%@",logisticsId] para:dict complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];

    
}

#pragma mark 1.14 删除物流板块
- (void)shanChuWuLiuBanKuaiLogisticsId:(NSString *)logisticsId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self DELETErequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Producer/Logistics/%@",logisticsId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];

    
}

#pragma mark 1.15 查询单个物流模板信息
- (void)GETChaXunDanGeWuLiuMoBanXinXiWithLogisticsId:(NSString *)logisticsId complete:(SuccessBlock)finish fail:(FailureBlock)failure {

    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Producer/Logistics/%@",logisticsId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];

}

#pragma mark 1.16 查询所有物流模板
- (void)GETChaXunAllWuLiuMoBanXinXiWithProducerId:(NSString *)producerId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Producer/%@/LogisticsList",producerId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
    
}

#pragma mark 1.17 获取农场主已发布商品列表
- (void)HuoQuProducerYiFaBuShangPinListWithProducerId:(NSString *)producerId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Producer/%@/ProductList",producerId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
    
}

#pragma mark 2消费者
#pragma mark 2.1 获取潜在客户列表
- (void)huoQuQianZaiYongHuListConsumerId:(NSString *)consumerId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Consumer/%@/MatchList/",consumerId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}

#pragma mark 2.2 向匹配客户发出邀请
- (void)xiangPiPeiKeHuFaChuYaoQingWithProducerId:(NSString *)producerId consumerId:(NSString *)consumerId message:(NSString *)message complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    NSDictionary * dict = @{@"Message":message};
    [self POSTrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165https://<endpoint>/Consumer/%@/MatchUser/%@",consumerId,producerId] para:dict complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}

#pragma mark 2.3 获取匹配邀请消息列表
- (void)huoQuPiPeiYaoQingXiaoXiLieBiaoWithConsumerId:(NSString *)consumerId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Consumer/%@/MatchUser/Request",consumerId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
    
}


#pragma mark 2.6 新增求购信息
- (void)xinZengQiuGouXinXiWithConsumerId:(NSString *)consumerId dic:(NSDictionary *)dic complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self POSTrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Consumer/%@/Purchase",consumerId]
                             para:dic
                         complete:^(NSDictionary *responseObject) {
                             finish(responseObject);
                         }
                             fail:^(NSError *error, NSString *errorString) {
                                 failure(error, errorString);
                             }];
}

#pragma mark 2.7 消费者修改求购商品信息
- (void)XiuGaiQiuGouXinXiWithPurchaseId:(NSString *)purchaseId ProductType:(NSString *)ProductType Count:(NSString *)Count Price:(NSString *)Price Description:(NSString *)Description complete:(SuccessBlock)finish fail:(FailureBlock)failure {

    NSDictionary *dict = @{@"ProductType":ProductType,@"Count":Count,@"Price":Price};
    [self PUTrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Consumer/Purchase/%@",purchaseId] para:dict complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];



}

#pragma mark 2.8 消费者删除求购商品信息
- (void)ShanChuQiuGouShangPinXinXiWithPurchaseId:(NSString *)purchaseId complete:(SuccessBlock)finish fail:(FailureBlock)failure {

    [self DELETErequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Consumer/Purchase/%@",purchaseId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}


#pragma mark 2.9 消费者查询求购商品信息详情
- (void)ChaXunQiuGouShangPinXinXiXiangQingWithPurchaseId:(NSString *)purchaseId complete:(SuccessBlock)finish fail:(FailureBlock)failure {

    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Consumer/Purchase/%@",purchaseId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
    
}

#pragma mark 2.10 消费者获取求购商品信息列表
- (void)HuoQuQiuGouShangPinXinXiListWithConsumerId:(NSString *)consumerId complete:(SuccessBlock)finish fail:(FailureBlock)failure {

    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Consumer/%@/PurchaseList",consumerId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];

    
}




#pragma mark --3.1 商品下架 (删除)
- (void)deleteProducerShangPinXiaJiaWithProducerId:(NSString *)ProducerId ProductId:(NSString *)ProductId Complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self DELETErequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Product/%@/%@",ProducerId,ProductId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
    
}

#pragma mark -3.2 查询下架商品列表
- (void)GetProducerXiaJiaShangPinListWithProducerId:(NSString *)ProducerId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Product/%@/OfflineList",ProducerId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}


#pragma mark 4.1 新增优惠券
- (void)XinZengYouHuiQuanPOSTWithProducerId:(NSString *)ProducerId Name:(NSString *)Name Amount:(NSString *)Amount MiniCharge:(NSString *)MiniCharge StartTime:(NSString *)StartTime ExpirationTime:(NSString *)ExpirationTime complete:(SuccessBlock)finish fail:(FailureBlock)failure {

    NSDictionary *dict = @{@"Name":Name,@"Amount":Amount,@"MiniCharge":MiniCharge,@"ExpirationTime":ExpirationTime,@"StartTime":StartTime};
    [self POSTrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Coupons/%@",ProducerId] para:dict complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
    
}

#pragma mark 4.2 查询优惠券—总数
- (void)ChaXunYouHuiQuanZongShuWithProductId:(NSString *)ProductId complete:(SuccessBlock)finish fail:(FailureBlock)failure {

    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Coupons/Count/%@",ProductId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}

#pragma mark 4.3 查询优惠券信息
- (void)ChaXunYouHuiQuanXinXiWithCouponsId:(NSString *)CouponsId complete:(SuccessBlock)finish fail:(FailureBlock)failure {

    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Coupons/%@",CouponsId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
    
}

#pragma mark 4.4 查询农场主所发放的的全部优惠券
- (void)ChaXunProducerFaFangShangPinAllYouHuiQuanWithProducerId:(NSString *)ProducerId OffSet:(NSString *)offerset limit:(NSString *)limit complete:(SuccessBlock)finish fail:(FailureBlock)failure {

    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Coupons/CouponsList/Producer/%@?offset=%@&limit=%@", ProducerId, offerset, limit] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];


}

#pragma mark 4.5 修改优惠券
- (void)XiuGaiYouHuiQuanWithCouponsId:(NSString *)CouponsId Name:(NSString *)Name Amount:(NSString *)Amount ExpirationTime:(NSString *)ExpirationTime complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    NSDictionary *dict = @{@"Name":Name,@"Amount":Amount,@"ExpirationTime":ExpirationTime};
    [self PUTrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Coupons/%@",CouponsId] para:dict complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
    
    
    
}

#pragma mark 4.6 删除优惠券
- (void)ShanChuYouHuiQuanWithCouponsId:(NSString *)CouponsId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self DELETErequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Coupons/%@",CouponsId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}


#pragma mark 5.1 新增卖家普通单个红包
- (void)XinZengPuTongDanGeHongBaoPOSTWithProducerId:(NSString *)ProducerId Count:(NSString *)Count Amount:(NSString *)Amount Message:(NSString *)Message complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    NSDictionary *dict = @{@"Count":Count,@"Amount":Amount, @"Message":Message};
    [self POSTrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/RedEnvelope/Producer/%@",ProducerId] para:dict complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
    
}

#pragma mark 5.2 发放卖家普通单个红包给买家
- (void)FaFangPuTongDanGeHongBaoGeiMaiJia3POSTWithRedEnvelopeId:(NSString *)RedEnvelopeId ConsumerId:(NSString *)ConsumerId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self POSTrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/RedEnvelope/%@/Consumer/%@", RedEnvelopeId, ConsumerId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
    
}


#pragma mark 5.3 发放卖家普通单个红包给卖家
- (void)FaFangPuTongDanGeHongBaoGeiMaiJia4POSTWithRedEnvelopeId:(NSString *)RedEnvelopeId ProducerId:(NSString *)ProducerId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self POSTrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/RedEnvelope/%@/Producer/%@", RedEnvelopeId, ProducerId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
    
}

#pragma mark 5.4 买家收取普通单个红包
- (void)MaiJia3ShouQuPuTongDanGeHongBaoPUTWithRedEnvelopeId:(NSString *)RedEnvelopeId complete:(SuccessBlock)finish fail:(FailureBlock)failure {

    [self PUTrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/RedEnvelope/%@/Consumer",RedEnvelopeId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
    
}

#pragma mark 5.5 查询买家普通红包列表
- (void)ChaXunMaiJia3PuTongHongBaoListWithConsumerId:(NSString *)ConsumerId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/RedEnvelope/Consumer/%@",ConsumerId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
    
}

#pragma mark 5.6 卖家收取普通单个红包
- (void)MaiJia4ShouQuPuTongDanGeHongBaoPUTWithRedEnvelopeId:(NSString *)RedEnvelopeId complete:(SuccessBlock)finish fail:(FailureBlock)failure {

    [self PUTrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/RedEnvelope/%@/Producer",RedEnvelopeId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];


}

#pragma mark 5.7 查询卖家普通红包列表
- (void)ChaXunMaiJia4PuTongHongBaoListWithProducerId:(NSString *)ProducerId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/RedEnvelope/Producer/%@",ProducerId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
    
}


#pragma mark 5.8 删除红包
- (void)ShanChuHongBaoWithRedEnvelopeId:(NSString *)RedEnvelopeId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self DELETErequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/RedEnvelope/%@",RedEnvelopeId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}

#pragma mark 6.5 新增卖家关注买家
- (void)xingzengmaijiaguanzhumaijiProducerId:(NSString *)ProducerId  WithConsumerID:(NSString *)consumerID complete:(SuccessBlock)finish fail:(FailureBlock)failure
{
    [self POSTrequestWitUrlString:@"http://182.92.224.165/Follow/Producer/Consumer" para:@{@"ProducerId":ProducerId, @"ConsumerId":consumerID} complete:^(NSDictionary *responseObject) {
        finish(responseObject);
        
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}
#pragma mark 6.8 查询卖家关注的所有买家列表

- (void)chaXun68ProducerId:(NSString *)ProducerId complete:(SuccessBlock)finish fail:(FailureBlock)failure{
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Follow/Producer/Consumer/%@", ProducerId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}

#pragma mark 6.1 新增卖家关注卖家
- (void)XinZengMaiJia4GuanZhuMaiJia4WithProducerId:(NSString *)ProducerId FollowProducerId:(NSString *)FollowProducerId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    NSDictionary *dict = @{@"ProducerId":ProducerId,@"FollowProducerId":FollowProducerId};
    [self POSTrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Follow/Producer/Producer"] para:dict complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
    
}

#pragma mark 6.2 卖家取消关注卖家
- (void)MaiJia4QuXiaoGuanZhuMaiJia4WithProducerId:(NSString *)ProducerId FollowProducerId:(NSString *)FollowProducerId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self DELETErequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Follow/Producer/%@/Producer/%@",ProducerId, FollowProducerId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}

#pragma mark 6.3 查询卖家是否关注卖家
- (void)ChaXunMaiJia4ShiFouGuanZhuMaiJia4WithProducerId:(NSString *)ProducerId FollowProducerId:(NSString *)FollowProducerId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Follow/Producer/%@/Producer/%@",ProducerId, FollowProducerId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
    
}

#pragma mark 6.4 查询卖家关注的所有卖家列表
- (void)ChaXunMaiJia4GuanZhuAllMaiJia4ListWithProducerId:(NSString *)ProducerId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Follow/Producer/Producer/%@", ProducerId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
    
}
#pragma mark 6.9 查询卖家的关注和粉丝总数
- (void)ChaXunMaiJia4GuanZhuAndFenSiZongShuWithProducerId:(NSString *)ProducerId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Follow/Count/Producer/%@", ProducerId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
    
}

#pragma mark 7.1 新增买家关注卖家
- (void)XinZengMaiJia3GuanZhuMaiJia4WithConsumerId:(NSString *)ConsumerId ProducerId:(NSString *)ProducerId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    NSDictionary *dict = @{@"ConsumerId":ConsumerId,@"ProducerId":ProducerId};
    [self POSTrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Follow/Consumer/Producer"] para:dict complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
    
}

#pragma mark 7.2 买家取消关注卖家
- (void)MaiJia3QuXiaoGuanZhuMaiJia4WithConsumerId:(NSString *)ConsumerId ProducerId:(NSString *)ProducerId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self DELETErequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Follow/Consumer/%@/Producer/%@",ConsumerId, ProducerId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}

#pragma mark 7.3 查询买家是否关注卖家
- (void)ChaXunMaiJia3ShiFouGuanZhuMaiJia4WithConsumerId:(NSString *)ConsumerId ProducerId:(NSString *)ProducerId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Follow/Consumer/%@/Producer/%@",ConsumerId, ProducerId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
    
}

#pragma mark 7.4 查询买家关注的所有卖家列表
- (void)ChaXunMaiJia3GuanZhuAllMaiJia4ListWithConsumerId:(NSString *)ConsumerId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Follow/Consumer/Producer/%@", ConsumerId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
    
}

#pragma mark 7.5 新增买家关注买家
- (void)XinZengMaiJia3GuanZhuMaiJia3WithConsumerId:(NSString *)ConsumerId FollowConsumerId:(NSString *)FollowConsumerId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    NSDictionary *dict = @{@"ConsumerId":ConsumerId,@"FollowConsumerId":FollowConsumerId};
    [self POSTrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Follow/Consumer/Consumer"] para:dict complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
    
}

#pragma mark 7.6 买家取消关注买家
- (void)MaiJia3QuXiaoGuanZhuMaiJia3WithConsumerId:(NSString *)ConsumerId FollowConsumerId:(NSString *)FollowConsumerId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self DELETErequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Follow/Consumer/%@/FollowConsumerId/%@",ConsumerId, FollowConsumerId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}

#pragma mark 7.7 查询买家是否关注买家
- (void)ChaXunMaiJia3ShiFouGuanZhuMaiJia3WithConsumerId:(NSString *)ConsumerId FollowConsumerId:(NSString *)FollowConsumerId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Follow/Consumer/%@/FollowConsumerId/%@",ConsumerId, FollowConsumerId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
    
}

#pragma mark 7.8 查询买家关注的所有买家列表
- (void)ChaXunMaiJia3GuanZhuAllMaiJia3ListWithConsumerId:(NSString *)ConsumerId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Follow/Consumer/Consumer/%@", ConsumerId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
    
}
#pragma mark 7.9 查询买家的关注和粉丝总数
- (void)ChaXunMaiJia3GuanZhuAndFenSiZongShuWithConsumerId:(NSString *)ConsumerId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Follow/Count/Consumer/%@", ConsumerId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];

}
#pragma mark 8.1 卖家给卖家发送聊天消息
- (void)MaiJia4GeiMaiJia4FaSongLiaoTianXiaoXiWithProducerId:(NSString *)ProducerId ChatProducerId:(NSString *)ChatProducerId BaseMassage:(NSDictionary *)dictMessage complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self POSTrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Chat/Producer/%@/Producer/%@",ProducerId, ChatProducerId] para:dictMessage complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
    
}

#pragma mark 8.2 卖家获取卖家聊天消息
- (void)MaiJia4GHuoQuMaiJia4LiaoTianXiaoXiWithProducerId:(NSString *)ProducerId ChatProducerId:(NSString *)ChatProducerId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Chat/Producer/%@/Producer/%@", ProducerId,ChatProducerId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
    
}

#pragma mark 8.3 卖家给买家发送聊天消息
- (void)MaiJia4GeiMaiJia3FaSongLiaoTianXiaoXiWithProducerId:(NSString *)ProducerId ConsumerId:(NSString *)ConsumerId BaseMassage:(NSDictionary *)dictMessage complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self POSTrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Chat/Producer/%@/Consumer/%@",ProducerId, ConsumerId] para:dictMessage complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
    
}

#pragma mark 8.4 卖家获取买家聊天消息
- (void)MaiJia4GHuoQuMaiJia3LiaoTianXiaoXiWithProducerId:(NSString *)ProducerId ConsumerId:(NSString *)ConsumerId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Chat/Producer/%@/Consumer/%@", ProducerId,ConsumerId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
}

#pragma mark 8.5 买家给卖家发送聊天消息
- (void)MaiJia3GeiMaiJia4FaSongLiaoTianXiaoXiWithConsumerId:(NSString *)ConsumerId ProducerId:(NSString *)ProducerId BaseMassage:(NSDictionary *)dictMessage complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self POSTrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Chat/Consumer/%@/Producer/%@",ConsumerId, ProducerId] para:dictMessage complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
    
}

#pragma mark 8.6 买家获取卖家聊天消息
- (void)MaiJia3GHuoQuMaiJia4LiaoTianXiaoXiWithConsumerId:(NSString *)ConsumerId ProducerId:(NSString *)ProducerId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Chat/Consumer/%@/Producer/%@", ConsumerId,ProducerId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
    
}

#pragma mark 8.7 买家给买家发送聊天消息
- (void)MaiJia3GeiMaiJia3FaSongLiaoTianXiaoXiWithConsumerId:(NSString *)ConsumerId ChatConsumerId:(NSString *)ChatConsumerId BaseMassage:(NSDictionary *)dictMessage complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self POSTrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Chat/Consumer/%@/Consumer/%@",ConsumerId, ChatConsumerId] para:dictMessage complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
    
}

#pragma mark 8.8 买家获取买家聊天消息
- (void)MaiJia3GHuoQuMaiJia3LiaoTianXiaoXiWithConsumerId:(NSString *)ConsumerId ChatConsumerId:(NSString *)ChatConsumerId complete:(SuccessBlock)finish fail:(FailureBlock)failure {
    
    [self GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Chat/Consumer/%@/Consumer/%@", ConsumerId,ChatConsumerId] para:nil complete:^(NSDictionary *responseObject) {
        finish(responseObject);
    } fail:^(NSError *error, NSString *errorString) {
        failure(error, errorString);
    }];
    
}




#pragma mark- 接口辅助方法
//调整图片的大小以及分辨率
- (NSData *)resetSizeOfImageData:(UIImage *)source_image maxSize:(NSInteger)maxSize {
    //先调整分辨率
    
    CGSize newSize = CGSizeMake(source_image.size.width, source_image.size.height);
    
    CGFloat tempHeight = newSize.height / 1024;
    CGFloat tempWidth = newSize.width / 1024;
    
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(source_image.size.width / tempWidth, source_image.size.height / tempWidth);
    }
    else if (tempHeight > 1.0 && tempWidth < tempHeight){
        newSize = CGSizeMake(source_image.size.width / tempHeight, source_image.size.height / tempHeight);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [source_image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //调整大小
    NSData *imageData = UIImageJPEGRepresentation(newImage,1.0);
    NSUInteger sizeOrigin = [imageData length];
    NSUInteger sizeOriginKB = sizeOrigin / 1024;
    if (sizeOriginKB > maxSize) {
        NSData *finallImageData = UIImageJPEGRepresentation(newImage,0.10);
        return finallImageData;
    }
    
    return imageData;
}

-(NSString *)JSONString:(NSString *)aString {
    
    NSMutableString *s = [NSMutableString stringWithString:aString];
    [s replaceOccurrencesOfString:@"\"" withString:@"\\\"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"/" withString:@"\\/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\n" withString:@"\\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\b" withString:@"\\b" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\f" withString:@"\\f" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\r" withString:@"\\r" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\t" withString:@"\\t" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    return [NSString stringWithString:s];
}

- (NSString*)dictionaryToJson:(NSDictionary *)dic {
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        return nil;
        
    }
    
    return dic;
    
}


@end
