//
//  TongXunLuTableViewCell.m
//  农帮乐
//
//  Created by 王朝源 on 15/12/8.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "TongXunLuTableViewCell.h"

@implementation TongXunLuTableViewCell
{
    UIImageView * _headerImage;
    UILabel * _NameLable;
    UILabel * _phoneNumberlable;
    UILabel * _bigAire;//用户的相对大的区域
    UILabel * _detailAire;//详细的地址区域
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
