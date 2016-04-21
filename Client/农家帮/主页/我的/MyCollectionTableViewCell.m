//
//  MyCollectionTableViewCell.m
//  农帮乐
//
//  Created by 王朝源 on 15/12/9.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "MyCollectionTableViewCell.h"
#import "myCollectionModel.h"
@implementation MyCollectionTableViewCell
{
    UIImageView * _headerImage;
    UILabel * _GoodsNameLable;
    UIButton * _cateGory;//商品的类型
    UILabel * _goodsMessageLable;//商品的信息
    UIView * _backView;
    UIButton * _cancleCollectionButton;//取消收藏按钮
    
    UIButton * _button;
    
    UIView * _view;
}
- (void)awakeFromNib {
    // Initialization code
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
    _GoodsNameLable = [[UILabel alloc]init];
    _cateGory = [[UIButton alloc]init];
    _goodsMessageLable = [[UILabel alloc]init];
    _backView = [[UIView alloc]init];
    _backView.backgroundColor = [UIColor whiteColor];
    _cancleCollectionButton = [[UIButton alloc]init];
    _button = [[UIButton alloc]init];
    _view = [[UIView alloc]init];
    
    [self.contentView addSubview:_backView];
    [_backView addSubview:_headerImage];
    [_backView addSubview:_goodsMessageLable];
    [_backView addSubview:_cateGory];
    [_backView addSubview:_GoodsNameLable];
    [_backView addSubview:_cancleCollectionButton];
    [_backView addSubview:_view];
    [_backView addSubview:_button];
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
        make.height.mas_equalTo(240 * scaleHeight);
    }];
    
    
    [_headerImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(24 * scaleHeight);
        make.left.mas_equalTo(40 * scaleWidth);
        make.width.mas_equalTo(110 * scaleWidth);
        make.height.mas_equalTo(110 * scaleHeight);
    }];
    
    
    [_GoodsNameLable mas_remakeConstraints:^(MASConstraintMaker *make) {
        CGSize size = [_GoodsNameLable.text sizeWithFont:[UIFont systemFontOfSize:21] maxSize:CGSizeMake(999, 28 * scaleHeight)];
        make.left.mas_equalTo(_headerImage.mas_right).offset(24 * scaleWidth);
        make.height.mas_equalTo(size.height);
        make.width.mas_equalTo(size.width + 5);
        make.top.mas_equalTo(24 * scaleHeight);
    }];
    BaseLableSet(_GoodsNameLable, 52, 52, 52, 21);
    
    
    
    [_cateGory mas_remakeConstraints:^(MASConstraintMaker *make) {
        CGSize size = [_cateGory.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:16.0] maxSize:CGSizeMake(999, 28 * scaleHeight)];
        _cateGory.titleLabel.font = BaseFont(16.0);
        make.left.mas_equalTo(_GoodsNameLable.mas_right).offset(14 * scaleWidth);
        make.top.mas_equalTo(24 * scaleHeight);
        make.height.mas_equalTo(size.height);
        make.width.mas_equalTo(size.width);
        
    }];
    [_cateGory setBackgroundImage:[UIImage imageNamed:@"zy_icon_shuiguo.jpg"] forState:UIControlStateNormal];
    [_cateGory setTitleColor:BaseColor(14, 184, 58, 1) forState:UIControlStateNormal];
    
    
    
    [_goodsMessageLable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_GoodsNameLable.mas_bottom).offset(20 * scaleHeight);
        make.left.mas_equalTo(_headerImage.mas_right).offset(24 * scaleWidth);
        make.width.mas_equalTo(500 * scaleWidth);
        make.height.mas_equalTo(30 * scaleHeight);
        
        
        
        
    }];
    [_cancleCollectionButton setTitle:NSLocalizedString(@"取消收藏", @"") forState:UIControlStateNormal];
    [_cancleCollectionButton setTitleColor:BaseColor(52, 52, 52, 0.6) forState:UIControlStateNormal];
    [_cancleCollectionButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(160 * scaleHeight);
        make.right.mas_equalTo(-40 * scaleWidth);
        make.width.mas_equalTo(_backView.mas_width);
        make.height.mas_equalTo(80 * scaleHeight);
        _cancleCollectionButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }];
    _cancleCollectionButton.titleLabel.font = BaseFont(18.0);
    
    
    [_view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(160 * scaleHeight);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(3 * scaleHeight);
    }];
    _view.backgroundColor = BaseColor(249, 249, 249, 1);

    [_button mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(160 * scaleHeight);
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(80 * scaleHeight);
    }];
    [_button addTarget:self action:@selector(cancleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

#warning canclebutton的点击事件暂时没有实现
- (void)cancleButtonClick:(UIButton *)button
{
    _Myblock(button);
}

-(void)cancleCollectionButtonClick:(blockOfCancle)block
{
    _Myblock = block;
}

-(void)setModel:(myCollectionModel *)model
{
    [_headerImage sd_setImageWithURL:[NSURL URLWithString:model.smallportraiturl] placeholderImage:[UIImage imageNamed:@"600.png"]];
    _GoodsNameLable.text = model.name;
    [_cateGory setTitle:model.type forState:UIControlStateNormal];
    NSDictionary* style1 = @{@"body":[UIFont systemFontOfSize:16.0],
                             @"bold":[UIFont boldSystemFontOfSize:16.0],
                             @"red": BaseColor(255, 104, 104, 1),
                             @"gray":@[BaseColor(178, 178, 178, 1),[UIFont systemFontOfSize:14.0]]};
    //    _goodsMessageLable.text = @"¥15.00/斤｜运费：包邮";
    _goodsMessageLable.attributedText = [[NSString stringWithFormat:@"<red><bold>¥%@</bold>/%@</red><gray>｜%@：%@</gray>", model.price, model.unit,  NSLocalizedString(@"运费", @""),model.freight] attributedStringWithStyleBook:style1];
    [self DTsetyueshu];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
