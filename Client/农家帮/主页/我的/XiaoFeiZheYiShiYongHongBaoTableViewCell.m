//
//  XiaoFeiZheYiShiYongHongBaoTableViewCell.m
//  农家帮
//
//  Created by Mac on 16/4/11.
//  Copyright © 2016年 jingqi. All rights reserved.
//

#import "XiaoFeiZheYiShiYongHongBaoTableViewCell.h"

@implementation XiaoFeiZheYiShiYongHongBaoTableViewCell

{
    UILabel * _moneyNumberLable;
    UILabel * _peopleNumberLable;
    UILabel * _nameNumberLable;
    UILabel * _timeNumberLable;
    UIButton * _senderButton;
    UIImageView * _imageView;
    UILabel * _zhuangtaiButton;
    UIImageView * _zhuangtaiImageView;
    
    UIButton * _jiantouButton;//显示红包的详细信息的按钮
    UIButton * _xiugaiButton;
    UIButton * _sanchuButton;
    
    BOOL  _pdIszuohua;//判断能否左右滑
}
- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _pdIszuohua = YES;
        [self createUI];
    }
    return self;
}
///为imageView添加手势
- (void)addShoushiForImageView
{
    UISwipeGestureRecognizer * swiper = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(moveTouch:)];
    swiper.direction = UISwipeGestureRecognizerDirectionRight;
    UISwipeGestureRecognizer * swiper2 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(moveTouch:)];
    swiper.direction = UISwipeGestureRecognizerDirectionLeft;
    [_imageView addGestureRecognizer:swiper];
    [_imageView addGestureRecognizer:swiper2];
}
- (void)moveTouch:(UISwipeGestureRecognizer *)swipwe
{
    // &相当于==
    if (swipwe.direction & UISwipeGestureRecognizerDirectionLeft) {
        if (_pdIszuohua) {
            [self reSetKongjianWeizhi];
        }
        _pdIszuohua = NO;
    }if (swipwe.direction == UISwipeGestureRecognizerDirectionRight) {
        if (!_pdIszuohua) {
            [self DingyiCicun];
        }
        _pdIszuohua = YES;
    }
}

//其他控件
- (void)createUI
{
    _moneyNumberLable = [[UILabel alloc]init];
    _peopleNumberLable = [[UILabel alloc]init];
    _nameNumberLable = [[UILabel alloc]init];
    _timeNumberLable = [[UILabel alloc]init];
    _senderButton = [[UIButton alloc]init];
    _imageView = [[UIImageView alloc]init];
    _zhuangtaiButton = [[UILabel alloc]init];
    _zhuangtaiImageView = [[UIImageView alloc]init];
    [_imageView addSubview:_zhuangtaiImageView];
    [_imageView addSubview:_moneyNumberLable];
    [_imageView addSubview:_peopleNumberLable];
    [_imageView addSubview:_nameNumberLable];
    [_imageView addSubview:_timeNumberLable];
    [_imageView addSubview:_senderButton];
    [_imageView addSubview:_zhuangtaiButton];
    [self.contentView addSubview:_imageView];
    _imageView.userInteractionEnabled = YES;
    
    _jiantouButton = [[UIButton alloc]init];
    _xiugaiButton = [[UIButton alloc]init];
    _sanchuButton = [[UIButton alloc]init];
    [self.contentView addSubview:_xiugaiButton];
    [self.contentView addSubview:_sanchuButton];
    [self.contentView addSubview:_jiantouButton];
    
    [self DingyiCicun];
    [self addShoushiForImageView];//添加手势
    
    
}

//重新定义控件位置
- (void)reSetKongjianWeizhi
{
    // 告诉self.view约束需要更新
    [self.contentView setNeedsUpdateConstraints];
    // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
    [self.contentView updateConstraintsIfNeeded];
    [_moneyNumberLable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(63 * scaleHeight);
        make.left.mas_equalTo(49 * scaleWidth);
        make.width.mas_equalTo(100 * scaleWidth);
        make.height.mas_equalTo(83 * scaleHeight);
    }];
    [_peopleNumberLable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(160 * scaleHeight);
        make.left.mas_equalTo(70 * scaleHeight);
        make.height.mas_equalTo(60 * scaleHeight);
        make.width.mas_equalTo(80 * scaleWidth);
        
    }];
    [_zhuangtaiButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(195 * scaleHeight);
        make.left.mas_equalTo(70 * scaleHeight);
        make.height.mas_equalTo(60 * scaleHeight);
        make.width.mas_equalTo(80 * scaleWidth);
    }];
    [_nameNumberLable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(338 * scaleWidth);
        make.top.mas_equalTo(30 * scaleHeight);
        make.height.mas_equalTo(40 * scaleHeight);
        make.left.mas_equalTo(170 * scaleWidth);
        
        
    }];
    [_timeNumberLable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(338 * scaleWidth);
        make.height.mas_equalTo(30 * scaleHeight);
        make.top.mas_equalTo(80 *scaleHeight);
        make.left.mas_equalTo(170 * scaleWidth);
    }];
    [_senderButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(160 * scaleHeight);
        make.left.mas_equalTo(259 * scaleWidth);
        make.height.mas_equalTo(56 * scaleHeight);
        make.width.mas_equalTo(177 * scaleWidth);
        
    }];
    [_imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(510 * scaleWidth);
        make.top.mas_equalTo(11 * scaleHeight);
        make.height.mas_equalTo(261 * scaleHeight);
        make.left.mas_equalTo(19* scaleWidth);
    }];
    
    [_zhuangtaiImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(167 * scaleWidth);
        make.height.mas_equalTo(155 * scaleWidth);
    }];
    
    [_jiantouButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(0 * scaleWidth);
        make.height.mas_equalTo(0 * scaleHeight);
        make.top.mas_equalTo(116 * scaleHeight);
        make.left.mas_equalTo(643 * scaleWidth);
    }];
    
    //添加删除  和修改按钮
    [_sanchuButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(119 * scaleWidth);
        make.height.mas_equalTo(106 * scaleHeight);
        make.left.mas_equalTo(_imageView.mas_right).offset(-2);
        make.top.mas_equalTo(_imageView.mas_top);
    }];
    [_xiugaiButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(119 * scaleWidth);
        make.height.mas_equalTo(106 * scaleHeight);
        make.left.mas_equalTo(_imageView.mas_right).offset(-2);
        make.top.mas_equalTo(_sanchuButton.mas_bottom).offset(10 * scaleHeight);
    }];
    [_sanchuButton setBackgroundImage:[UIImage imageNamed:@"zjhh_btn_xiugai_down.png"] forState:UIControlStateNormal];
    _sanchuButton.titleLabel.font = BaseFont(30);
    [_sanchuButton setTitle:@"删除" forState:UIControlStateNormal];
    [_sanchuButton setTitleColor:BaseColor(255, 255, 255, 1) forState:UIControlStateNormal];
    
    [_sanchuButton addTarget:self action:@selector(delelteClick:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)delelteClick:(UIButton *)button
{
    _deleteBlock(button);
}

- (void)deleteBlockClick:(myBlock)deleteBlock
{
    _deleteBlock = deleteBlock;
}

/*自定义空间的尺寸**/
- (void)DingyiCicun
{
    // 告诉self.view约束需要更新
    [self.contentView setNeedsUpdateConstraints];
    // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
    [self.contentView updateConstraintsIfNeeded];
    [_moneyNumberLable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(63 * scaleHeight);
        make.left.mas_equalTo(49 * scaleWidth);
        make.width.mas_equalTo(100 * scaleWidth);
        make.height.mas_equalTo(83 * scaleHeight);
    }];
    [_peopleNumberLable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(160 * scaleHeight);
        make.left.mas_equalTo(70 * scaleHeight);
        make.height.mas_equalTo(60 * scaleHeight);
        make.width.mas_equalTo(80 * scaleWidth);
        
    }];
    [_zhuangtaiButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(195 * scaleHeight);
        make.left.mas_equalTo(70 * scaleHeight);
        make.height.mas_equalTo(60 * scaleHeight);
        make.width.mas_equalTo(80 * scaleWidth);
    }];
    [_nameNumberLable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(338 * scaleWidth);
        make.top.mas_equalTo(30 * scaleHeight);
        make.height.mas_equalTo(40 * scaleHeight);
        make.left.mas_equalTo(170 * scaleWidth);
        
        
    }];
    [_timeNumberLable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(338 * scaleWidth);
        make.height.mas_equalTo(30 * scaleHeight);
        make.top.mas_equalTo(80 *scaleHeight);
        make.left.mas_equalTo(170 * scaleWidth);
    }];
    [_senderButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(160 * scaleHeight);
        make.left.mas_equalTo(259 * scaleWidth);
        make.height.mas_equalTo(56 * scaleHeight);
        make.width.mas_equalTo(177 * scaleWidth);
        
    }];
    [_imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(510 * scaleWidth);
        make.top.mas_equalTo(11 * scaleHeight);
        make.height.mas_equalTo(261 * scaleHeight);
        make.left.mas_equalTo(90 * scaleWidth);
    }];
    
    [_zhuangtaiImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(167 * scaleWidth);
        make.height.mas_equalTo(155 * scaleWidth);
    }];
    
    [_jiantouButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(25 * scaleWidth);
        make.height.mas_equalTo(50 * scaleHeight);
        make.top.mas_equalTo(116 * scaleHeight);
        make.left.mas_equalTo(643 * scaleWidth);
    }];
    [_jiantouButton setImage:[UIImage imageNamed:@"zjhb_btn_jiantou.jpg"] forState:UIControlStateNormal];
    [_sanchuButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(0 * scaleWidth);
        make.height.mas_equalTo(0 * scaleHeight);
        make.left.mas_equalTo(_imageView.mas_right).offset(0);
        make.top.mas_equalTo(_imageView.mas_top);
    }];
}


-(void)setTime:(NSString *)Time
{
    _Time = Time;
    [self jiazaiCicong];
}

/*更具数据加载界面次从**/
- (void)jiazaiCicong
{
    _imageView.image = [UIImage imageNamed:@"zjhb_ico_yishiyong.jpg"];
    _zhuangtaiImageView.image = [UIImage imageNamed:@"zjhh_ico_tuzhang_yishiyong.png"];
    
    _moneyNumberLable.text = _Amount;
    _moneyNumberLable.font = BaseFont(65);
    _moneyNumberLable.adjustsFontSizeToFitWidth = YES;
    _moneyNumberLable.textColor = BaseColor(254, 72, 48, 1);
    _moneyNumberLable.textAlignment = NSTextAlignmentCenter;
    NSDictionary* style1 = @{@"body":[UIFont systemFontOfSize:15.0] ,
                             @"red": BaseColor(254, 72, 48, 1),
                             @"black":[UIColor blackColor]};
    //    _goodsMessageLable.text = @"¥15.00/斤｜运费：包邮";
    //    _goodsMessageLable.attributedText = [[NSString stringWithFormat:@"<red><bold>¥%@</bold>/%@</red><gray>｜%@：%@</gray>", model.price, model.unit, NSLocalizedString(@"运费", @""), model.freight] attributedStringWithStyleBook:style1];
    _peopleNumberLable.attributedText = [[NSString stringWithFormat:@"<red>15</red><><black>人</black>"]attributedStringWithStyleBook:style1];
    _peopleNumberLable.textAlignment = NSTextAlignmentLeft;
    
    _zhuangtaiButton.text = @"已领取";
    _zhuangtaiButton.textColor = [UIColor blackColor];
    _zhuangtaiButton.adjustsFontSizeToFitWidth = YES;
    _zhuangtaiButton.textAlignment  = NSTextAlignmentLeft;
    
    _nameNumberLable.text = _Message;
    _nameNumberLable.font = [UIFont boldSystemFontOfSize:30 * 0.75];
    _nameNumberLable.textColor = BaseColor(255, 255, 225, 1);
    _nameNumberLable.textAlignment = NSTextAlignmentCenter;
    _nameNumberLable.adjustsFontSizeToFitWidth = YES;
    
    _timeNumberLable.text = [NSString stringWithFormat:@"有效期：%@" ,_timeNumberLable];
    _timeNumberLable.textAlignment = NSTextAlignmentCenter;
    _timeNumberLable.textColor = BaseColor(255, 224, 1, 1);
    _timeNumberLable.font = BaseFont(20);
    _timeNumberLable.adjustsFontSizeToFitWidth = YES;
    
    [_senderButton setTitle:@"发送好友" forState:UIControlStateNormal];
    [_senderButton setBackgroundImage:[UIImage imageNamed:@"zjhh_btn_yishiyong_fasonghaoyou.png"] forState:UIControlStateNormal];
    [_senderButton setTitleColor:BaseColor(254, 72, 48, 1) forState:UIControlStateNormal];
    [_senderButton addTarget:self action:@selector(senderButtonClick2:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)senderButtonClick2:(UIButton *)button
{
    _block(button);
}

- (void)senderButtonClick:(myBlock)block
{
    _block = block;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
