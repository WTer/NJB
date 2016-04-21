//
//  WoGuanZhuDeMaiJiaTableViewCell.h
//  农家帮
//
//  Created by Mac on 16/3/19.
//  Copyright © 2016年 jingqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XiaoFeiZheModel.h"
#import "WoGuanZhuDeMaiJiaViewController.h"

@class WoGuanZhuDeMaiJiaTableViewCell;
@protocol YaoQingDelegate <NSObject>

- (void)yaoQingXiaoFeiZheCell:(WoGuanZhuDeMaiJiaTableViewCell *)cell;

@end

@interface WoGuanZhuDeMaiJiaTableViewCell : UITableViewCell


@property (nonatomic, strong) XiaoFeiZheModel *model;
@property (nonatomic, strong) id<YaoQingDelegate> delegate;

@property (nonatomic, copy) NSString *nameString;
@property (nonatomic, copy) NSString *touxiangString;
@property (nonatomic, copy) NSString *producerId;

@property (nonatomic, strong) WoGuanZhuDeMaiJiaViewController *viewController;

- (void)configWithDictionary:(NSDictionary *)dict;

@end
