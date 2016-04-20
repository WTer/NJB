//
//  KuaiDiMessageTableViewCell.h
//  农帮乐
//
//  Created by 王朝源 on 15/12/8.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KuaiDiMessageTableViewCell : UITableViewCell
//w * _headerImage;
//_NameLable;
//_urlLable;
//_phoneNumberlable;
//_CallUp;//打电话
@property (nonatomic, copy)NSString * headerImageUrl;
@property (nonatomic, copy)NSString * nameString;
@property (nonatomic, copy)NSString * urlString;//快递公司的网址
@property (nonatomic, copy)NSString * phoneNumberString;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
