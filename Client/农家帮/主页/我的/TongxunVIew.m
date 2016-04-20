//
//  TongxunVIew.m
//  农帮乐
//
//  Created by 王朝源 on 15/12/9.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "TongxunVIew.h"
#import "OrderButton.h"
#import "UIImageView+WebCache.h"
#import "contactModel.h"
@implementation TongxunVIew
{
    UIImageView * _headerImage;
    UILabel * _NameLable;
    UILabel * _phoneNumberlable;
    UILabel * _bigAire;//用户的相对大的区域
    UILabel * _detailAire;//详细的地址区域
    UIButton * _CallUp;
    UIView * _view1;
    UIView * _view2;
}


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    self.frame = CGRectMake(0, 0, Screen_Width, 254 * scaleWidth);
    _headerImage = [[UIImageView alloc]init];
    _NameLable = [[UILabel alloc]init];
    _phoneNumberlable = [[UILabel alloc]init];
    _bigAire = [[UILabel alloc]init];
    _detailAire = [[UILabel alloc]init];
    _CallUp = [[UIButton alloc]init];
    _OrderButton = [[OrderButton alloc]init];
    
    _view1 = [[UIView alloc]init];
    _view2 = [[UIView alloc]init];
    [self addSubview:_OrderButton];
    [self addSubview:_headerImage];
    [self addSubview:_NameLable];
    [self addSubview:_phoneNumberlable];
    [self addSubview:_bigAire];
    [self addSubview:_detailAire];
    [self addSubview:_CallUp];
    [self addSubview:_view1];
    [self addSubview:_view2];
//    设置按钮内部图片间距和标题间距
//// 设置按钮内部图片间距
//    UIEdgeInsets insets = UIEdgeInsetsMake(0, 100, 0, 0);
//    _OrderButton.contentEdgeInsets = insets;
//    
//    UIEdgeInsets insetsTitle = UIEdgeInsetsMake(0, -300, 0, 0);
//    _OrderButton.titleEdgeInsets = insetsTitle; // 标题间距
}

- (void)setys
{
    [_headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24 * scaleWidth);
        make.top.mas_equalTo(24 * scaleHeight);
        make.width.mas_equalTo(60 * scaleWidth);
        make.height.mas_equalTo(60 * scaleWidth);
    }];
    _headerImage.layer.cornerRadius = 30 * scaleWidth;
    _headerImage.layer.masksToBounds = YES;
    [_NameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        CGSize size = [_NameLable.text sizeWithFont:BaseFont(28) maxSize:CGSizeMake(999, 999 * scaleHeight)];
        make.top.mas_equalTo(24 * scaleHeight);
        make.left.mas_equalTo(_headerImage.mas_right).offset(24 * scaleWidth);
        make.width.mas_equalTo(size.width);
        make.height.mas_equalTo(size.height);
    }];
    BaseLableSet(_NameLable, 105, 105, 108, 28);
    [_phoneNumberlable mas_makeConstraints:^(MASConstraintMaker *make) {
         CGSize size = [_phoneNumberlable.text sizeWithFont:BaseFont(28) maxSize:CGSizeMake(999, 28 * scaleHeight)];
        make.top.mas_equalTo(24 * scaleHeight);
        make.left.mas_equalTo(_NameLable.mas_right).offset(40 * scaleWidth);
        make.width.mas_equalTo(size.width);
        make.height.mas_equalTo(size.height);
    }];
    BaseLableSet(_phoneNumberlable, 54, 54, 54, 28);
    [_bigAire mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_NameLable.mas_bottom).offset(24 * scaleHeight);
        make.left.mas_equalTo(_headerImage.mas_right).offset(24 * scaleWidth);
        make.width.mas_equalTo(450 * scaleWidth);
        make.height.mas_equalTo(21 * scaleHeight);
    }];
    [_detailAire mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_bigAire.mas_bottom).offset(20 * scaleHeight);
        make.left.mas_equalTo(_headerImage.mas_right).offset(24 * scaleWidth);
        make.width.mas_equalTo(450* scaleWidth);
        make.height.mas_equalTo(21 * scaleHeight);
    }];
    BaseLableSet(_bigAire, 178, 178, 178, 21);
    BaseLableSet(_detailAire, 178, 178, 178, 21);
    [_CallUp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-40 * scaleWidth);
        make.width.mas_equalTo(28 * scaleWidth);
        make.height.mas_equalTo(30 * scaleHeight);
        make.top.mas_equalTo(58 * scaleHeight);
    }];
    
    [_CallUp setImage:[UIImage imageNamed:@"grzx_cykd_icon.png"] forState:UIControlStateNormal];
    _OrderButton.frame = CGRectMake(0, 186 * scaleHeight, Screen_Width, 80 * scaleHeight);
    [_OrderButton setTitle:NSLocalizedString(@"收起订单", @"") forState:UIControlStateSelected];
    [_OrderButton setImage:[UIImage imageNamed:@"grzx_txl_btn_zhankai.png"] forState:UIControlStateNormal];
    [_OrderButton setImage:[UIImage imageNamed:@"grzx_txl_btn_shouqi.png"] forState:UIControlStateSelected];
    
    _NameLable.adjustsFontSizeToFitWidth  = YES;
    _phoneNumberlable.adjustsFontSizeToFitWidth = YES;
    _OrderButton.titleLabel.font = BaseFont(28);
    [_OrderButton setTitleColor:BaseColor(105, 105, 105, 1) forState:UIControlStateNormal];
    [_OrderButton setTitleColor:BaseColor(105, 105, 105, 1) forState:UIControlStateSelected];
    
    [_view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(186 * scaleHeight);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(3 * scaleHeight);
    }];
    [_view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(266 * scaleHeight);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(3 * scaleHeight);
    }];
    _view1.backgroundColor = BaseColor(249, 249, 249, 1);
    _view2.backgroundColor = BaseColor(249, 249, 249, 1);
}

-(void)setModel:(contactModel *)model
{
    [_headerImage sd_setImageWithURL:[NSURL URLWithString:model.smallportraiturl] placeholderImage:[UIImage imageNamed:@"grzx_btn_touxiang.png"]];
    _NameLable.text = model.displayname;
    _phoneNumberlable.text = model.telephone;
    _bigAire.text = [NSString stringWithFormat:@"%@ %@", model.province, model.city];
    _detailAire.text = model.address;
    [_OrderButton setTitle:[NSString stringWithFormat:@"%@ (%@)",NSLocalizedString(@"我的订单", @""),_orderNumber] forState:UIControlStateNormal];
    [self setys];
}

@end
