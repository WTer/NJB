//
//  SouSuoTableViewCell.h
//  农帮乐
//
//  Created by hpz on 15/12/17.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SouSuoTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *picImageView;
@property (nonatomic, strong) UILabel *shuiguoNameLabel;
@property (nonatomic, strong) UIButton *shuiguoBtn;
@property (nonatomic, strong) UILabel *shuiguoPriceLabel;

- (void)configWithDictionary:(NSDictionary *)dict;

@end
