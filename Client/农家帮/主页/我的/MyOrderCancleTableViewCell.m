//
//  MyOrderCancleTableViewCell.m
//  农帮乐
//
//  Created by 王朝源 on 15/12/16.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "MyOrderCancleTableViewCell.h"
#import "myOrderModel.h"
@implementation MyOrderCancleTableViewCell

{
    UIImageView * _headerImage;
    UILabel * _GoodsNameLable;
    UIButton * _cateGory;//商品的类型
    UILabel * _goodsMessageLable;//商品的信息
    UIView * _backView;
    UIButton * _cancleCollectionButton;//取消收藏按钮
    UILabel * _orderMessageLable;//订单信息
    UILabel * _orderNumberMessge;//订单数量
    UILabel * _contactNumberLable;//联系电话
    UILabel * _shouhuodizhi;//收货地址
    
    UIButton * _certainOrder;//确认订单
    
    UILabel * _timeLable;//记录订单时间的lable
    UILabel * _dizhiDetailLable;
    
    UIView * _view1;
    UIView * _view2;
    UIView * _view3;
    UIView * _view4;
    
    UIImageView * _imageView;//确认订单
    UILabel * _querenlable;
    
    UIButton * _button;
}
- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI2];
    }
    return self;
}



- (void)createUI2
{
    _headerImage = [[UIImageView alloc]init];
    _GoodsNameLable = [[UILabel alloc]init];
    _cateGory = [[UIButton alloc]init];
    _goodsMessageLable = [[UILabel alloc]init];
    
    _backView = [[UIView alloc]init];
    _backView.backgroundColor = [UIColor whiteColor];
    
    _orderMessageLable = [[UILabel alloc]init];
    _orderNumberMessge = [[UILabel alloc]init];
    _contactNumberLable = [[UILabel alloc]init];
    _shouhuodizhi = [[UILabel alloc]init];
    _certainOrder = [[UIButton alloc]init];
    _timeLable = [[UILabel alloc]init];
    _dizhiDetailLable = [[UILabel alloc]init];
    _button = [[UIButton alloc]init];
    
    _view1 = [[UIView alloc]init];
    _view2 = [[UIView alloc]init];
    _view3 = [[UIView alloc]init];
    _view4 = [[UIView alloc]init];
    
    
    _querenlable = [[UILabel alloc]init];
    _imageView = [[UIImageView alloc]init];
    
    
    [_backView addSubview:_orderMessageLable];
    [_backView addSubview:_orderNumberMessge];
    [_backView addSubview:_contactNumberLable];
    [_backView addSubview:_shouhuodizhi];
    [_backView addSubview:_certainOrder];
    [self.contentView addSubview:_backView];
    [_backView addSubview:_headerImage];
    [_backView addSubview:_goodsMessageLable];
    [_backView addSubview:_cateGory];
    [_backView addSubview:_GoodsNameLable];
    [_backView addSubview:_timeLable];
    [_backView addSubview:_dizhiDetailLable];
    
    [_backView addSubview:_view1];
    [_backView addSubview:_view2];
    [_backView addSubview:_view3];
    [_backView addSubview:_view4];
    
    [_backView addSubview:_querenlable];
    [_backView addSubview:_imageView];
    [_backView addSubview:_button];
    [self DTsetyueshu];
}

// 当设置lable的字体的时候动态的改变lable的大小(动态的添加约束)
- (void)DTsetyueshu
{
    // 告诉self.view约束需要更新
    [self.contentView setNeedsUpdateConstraints];
    // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
    [self.contentView updateConstraintsIfNeeded];
    [_backView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20 * scaleHeight);
        make.left.mas_equalTo(24 * scaleWidth);
        make.width.mas_equalTo(Screen_Width - 48 * scaleWidth);
        make.height.mas_equalTo(560 * scaleHeight);
    }];
    [_orderMessageLable mas_remakeConstraints:^(MASConstraintMaker *make) {
        CGSize size = [_orderMessageLable.text sizeWithFont:[UIFont systemFontOfSize:16] maxSize:CGSizeMake(999, 24 * scaleHeight)];
        make.left.mas_equalTo(40 * scaleWidth);
        make.width.mas_equalTo(size.width);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(80 * scaleHeight);
        _orderMessageLable.adjustsFontSizeToFitWidth = YES;
    }];
    [_timeLable mas_remakeConstraints:^(MASConstraintMaker *make) {
        CGSize size = [_timeLable.text sizeWithFont:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(999, 24 * scaleHeight)];
        make.right.mas_equalTo(-40 * scaleWidth);
        make.width.mas_equalTo(size.width);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(80 * scaleHeight);
        _timeLable.textAlignment = NSTextAlignmentRight;
        _timeLable.adjustsFontSizeToFitWidth  = YES;
    }];
    [_headerImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(106 * scaleHeight);
        make.left.mas_equalTo(40 * scaleWidth);
        make.width.mas_equalTo(110 * scaleWidth);
        make.height.mas_equalTo(110 * scaleHeight);
    }];
    [_GoodsNameLable mas_remakeConstraints:^(MASConstraintMaker *make) {
        CGSize size = [_GoodsNameLable.text sizeWithFont:[UIFont systemFontOfSize:21] maxSize:CGSizeMake(999, 28 * scaleHeight)];
        make.left.mas_equalTo(_headerImage.mas_right).offset(24 * scaleWidth);
        make.height.mas_equalTo(size.height);
        make.width.mas_equalTo(size.width + 5);
        make.top.mas_equalTo(106 * scaleHeight);
        
    }];
    BaseLableSet(_GoodsNameLable, 52, 52, 52, 21);
    [_cateGory mas_remakeConstraints:^(MASConstraintMaker *make) {
        CGSize size = [_cateGory.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:16] maxSize:CGSizeMake(999, 28 * scaleHeight)];
        _cateGory.titleLabel.font = BaseFont(16);
        make.left.mas_equalTo(_GoodsNameLable.mas_right).offset(14 * scaleWidth);
        make.top.mas_equalTo(106 * scaleHeight);
        make.height.mas_equalTo(size.height);
        make.width.mas_equalTo(size.width);
        
    }];
    [_cateGory setBackgroundImage:[UIImage imageNamed:@"zy_icon_shuiguo.jpg"] forState:UIControlStateNormal];
    [_cateGory setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [_goodsMessageLable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_GoodsNameLable.mas_bottom).offset(20 * scaleHeight);
        make.left.mas_equalTo(_headerImage.mas_right).offset(24 * scaleWidth);
        make.width.mas_equalTo(500 * scaleWidth);
        make.height.mas_equalTo(30 * scaleHeight);
        
    }];
    
    [_orderNumberMessge mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40 * scaleWidth);
        make.width.mas_equalTo(Screen_Width - 88 * scaleWidth);
        make.top.mas_equalTo(240 * scaleHeight);
        make.height.mas_equalTo(80 * scaleHeight);
    }];
    
    [_contactNumberLable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40 * scaleWidth);
        make.width.mas_equalTo(Screen_Width - 88 * scaleWidth);
        make.top.mas_equalTo(320 * scaleHeight);
        make.height.mas_equalTo(80 * scaleHeight);
    }];
    [_shouhuodizhi mas_remakeConstraints:^(MASConstraintMaker *make) {
        CGSize size = [@"收货地址：" sizeWithFont:BaseFont(22) maxSize:CGSizeMake(999, 24)];
        make.left.mas_equalTo(40 * scaleWidth);
        make.top.mas_equalTo(400 * scaleHeight);
        make.width.mas_equalTo(size.width);
        make.bottom.mas_equalTo(-80 * scaleHeight);
        _shouhuodizhi.numberOfLines = 0;
    }];
    [_dizhiDetailLable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_shouhuodizhi.mas_right);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(80 * scaleHeight);
        make.top.mas_equalTo(400 * scaleHeight);
        _dizhiDetailLable.numberOfLines = 0;
    }];
    BaseLableSet(_dizhiDetailLable, 52, 52, 52, 16);
    [_certainOrder mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(80 * scaleHeight);
        
    }];
    [_imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(40 * scaleWidth);
        make.right.mas_equalTo(_querenlable.mas_left).offset(-20);
        make.centerY.mas_equalTo(_querenlable.mas_centerY);
    }];
    _imageView.image = [UIImage imageNamed:@"grzx_wddd_YQX.png"];
    [_querenlable mas_remakeConstraints:^(MASConstraintMaker *make) {
        CGSize size = [NSLocalizedString(@"已取消", @"") sizeWithFont:BaseFont(18) maxSize:CGSizeMake(999, 24)];
        make.right.mas_equalTo(-40 * scaleWidth);
        make.width.mas_equalTo(size.width);
        make.centerY.mas_equalTo(_certainOrder.mas_centerY);
        make.height.mas_equalTo(80 * scaleHeight);
    }];
    _querenlable.text = NSLocalizedString(@"已取消", @"");
    _querenlable.textColor = BaseColor(255, 104, 104, 1);
    _querenlable.font = BaseFont(18);
    
    [_button mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(80 * scaleHeight);
        
    }];
    [_button addTarget:self action:@selector(querenClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //    BaseColor(9, 142, 43, 1)
    _certainOrder.backgroundColor = [UIColor whiteColor];
    
    [_view1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(80 * scaleHeight);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(3 * scaleHeight);
    }];
    [_view2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(240 * scaleHeight);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(3 * scaleHeight);
    }];
    [_view3 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(320 * scaleHeight);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(3 * scaleHeight);
    }];
    [_view4 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(480 * scaleHeight);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(3 * scaleHeight);
    }];
    _view1.backgroundColor = BaseColor(249, 249, 249, 1);
    _view2.backgroundColor = BaseColor(249, 249, 249, 1);
    _view3.backgroundColor = BaseColor(249, 249, 249, 1);
    _view4.backgroundColor = BaseColor(249, 249, 249, 1);
    
}
#pragma mark  -- 确认按钮的点击事件
- (void)querenClick:(UIButton *)button
{
//    _mblock(button);
}
- (void)certainButtonClick:(myBlock)block
{
    _mblock = block;
}
- (void)setModel:(myOrderModel *)model
{
    [_headerImage sd_setImageWithURL:[NSURL URLWithString:model.smallportraiturl] placeholderImage:[UIImage imageNamed:@"600.png"]];
    _GoodsNameLable.text = model.orderName;
    [_cateGory setTitle:model.type forState:UIControlStateNormal];
    NSDictionary* style1 = @{@"body":[UIFont systemFontOfSize:16.0],
                             @"bold":[UIFont boldSystemFontOfSize:16.0],
                             @"red": BaseColor(255, 104, 104, 1),
                             @"gray":@[BaseColor(178, 178, 178, 1),[UIFont systemFontOfSize:16.0]]};
    //    _goodsMessageLable.text = @"¥15.00/斤｜运费：包邮";
    _goodsMessageLable.attributedText = [[NSString stringWithFormat:@"<red><bold>¥%@</bold>/%@</red><gray>｜%@：%@</gray>", model.price, model.unit, NSLocalizedString(@"运费", @"") ,model.freight] attributedStringWithStyleBook:style1];
    //    _orderMessageLable.text = @"订单号：101354909028";
    NSDictionary* style2 = @{@"body":[UIFont systemFontOfSize:16],
                             @"blue": [UIColor blueColor],
                             @"gray":@[BaseColor(178, 178, 178, 1),[UIFont systemFontOfSize:16.0]]};
    _orderMessageLable.attributedText = [[NSString stringWithFormat:@"<gray>%@：</gray><blue>%@</blue>",NSLocalizedString(@"订单号", @""),model.orderID] attributedStringWithStyleBook:style2];
    //    _orderNumberMessge.text = @"订购数量：1京       订购人：小明";
    NSDictionary * dict2 = @{@"body":[UIFont systemFontOfSize:16],
                             @"gray":@[BaseColor(178, 178, 178, 1),[UIFont systemFontOfSize:16.0]],
                             @"black":BaseColor(52, 52, 52, 1),
                             @"white":[UIColor whiteColor]
                             };
    _orderNumberMessge.attributedText = [[NSString stringWithFormat:@"<gray>%@：</gray><black>%@</black>        <gray>%@：</gray><black>%@</black>", NSLocalizedString(@"订购数量", @""),model.count,  NSLocalizedString(@"订购人", @""), model.name] attributedStringWithStyleBook:dict2];
    
    
    NSDictionary * dict = @{@"body":[UIFont systemFontOfSize:16],
                            @"gray":@[BaseColor(178, 178, 178, 1),[UIFont systemFontOfSize:16.0]],
                            @"black":BaseColor(52, 52, 52, 1)
                            };
    //    _contactNumberLable.text = @"联系电话：23213123";
    _contactNumberLable.attributedText = [[NSString stringWithFormat:@"<gray>%@：</gray><black>%@</black>" ,   NSLocalizedString(@"联系电话", @""),model.telephone] attributedStringWithStyleBook:dict];
    _shouhuodizhi.text = NSLocalizedString(@"收获地址：", @"");
    BaseLableSet(_shouhuodizhi, 178, 178, 178, 21);
    _timeLable.text = model.ordertime;
    _dizhiDetailLable.text = [NSString stringWithFormat:@"%@省%@市%@ %@",model.province ,model.city, model.district, model.address];
    _dizhiDetailLable.textColor = BaseColor(52, 52, 52, 1);
    _dizhiDetailLable.numberOfLines = 2;
    _dizhiDetailLable.font = [UIFont systemFontOfSize:16];
    [self DTsetyueshu];//添加约束
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
