//
//  JQBaseRequest.h
//  csNet
//
//  Created by 王朝源 on 15/12/1.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//定义了接收数据的block
typedef void(^SuccessBlock)(NSDictionary * responseObject);

//失败时调用的block
typedef void(^FailureBlock)(NSError * error, NSString * errorString);
@interface JQBaseRequest : NSObject


//post请求
-(void) POSTrequestWitUrlString:(NSString *)urlString para:(NSDictionary *)dict complete:(SuccessBlock)finish fail:(FailureBlock)failure;

//put请求
-(void) PUTrequestWitUrlString:(NSString *)urlString para:(NSDictionary *)dict complete:(SuccessBlock)finish fail:(FailureBlock)failure;

//get请求
-(void) GETrequestWitUrlString:(NSString *)urlString para:(NSString *)str complete:(SuccessBlock)finish fail:(FailureBlock)failure;

//delete请求
-(void) DELETErequestWitUrlString:(NSString *)urlString para:(NSString *)str complete:(SuccessBlock)finish fail:(FailureBlock)failure;








#pragma mark -6.1 新增订单
- (void)PostProductOrderWithConsumerId:(NSString *)ConsumerId ProductId:(NSString *)ProductId Count:(NSString *)Count Unit:(NSString *)Unit Description:(NSString *)Description ConsigneeId:(NSString *)ConsigneeId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark -7.2 查询农场主商品收藏列表
//http://182.92.224.165/Favorite/Producer/139/Product/?offset=0&limit=15&desc=false
//http://182.92.224.165/Favorite/Producer/139
- (void)GetProducerShouCangProductWithProducerId:(NSString *)ProducerId OffSet:(NSString *)offerset limit:(NSString *)limit complete:(SuccessBlock)finish fail:(FailureBlock)failure;
#pragma mark -7.5 查询消费者商品收藏列表
//http://182.92.224.165/Favorite/Producer/139/Product/?offset=0&limit=15&desc=false
//http://182.92.224.165/Favorite/Producer/139
- (void)GetConsumerShouCangProductWithConsumerId:(NSString *)ConsumerId OffSet:(NSString *)offerset limit:(NSString *)limit complete:(SuccessBlock)finish fail:(FailureBlock)failure;
#pragma mark -7.3 农场主商品收藏总数查询
- (void)ProducerShouCangTotalProductWithProducerId:(NSString *)ProducerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;
#pragma mark -7.6 消费者商品收藏总数查询
- (void)ConsumerShouCangTotalProductWithConsumerId:(NSString *)ConsumerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;
#pragma mark -7.4 消费者新增商品收藏
- (void)ConsumerShouCangProductWithConsumerId:(NSString *)ConsumerId ProductId:(NSString *)ProductId complete:(SuccessBlock)finish fail:(FailureBlock)failure;
#pragma mark -5.1 新增商品论评
- (void)PostProductCommentWithConsumerId:(NSString *)ConsumerId ProductId:(NSString *)ProductId Comment:(NSString *)Comment complete:(SuccessBlock)finish fail:(FailureBlock)failure;
#pragma mark -5.3 查询商品评论—列表ID
- (void)GetProductCommentWithProductId:(NSString *)ProductId OffSet:(NSString *)offerset limit:(NSString *)limit complete:(SuccessBlock)finish fail:(FailureBlock)failure;
#pragma mark --4.1 商品发布—基本信息文字信息(商品发布的接口)
- (void)ShangPinFaBuByPostRequestWithName:(NSString *)name Description:(NSString *)description Type:(NSString *)type Price:(NSString *)price OriginalPrice:(NSString *)OriginalPrice Unit:(NSString *)unit Freight:(NSString *)Freight ProducerId:(NSString *)ProducerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;
#pragma mark --4.5 商品发布/修改—图片
//图片描述Description和图片idImageId
- (void)ShangPinFaBUImageByPutRequestWithProductId:(NSString *)ProductId Count:(NSInteger)count List:(NSArray *)list complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark -- 农场主注册—基本信息(post) https://<endpoint>/Producer/BasicInfo/
- (void) FarmOwnerRegisterBaseMassage:(NSDictionary *)dictMessage complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark -- 农场主修改—基本信息(put)  https://<endpoint>/Producer/BasicInfo/[ProducerId]
- (void)FarmerOwnerAlertBaseMessageWithProducerID:(NSString *)producerID dictMessage:(NSDictionary *)dictMessage complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark --  农场主查询—基本信息 (get) https://<endpoint>/Producer/BasicInfo/[ProducerId]
- (void)FarmerOwnerSelectedBaseMessageWithProducerID:(NSString *)producerID complete:(SuccessBlock)finish fail:(FailureBlock)failure;
#pragma mark -7.1 农场主新增商品收藏
- (void)ProducerShouCangProductWithProducerId:(NSString *)ProducerId ProductId:(NSString *)ProductId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark --  农场主注册/修改—头像 (put)  https://<endpoint>/Producer/Portrait/[ProducerId]
- (void)FarmerOwnerRegisterOrAlertHeaderImageWithProducerID:(NSString *)producerID dictMessage:(NSDictionary *)dictMessage complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark -- 农场主查询—头像(get)  https://<endpoint>/Producer/Portrait/[ProducerId]
- (void)FarmerOwnerSelectedHeaderImageWithProducerID:(NSString *)producerID complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark --农场主注册/修改—扩展信息(put)  https://<endpoint>/Producer/RichInfo/[ProducerId]
- (void)FarmerOwnerRegisterOrAlertExtensionMessageWithProducerID:(NSString *)producerID dictMessage:(NSDictionary *)dictMessage complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark -- 2.7农场主查询—扩展信息(get)  https://<endpoint>/Producer/RichInfo/[ProducerId]
- (void)FarmerOwnerSelectedExtensiobMessageWithProducerID:(NSString *)producerID complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark -- 2.8 农场主注册/修改—认证证书(put) https://<endpoint>/Producer/Certificate/[ProducerId]
- (void)FarmerOwnerRegisterOrAlertConfirmBookWithProducerID:(NSString *)ProducerID dictMessage:(NSDictionary *)dictMessage complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark --农场主查询—认证证书(get)https://<endpoint>/Producer/Certificate/[ProducerId]
- (void)FarmerSelectedConfirmBookWithProducerID:(NSString *)ProducerID complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark --删除证书（delete） https://<endpoint>/Producer/Certificate/[CertificateId]
- (void)FarmerOwnerDeleteConfirmBookWithCertificationID:(NSString *)certificateId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark  --- 验证农场主注册手机号是否存在(get) https://<endpoint>/Producer/LoginNameCheck/[LoginName]
- (void)ConfirmFarmerOwnerPhoneNumberWithLoginName:(NSString *)loginName omplete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark  --- 农场主修改密码(put) https://<endpoint>/Producer/Password/[ProducerId]
- (void)FarmerOwnerAlertPassWordWithProducerId:(NSString *)producerId OldPassword:(NSString *)oldPassword NewPassword:(NSString *)newPassword complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark  ---发送短信验证码(post) https://<endpoint>/Producer/SmsCode/
- (void)senderTextMessageWithTelephonNumber:(NSString *)telephoneNumber complete:(SuccessBlock)finish fail:(FailureBlock)failure;
/* {
id = 44;
smsCode = 9261;
telephone = 18317896026;
}  发送短信验证码 之后服务器给你返回的数据需要用到验证验证码的时候的url中
 */

#pragma mark  ---验证短信码 (get) https://<endpoint>/Producer/SmsCode/[SmsCodeId]/[UserSmsCode]/[Telephone]
- (void)confirmTextMessageWithSmsCodeId:(NSString *)smsCodeId UserSmsCode:(NSString *)userSmsCode TelephoneNumber:(NSString *)telephoneNumber complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark --农场主登录(get)  https://<endpoint>/Producer/LoginName/[LoginName]/SessionKey/[SessionKey]
- (void)FarmerOwnerLoginWithLoginName:(NSString *)loginName  SessionKey:(NSString *)sessionKey complete:(SuccessBlock)finish fail:(FailureBlock)failure;
/*
 ************************************************************
 ************************消费者*********************************
 ************************************************************
 */
#pragma mark --消费者注册—基本信息(post)  https://<endpoint>/Consumer/BasicInfo/
- (void)ConsumerRegisterBaseMessageWithMessageDict:(NSDictionary *)dictMessage complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark --消费者修改—基本信息(put) https://<endpoint>/Consumer/BasicInfo/[ConsumerId]
- (void)ConsumerAlertBaseMessageWithConsumerID:(NSString *)consumerID ConsumerDictMessage:(NSDictionary *)dictMessage complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark --消费者查询—基本信息(get) https://<endpoint>/Consumer/BasicInfo/[ConsumerId]
- (void)ConsumerSelectedBaseMessageWithConsumerID:(NSString *)consumerID complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark --消费者注册/修改—头像(put) https://<endpoint>/Consumer/Portrait/[ConsumerId]
- (void)ConsumerRegisterOrAlertHeaderImageWithConsumerID:(NSString *)consumerID ConsumerDictMessage:(NSDictionary *)dictMessage complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark -- 消费者查询—头像(get) https://<endpoint>/Consumer/Portrait/[ConsumerId]
- (void)ConsumerSelectedHeaderImageWithConsumerID:(NSString *)consumerID complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark --消费者注册/修改—扩展信息 (put) https://<endpoint>/Consumer/RichInfo/[ConsumerId]
- (void)ConsumerRegisterOrAlertExtensionMessageWithConsumerId:(NSString *)consurmerId  ConsumerDictMessage:(NSDictionary *)dictMessage complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark --消费者查询—扩展信息(get) https://<endpoint>/Consumer/RichInfo/[ConsumerId]
- (void)ConsumerSelecterExtensionMessageWithConsumerID:(NSString *)ConsumerID complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark --3.8 消费者登录(get) https://<endpoint>/Consumer/LoginName/[LoginName]/SessionKey/[SessionKey]

- (void)ConsumerLoginWithLoginName:(NSString *)loginName SessionKey:(NSString *)sessionkey complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark  ---验证消费者注册手机号是否存在(get) https://<endpoint>/Consumer/LoginNameCheck/[LoginName]
- (void)ConfirmConsumerOwnerPhoneNumberWithLoginName:(NSString *)loginName omplete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark  --消费者修改密码(put)  https://<endpoint>/Consumer/Password/[ConsumerId]
- (void)ConsumerAlertPassWordWithConsumerId:(NSString *)consumerId OldPassword:(NSString *)oldPassword NewPassword:(NSString *)newPassword complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark   ---发送短信验证码(post)  https://<endpoint>/Consumer/SmsCode/
- (void)senderTextMessageWithTelephonNumberOfConsumer:(NSString *)telephoneNumber complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark  ---验证短信码 (get) https://<endpoint>/Consumer/SmsCode/[SmsCodeId]/[UserSmsCode]/[Telephone]
- (void)confirmTextMessageOfConsumerWithSmsCodeId:(NSString *)smsCodeId UserSmsCode:(NSString *)userSmsCode TelephoneNumber:(NSString *)telephoneNumber complete:(SuccessBlock)finish fail:(FailureBlock)failure;

/*
 ************************************************************
 ************************商品*********************************
 ************************************************************
 */
#pragma mark  商品发布－基本信息(post) https://<endpoint>/Product/BasicInfo/
- (void)GoodsIsureBaseMessageWithGoodsName:(NSString *)Name
               GoodsDescription:(NSString *)description
                      GoodsType:(NSString *)type
                     GoodsPrice:(NSString *)price
             GoodsOriginalPrice:(NSString *)originalPrice
                      GoodsUnit:(NSString *)unit
                        Freight:(NSString *)freight
                     ProducerId:(NSString *)producerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark  商品修改—基本信息(put) https://<endpoint>/Product/BasicInfo/[ProductId]
- (void)GoodsAlertBaseMessageWithProductId:(NSString *)productId
                                 GoodsName:(NSString *)Name
                          GoodsDescription:(NSString *)description
                                 GoodsType:(NSString *)type
                                GoodsPrice:(NSString *)price
                        GoodsOriginalPrice:(NSString *)originalPrice
                                 GoodsUnit:(NSString *)unit
                                   Freight:(NSString *)freight complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark  --4.3 商品查询—基本信息(get)  https://<endpoint>/Product/BasicInfo/[ProductId]
- (void)GoodsSelectedBaseMessageWithProductId:(NSString *)productId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark  -- 4.4 商品列表查询—基本信息(get)  https://<endpoint>/Product/BasicInfo/List/?UserId=&UserType=C/P&Province=&City=&Address=&ProductType=&ProductName=&ProductDesc=&offset=0&limit=15&desc=true
- (void)GoodsListSelectedBaseMessageWithUserID:(NSString *)UserId IsFarmer:(BOOL)isFarmer OffSet:(NSString *)offerset limit:(NSString *)limit complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark --4.5 商品发布/修改—图片(put)  https://<endpoint>/Product/Images/[ProductId]
- (void)GoodsIsureOrAlertImageWithProductId:(NSString *)productId MessageDict:(NSDictionary *)messageDict complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark -4.6 商品查询—单张图片 (get) https://<endpoint>/Product/Image/[ProductId]
- (void)GoodsSelectedOneImageWithProductId:(NSString *)productId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark --4.7 商品查询—所有图片 (get) https://<endpoint>/Product/Images/[ProductId]
- (void)GoodsSelectedAllImageWithProductId:(NSString *)productId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark  --4.8 商品查询—热门搜索词(get) https://<endpoint>/Product/HotSearchWord/?limit=10
- (void)GoodsSelectedHotSearchWordsWithLimit:(NSString *)limit complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark ---5.1 新增商品论评(post) https://<endpoint>/ProductComment/
- (void)AddGoodsCommentWithProductId:(NSString *)productId Comment:(NSString *)comment ConsumerId:(NSString *)consumerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark  --5.2查询商品评论—总数(get)  https://<endpoint>/ProductComment/Count/[ProductId]
- (void)SelectedGoodsCommentTotalWithProductID:(NSString *)productId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark  --5.3 查询商品评论—列表ID (get) https://<endpoint>/ProductComment/List/[ProductId] /?offset=0&limit=15
- (void)SelectedGoodsCommentListIdWithProductId:(NSString *)productId Offset:(NSString *)offset Limit:(NSString *)limit complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark --5.4 查询商品评论—详细信息(get) https://<endpoint>/ProductComment/[CommentId]
- (void)SelectedGoodsCommentDetailMessageWithCommentId:(NSString *)commentId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark -5.5 查询某个用户的全部商品评论(get) https://<endpoint>/ProductComment/UserCommentList/[ConsumerId]/?offset=0&limit=15
- (void)SelectedSomeBodyAllGoodsCommentsWithConsumerId:(NSString *)consumerId Offset:(NSString *)offset Limit:(NSString *)limit complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark -5.6 查询用户商品评论—总数(get)  https://<endpoint>/ProductComment/[ConsumerId]/Count/
- (void)SelectedConsumerGoodsCommentTotalWithConsumerId:(NSString *)consumerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark -5.7 删除商品评论(delete) https://<endpoint>/ProductComment/[CommendId]
- (void)DeleteGoodsCommentWithCommentId:(NSString *)commentId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark --10.1 查询省市区列表
- (void)getWeiZhiComplete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark --9.4 查询消费者的收货人列表 http://182.92.224.165/Order/Consignee/Consumer/29
- (void)getShouHuoDiZhiListConsumerId:(NSString *)ConsumerId Complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark --9.1 增加收货人
- (void)postShouHuoRenConsumerId:(NSString *)ConsumerId name:(NSString *)Name telephone:(NSString *)Telephone province:(NSString *)Province city:(NSString *)City district:(NSString *)District address:(NSString *)Address isDefault:(BOOL)IsDefault Complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark --9.2 修改收货人信息
- (void)putXiuGaiShouHuoRenConsigneeId:(NSString *)ConsigneeId name:(NSString *)Name telephone:(NSString *)Telephone province:(NSString *)Province city:(NSString *)City district:(NSString *)District address:(NSString *)Address isDefault:(BOOL)IsDefault Complete:(SuccessBlock)finish fail:(FailureBlock)failure;
#pragma mark --9.5 删除收货人
- (void)deleteShouHuoRenWithConsigneeId:(NSString *)ConsigneeId Complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark --7.9 删除农场主的商品收藏
- (void)deleteProducerShouCangProductWithFavoriteId:(NSString *)FavoriteId Complete:(SuccessBlock)finish fail:(FailureBlock)failure;
#pragma mark --7.10 删消费者的商品收藏
- (void)deleteConsumerShouCangProductWithFavoriteId:(NSString *)FavoriteId Complete:(SuccessBlock)finish fail:(FailureBlock)failure;
#pragma mark --7.11 删消费者的农场主收藏
- (void)deleteConsumerShouCangProducerWithFavoriteId:(NSString *)ConsumerId Complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark --4.8 商品查询—热门搜索词
- (void)getSouSuoReBangComplete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark --4.8 商品查询
- (void)SearchGoodsListWithUserID:(NSString *)UserId IsFarmer:(BOOL)isFarmer ProductName:(NSString *)ProductName ProductDesc:(NSString *)ProductDesc OffSet:(NSString *)offerset limit:(NSString *)limit complete:(SuccessBlock)finish fail:(FailureBlock)failure;
/*
 ************************************************************
 ************************订单*********************************
 ************************************************************
 */
#pragma mark  - 新增订单 (post) https://<endpoint>/Order/ConsumerId/[ConsumerId]/ProductId/[ProductId]
- (void)addOrderWithConsumerId:(NSString *)consumerId
                     ProductId:(NSString *)productId
                         Count:(NSString *)count
                          Unit:(NSString *)unit
                   Description:(NSString *)description
                   ConsigneeId:(NSString *)consigneeId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark -6.2 订单详情查询(get) https://<endpoint>/Order/[OrderId]
- (void)OrderDetailSelectWithOrderId:(NSString *)orderId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark -6.3 农场主订单列表查询(get) https://<endpoint>/Order/Producer/[ProducerId] /?status=0&offset=0&limit=15
- (void)FarmerOwnerOrderListSelectedWithProducerId:(NSString *)producerId Status:(NSString *)status Offset:(NSString *)offset limit:(NSString *)limit complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark   6.11 查询热门快递(get) https://<endpoint>/Order/HotExpress/?limit=10
- (void)selectedHotKuaiDiWithLimit:(NSString *)limit complete:(SuccessBlock)finish fail:(FailureBlock)failure;
#pragma mark  8.2 查询农场主的消费者联系人列表(get) https://<endpoint>/Contact/Producer/[ProducerId]/Consumer
- (void)selectedFarmerOwnerContactListWithProducerId:(NSString *)ProducerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark  8.8 查询消费者的农场主联系人列表(get) https://<endpoint>/Contact/Consumer/[ConsumerId]/Producer
- (void)ConsumerContactPeopleSelectedWithConsumerId:(NSString *)consumerID complete:(SuccessBlock)finish fail:(FailureBlock)failure;










#pragma mark v2接口
#pragma mark 1.1 获取潜在消费者客户列表(get)
- (void)qianZaiXiaoFeiZheLieBiaoWithWithProducerId:(NSString *)producerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 1.2 向匹配客户发出邀请
- (void)piPeiKeHuFaChuYaoQingWithProducerId:(NSString *)producerId consumerId:(NSString *)consumerId message:(NSString *)message complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 1.3 获取匹配邀请消息列表
- (void)piPeiYaoQingXiaoXiLieBiaoWithProducerId:(NSString *)producerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 1.6 农场主创建二维码
- (void)chuangJian2WeiMaWithProducerId:(NSString *)producerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 1.7 农场主查询二维码
- (void)chaXun2WeiMaWithProducerId:(NSString *)producerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 1.8 农场主删除二维码
- (void)shanChu2WeiMaWithProducerId:(NSString *)producerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;


#pragma mark 2.9 消费者创建二维码
- (void)chuangJian2WeiMaWithConsumerId:(NSString *)consumerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 2.10 消费者查询二维码
- (void)chaXun2WeiMaWithConsumerId:(NSString *)consumerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 2.11 消费者删除二维码
- (void)shanChu2WeiMaWithConsumerId:(NSString *)consumerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;


#pragma mark 1.10 提交实名认证请求
- (void)tiJiaoShiMingRenZhengQingQiuWithProducerId:(NSString *)producerId title:(NSString *)title pic:(UIImage *)pic  complete:(SuccessBlock)finish fail:(FailureBlock)failure;
#pragma mark 1.11 查询实名认证请求状态
- (void)chaXunShiMimgRenZhengWith:(NSString *)producerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 1.12 物流板块
- (void)wuLiuBanKuaiWithDic:(NSDictionary *)dic complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 1.13 更新物流板块
- (void)gengXinWuLiuBanKuaiLogisticsId:(NSString *)logisticsId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 1.14 删除物流板块
- (void)shanChuWuLiuBanKuaiLogisticsId:(NSString *)logisticsId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 1.15 查询单个物流模板信息
- (void)GETChaXunDanGeWuLiuMoBanXinXiWithLogisticsId:(NSString *)logisticsId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 1.16 查询所有物流模板
- (void)GETChaXunAllWuLiuMoBanXinXiWithProducerId:(NSString *)producerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 1.17 获取农场主已发布商品列表
- (void)HuoQuProducerYiFaBuShangPinListWithProducerId:(NSString *)producerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 2消费者
#pragma mark 2.1 获取潜在客户列表
- (void)huoQuQianZaiYongHuListConsumerId:(NSString *)consumerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 2.2 向匹配客户发出邀请
- (void)xiangPiPeiKeHuFaChuYaoQingWithProducerId:(NSString *)producerId consumerId:(NSString *)consumerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 2.3 获取匹配邀请消息列表
- (void)huoQuPiPeiYaoQingXiaoXiLieBiaoWithConsumerId:(NSString *)consumerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 2.6 新增求购信息
- (void)xinZengQiuGouXinXiWithConsumerId:(NSString *)consumerId dic:(NSDictionary *)dic complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 2.7 消费者修改求购商品信息
- (void)XiuGaiQiuGouXinXiWithPurchaseId:(NSString *)purchaseId ProductType:(NSString *)ProductType Count:(NSString *)Count Price:(NSString *)Price Description:(NSString *)Description complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 2.8 消费者删除求购商品信息
- (void)ShanChuQiuGouShangPinXinXiWithPurchaseId:(NSString *)purchaseId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 2.9 消费者查询求购商品信息详情
- (void)ChaXunQiuGouShangPinXinXiXiangQingWithPurchaseId:(NSString *)purchaseId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 2.10 消费者获取求购商品信息列表
- (void)HuoQuQiuGouShangPinXinXiListWithConsumerId:(NSString *)consumerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark --3.1 商品下架 (删除)
- (void)deleteProducerShangPinXiaJiaWithProducerId:(NSString *)ProducerId ProductId:(NSString *)ProductId Complete:(SuccessBlock)finish fail:(FailureBlock)failure;
#pragma mark -3.2 查询下架商品列表
- (void)GetProducerXiaJiaShangPinListWithProducerId:(NSString *)ProducerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 4.1 新增优惠券
- (void)XinZengYouHuiQuanPOSTWithProducerId:(NSString *)ProducerId Name:(NSString *)Name Amount:(NSString *)Amount MiniCharge:(NSString *)MiniCharge StartTime:(NSString *)StartTime ExpirationTime:(NSString *)ExpirationTime complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 4.2 查询优惠券—总数
- (void)ChaXunYouHuiQuanZongShuWithProductId:(NSString *)ProductId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 4.3 查询优惠券信息
- (void)ChaXunYouHuiQuanXinXiWithCouponsId:(NSString *)CouponsId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 4.4 查询农场主所发放的的全部优惠券
- (void)ChaXunProducerFaFangShangPinAllYouHuiQuanWithProducerId:(NSString *)ProducerId OffSet:(NSString *)offerset limit:(NSString *)limit complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 4.5 修改优惠券
- (void)XiuGaiYouHuiQuanWithCouponsId:(NSString *)CouponsId Name:(NSString *)Name Amount:(NSString *)Amount ExpirationTime:(NSString *)ExpirationTime complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 4.6 删除优惠券
- (void)ShanChuYouHuiQuanWithCouponsId:(NSString *)CouponsId complete:(SuccessBlock)finish fail:(FailureBlock)failure;


#pragma mark 5.1 新增卖家普通单个红包
- (void)XinZengPuTongDanGeHongBaoPOSTWithProducerId:(NSString *)ProducerId Count:(NSString *)Count Amount:(NSString *)Amount Message:(NSString *)Message complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 5.2 发放卖家普通单个红包给买家
- (void)FaFangPuTongDanGeHongBaoGeiMaiJia3POSTWithRedEnvelopeId:(NSString *)RedEnvelopeId ConsumerId:(NSString *)ConsumerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 5.3 发放卖家普通单个红包给卖家
- (void)FaFangPuTongDanGeHongBaoGeiMaiJia4POSTWithRedEnvelopeId:(NSString *)RedEnvelopeId ProducerId:(NSString *)ProducerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 5.4 买家收取普通单个红包
- (void)MaiJia3ShouQuPuTongDanGeHongBaoPUTWithRedEnvelopeId:(NSString *)RedEnvelopeId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 5.5 查询买家普通红包列表
- (void)ChaXunMaiJia3PuTongHongBaoListWithConsumerId:(NSString *)ConsumerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 5.6 卖家收取普通单个红包
- (void)MaiJia4ShouQuPuTongDanGeHongBaoPUTWithRedEnvelopeId:(NSString *)RedEnvelopeId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 5.7 查询卖家普通红包列表
- (void)ChaXunMaiJia4PuTongHongBaoListWithProducerId:(NSString *)ProducerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 5.8 删除红包
- (void)ShanChuHongBaoWithRedEnvelopeId:(NSString *)RedEnvelopeId complete:(SuccessBlock)finish fail:(FailureBlock)failure;


#pragma mark 6.1 新增卖家关注卖家
- (void)XinZengMaiJia4GuanZhuMaiJia4WithProducerId:(NSString *)ProducerId FollowProducerId:(NSString *)FollowProducerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;


#pragma mark 6.2 卖家取消关注卖家
- (void)MaiJia4QuXiaoGuanZhuMaiJia4WithProducerId:(NSString *)ProducerId FollowProducerId:(NSString *)FollowProducerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 6.3 查询卖家是否关注卖家
- (void)ChaXunMaiJia4ShiFouGuanZhuMaiJia4WithProducerId:(NSString *)ProducerId FollowProducerId:(NSString *)FollowProducerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;


#pragma mark 6.4 查询卖家关注的所有卖家列表
- (void)ChaXunMaiJia4GuanZhuAllMaiJia4ListWithProducerId:(NSString *)ProducerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 6.9 查询卖家的关注和粉丝总数
- (void)ChaXunMaiJia4GuanZhuAndFenSiZongShuWithProducerId:(NSString *)ProducerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 7.1 新增买家关注卖家
- (void)XinZengMaiJia3GuanZhuMaiJia4WithConsumerId:(NSString *)ConsumerId ProducerId:(NSString *)ProducerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 7.2 买家取消关注卖家
- (void)MaiJia3QuXiaoGuanZhuMaiJia4WithConsumerId:(NSString *)ConsumerId ProducerId:(NSString *)ProducerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 7.3 查询买家是否关注卖家
- (void)ChaXunMaiJia3ShiFouGuanZhuMaiJia4WithConsumerId:(NSString *)ConsumerId ProducerId:(NSString *)ProducerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 7.4 查询买家关注的所有卖家列表
- (void)ChaXunMaiJia3GuanZhuAllMaiJia4ListWithConsumerId:(NSString *)ConsumerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 7.5 新增买家关注买家
- (void)XinZengMaiJia3GuanZhuMaiJia3WithConsumerId:(NSString *)ConsumerId FollowConsumerId:(NSString *)FollowConsumerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 7.6 买家取消关注买家
- (void)MaiJia3QuXiaoGuanZhuMaiJia3WithConsumerId:(NSString *)ConsumerId FollowConsumerId:(NSString *)FollowConsumerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 7.7 查询买家是否关注买家
- (void)ChaXunMaiJia3ShiFouGuanZhuMaiJia3WithConsumerId:(NSString *)ConsumerId FollowConsumerId:(NSString *)FollowConsumerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 7.8 查询买家关注的所有买家列表
- (void)ChaXunMaiJia3GuanZhuAllMaiJia3ListWithConsumerId:(NSString *)ConsumerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;


#pragma mark 7.9 查询买家的关注和粉丝总数
- (void)ChaXunMaiJia3GuanZhuAndFenSiZongShuWithConsumerId:(NSString *)ConsumerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 8.1 卖家给卖家发送聊天消息
- (void)MaiJia4GeiMaiJia4FaSongLiaoTianXiaoXiWithProducerId:(NSString *)ProducerId ChatProducerId:(NSString *)ChatProducerId BaseMassage:(NSDictionary *)dictMessage complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 8.2 卖家获取卖家聊天消息
- (void)MaiJia4GHuoQuMaiJia4LiaoTianXiaoXiWithProducerId:(NSString *)ProducerId ChatProducerId:(NSString *)ChatProducerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 8.3 卖家给买家发送聊天消息
- (void)MaiJia4GeiMaiJia3FaSongLiaoTianXiaoXiWithProducerId:(NSString *)ProducerId ConsumerId:(NSString *)ConsumerId BaseMassage:(NSDictionary *)dictMessage complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 8.4 卖家获取买家聊天消息
- (void)MaiJia4GHuoQuMaiJia3LiaoTianXiaoXiWithProducerId:(NSString *)ProducerId ConsumerId:(NSString *)ConsumerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 8.5 买家给卖家发送聊天消息
- (void)MaiJia3GeiMaiJia4FaSongLiaoTianXiaoXiWithConsumerId:(NSString *)ConsumerId ProducerId:(NSString *)ProducerId BaseMassage:(NSDictionary *)dictMessage complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 8.6 买家获取卖家聊天消息
- (void)MaiJia3GHuoQuMaiJia4LiaoTianXiaoXiWithConsumerId:(NSString *)ConsumerId ProducerId:(NSString *)ProducerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 8.7 买家给买家发送聊天消息
- (void)MaiJia3GeiMaiJia3FaSongLiaoTianXiaoXiWithConsumerId:(NSString *)ConsumerId ChatConsumerId:(NSString *)ChatConsumerId BaseMassage:(NSDictionary *)dictMessage complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 8.8 买家获取买家聊天消息
- (void)MaiJia3GHuoQuMaiJia3LiaoTianXiaoXiWithConsumerId:(NSString *)ConsumerId ChatConsumerId:(NSString *)ChatConsumerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;


#pragma mark 6.8 查询卖家关注的所有买家列表

- (void)chaXun68ProducerId:(NSString *)ProducerId complete:(SuccessBlock)finish fail:(FailureBlock)failure;

#pragma mark 6.5 新增卖家关注买家
- (void)xingzengmaijiaguanzhumaijiProducerId:(NSString *)ProducerId  WithConsumerID:(NSString *)consumerID complete:(SuccessBlock)finish fail:(FailureBlock)failure;
@end
