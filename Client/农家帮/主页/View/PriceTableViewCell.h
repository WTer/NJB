//
//  PriceTableViewCell.h
//  农帮乐
//
//  Created by hpz on 15/12/11.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"

@interface PriceTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *shuiguooriginalPriceLabel;
@property (nonatomic, strong) UILabel *shuiguoPriceLabel;
@property (nonatomic, strong) UILabel *shuiguoNumberLabel;

@property (nonatomic, strong) DetailViewController *viewController;


- (void)configWithDictionary:(NSArray *)array;

@end
