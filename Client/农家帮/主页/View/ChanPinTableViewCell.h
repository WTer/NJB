//
//  ChanPinTableViewCell.h
//  农帮乐
//
//  Created by hpz on 15/12/11.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChanPinTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *shuiguoNameLabel;
@property (nonatomic, strong) UIButton *shuiguoBtn;
@property (nonatomic, strong) UILabel *shuiguoDetailLabel;

- (void)configWithDictionary:(NSDictionary *)dict;

@end
