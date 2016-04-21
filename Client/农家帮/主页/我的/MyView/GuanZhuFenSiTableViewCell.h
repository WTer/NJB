//
//  GuanZhuFenSiTableViewCell.h
//  农家帮
//
//  Created by Mac on 16/4/6.
//  Copyright © 2016年 jingqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XiaoFeiZheModel.h"

@class GuanZhuFenSiViewController;
@class GuanZhuFenSiTableViewCell;

@protocol YaoQingDelegate <NSObject>

- (void)yaoQingXiaoFeiZheCell:(GuanZhuFenSiTableViewCell *)cell;

@end
@interface GuanZhuFenSiTableViewCell : UITableViewCell

@property (nonatomic, strong) XiaoFeiZheModel *model;
@property (nonatomic, strong) id<YaoQingDelegate> delegate;

@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UIImageView *renzhengbiaozhi;


@property (nonatomic, copy) NSString *nameString;
@property (nonatomic, copy) NSString *touxiangString;
@property (nonatomic, copy) NSString *producerId;

@property (nonatomic, strong) GuanZhuFenSiViewController *viewController;

- (void)configWithDictionary:(NSDictionary *)dict;

@end
