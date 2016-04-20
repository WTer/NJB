//
//  MainTableViewCell.h
//  农帮乐
//
//  Created by hpz on 15/12/3.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MainTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *niChengLabel;
@property (nonatomic, strong) UIImageView *renzhengImage;

@property (nonatomic, strong) UIImageView *timeImage;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIScrollView *picScrollView;

@property (nonatomic, strong) UILabel *shuiguoNameLabel;
@property (nonatomic, strong) UIButton *shuiguoBtn;
@property (nonatomic, strong) UILabel *shuiguoDetailLabel;
@property (nonatomic, strong) UILabel *shuiguoPriceLabel;

@property (nonatomic, strong) UIButton *guanzhuBtn;
@property (nonatomic, strong) UIButton *shareBtn;

@property (nonatomic, strong) UIButton *shangpinzhuangtaiBtn;


@property (nonatomic, strong) UIViewController *viewController;


- (void)configWithDictionary:(NSDictionary *)dict;

@end
