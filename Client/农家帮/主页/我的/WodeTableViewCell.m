//
//  WodeTableViewCell.m
//  农帮乐
//
//  Created by 王朝源 on 15/12/6.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "WodeTableViewCell.h"
#import "Masonry.h"
@implementation WodeTableViewCell
{
    UIImageView * _headerImage;
    UILabel * _lable;
}
- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

//创建cell上的视图
- (void)createUI
{
    _headerImage = [[UIImageView alloc]init];
    [self.contentView addSubview:_headerImage];
    _lable = [[UILabel alloc]init];
    [self.contentView addSubview:_lable];
    [_headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24 * scaleWidth);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.width.height.mas_equalTo(40 * scaleWidth);
    }];
    _headerImage.layer.cornerRadius = 20 * scaleWidth;
    _headerImage.layer.masksToBounds = YES;
    [_lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_headerImage.mas_right).offset(20 * scaleWidth);
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(21);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    _lable.textAlignment = NSTextAlignmentLeft;
    _lable.font = [UIFont systemFontOfSize:18.0];
    _lable.textColor = BaseColor(52, 52, 52, 0.6);
    _lable.adjustsFontSizeToFitWidth = YES;
}
-(void)setImageName:(NSString *)imageName
{
    _headerImage.image = [UIImage imageNamed:imageName];
}
- (void)setDetail:(NSString *)detail
{
    _lable.text = detail;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
