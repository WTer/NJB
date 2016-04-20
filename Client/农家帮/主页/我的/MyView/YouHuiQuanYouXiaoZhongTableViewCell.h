//
//  YouHuiQuanYouXiaoZhongTableViewCell.h
//  农家帮
//
//  Created by Mac on 16/3/27.
//  Copyright © 2016年 jingqi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GuanLiYouHuiQuanViewController.h"

@interface YouHuiQuanYouXiaoZhongTableViewCell : UITableViewCell

@property (nonatomic, strong) UIScrollView *youhuiquanView;
@property (nonatomic, strong) GuanLiYouHuiQuanViewController *viewController;

- (void)configWithDictionary:(NSDictionary *)dict;

@end
