//
//  TongxunVIew.h
//  农帮乐
//
//  Created by 王朝源 on 15/12/9.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class contactModel;
@class OrderButton;

@interface TongxunVIew : UIButton
@property (nonatomic, strong)OrderButton * OrderButton;


@property (nonatomic ,copy)NSString * orderNumber;

//* _headerImage;
//NameLable;
//phoneNumberlable;
//bigAire;//用户的相对大的
//detailAire;//详细的地址
@property (nonatomic, strong)contactModel * model;
- (void)createUI;
@end
