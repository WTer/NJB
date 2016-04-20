//
//  KuaiDiMessageTableViewCell.m
//  农帮乐
//
//  Created by 王朝源 on 15/12/8.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "KuaiDiMessageTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation KuaiDiMessageTableViewCell
{
    UIImageView * _headerImage;
    UILabel * _NameLable;
    UILabel * _urlLable;
    UILabel * _phoneNumberlable;
    UIButton * _CallUp;//打电话
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}
- (void)createUI
{
    _headerImage = [[UIImageView alloc]init];
    _NameLable = [[UILabel alloc]init];
    _urlLable = [[UILabel alloc]init];
    _phoneNumberlable = [[UILabel alloc]init];
    _CallUp = [[UIButton alloc]init];
    [self.contentView addSubview:_headerImage];
    [self.contentView addSubview:_NameLable];
    [self.contentView addSubview:_urlLable];
    [self.contentView addSubview:_phoneNumberlable];
    [self.contentView addSubview:_CallUp];
    [self addYueShu];
}

//给控件添加约束
- (void)addYueShu
{
    [_headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(60 * scaleWidth);
        make.height.mas_equalTo(60 * scaleWidth);
        make.left.mas_equalTo(24 * scaleWidth);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        
    }];
    [_NameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_headerImage.mas_right).offset(24 * scaleWidth);
        make.top.mas_equalTo(self.contentView.mas_top).offset(12 * scaleHeight);
        make.width.mas_equalTo(350 * scaleWidth);
        make.bottom.mas_equalTo(_urlLable.mas_top).offset(-12 * scaleHeight);
    }];
    _NameLable.textColor = BaseColor(105, 105, 105, 1);
//    _NameLable.font = [UIFont systemFontOfSize:21];
    [_urlLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_headerImage.mas_right).offset(24 * scaleWidth);
        make.top.mas_equalTo(_NameLable.mas_bottom).offset(12 * scaleHeight);
        make.width.mas_equalTo(350 * scaleWidth);
        make.height.mas_equalTo(_NameLable.mas_height);
        make.bottom.mas_equalTo(-12 * scaleHeight);
    }];
    _urlLable.textColor = BaseColor(178, 178, 178, 1);
//    _urlLable.font = [UIFont systemFontOfSize:21];
    [_phoneNumberlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30 * scaleHeight);
        make.bottom.mas_equalTo(-30 * scaleHeight);
        make.right.mas_equalTo(_CallUp.mas_left).offset(-20 * scaleWidth);
        make.width.mas_equalTo(scaleWidth * 300);
    }];
    _phoneNumberlable.textColor = BaseColor(178, 178, 178, 1);
    _phoneNumberlable.textAlignment = NSTextAlignmentRight;
//    _phoneNumberlable.font = [UIFont systemFontOfSize:21];
    [_CallUp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-40 * scaleWidth);
        make.width.mas_equalTo(28 * scaleWidth);
        make.height.mas_equalTo(30 * scaleHeight);
        make.left.mas_equalTo(_phoneNumberlable.mas_right).offset(20 * scaleWidth);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    [_CallUp setImage:[UIImage imageNamed:@"grzx_cykd_icon.png"] forState:UIControlStateNormal];
}
-(void)setHeaderImageUrl:(NSString *)headerImageUrl
{
    [_headerImage sd_setImageWithURL:[NSURL URLWithString:headerImageUrl] placeholderImage:[UIImage imageNamed:@"zy_btn_huidaodingbu.png"]];
}
- (void)setNameString:(NSString *)nameString
{
    _NameLable.text = nameString;
}
- (void)setUrlString:(NSString *)urlString
{
    _urlLable.text = urlString;
}
- (void)setPhoneNumberString:(NSString *)phoneNumberString
{
    _phoneNumberlable.text = phoneNumberString;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
