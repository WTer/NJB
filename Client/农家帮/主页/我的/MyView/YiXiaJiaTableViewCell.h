//
//  YiXiaJiaTableViewCell.h
//  农家帮
//
//  Created by Mac on 16/3/10.
//  Copyright © 2016年 jingqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YiXiaJiaTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *niChengLabel;

@property (nonatomic, strong) UIImageView *timeImage;
@property (nonatomic, strong) UILabel *timeLabel;



@property (nonatomic, strong) UILabel *shuiguoNameLabel;
@property (nonatomic, strong) UIButton *shuiguoBtn;
@property (nonatomic, strong) UILabel *shuiguoDetailLabel;
@property (nonatomic, strong) UILabel *shuiguoPriceLabel;



- (void)configWithDictionary:(NSDictionary *)dict withAll:(BOOL)isAll;

@end
