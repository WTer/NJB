//
//  MyCommentTableViewCell.m
//  农帮乐
//
//  Created by 王朝源 on 15/12/10.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "MyCommentTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "myCommentModel.h"
@implementation MyCommentTableViewCell
{
    UIImageView * _headerImage;
    UILabel * _GoodsNameLable;
    UIButton * _cateGory;//商品的类型
    UILabel * _goodsMessageLable;//商品的信息
    UIView * _backView;
    UIButton * _cancleCollectionButton;//取消收藏按钮
    
    UIImageView * _userHeaderImageView;
    UILabel * _userNamelable;
    UIImageView * _timeLockImage;
    UILabel * _timeLable;
    UILabel * _commentlable;
    
    
    UIView * _view1;
    UIView * _view2;
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
    
    _userHeaderImageView = [[UIImageView alloc]init];
    _userNamelable = [[UILabel alloc]init];
    _timeLockImage = [[UIImageView alloc]init];
    _timeLable = [[UILabel alloc]init];
    _commentlable = [[UILabel alloc]init];
    
    [self.contentView addSubview:_backView];
    [_backView addSubview:_headerImage];
    [_backView addSubview:_goodsMessageLable];
    [_backView addSubview:_cateGory];
    [_backView addSubview:_GoodsNameLable];
    
    [_backView addSubview:_userHeaderImageView];
    [_backView addSubview:_userNamelable];
    [_backView addSubview:_timeLockImage];
    [_backView addSubview:_timeLable];
    [_backView addSubview:_commentlable];
    
    _view1 = [[UIView alloc]init];
    _view2 = [[UIView alloc]init];
    [_backView addSubview:_view1];
    [_backView addSubview:_view2];
}

// 当设置lable的字体的时候动态的改变lable的大小(动态的添加约束)
- (void)DTsetyueshu:(myCommentModel *)model
{
    // 告诉self.view约束需要更新
    [self.contentView setNeedsUpdateConstraints];
    // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
    [self.contentView updateConstraintsIfNeeded];
    [_backView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20 * scaleHeight);
        make.left.mas_equalTo(24 * scaleWidth);
        make.width.mas_equalTo(Screen_Width - 48 * scaleWidth);
        make.height.mas_equalTo(410 * scaleHeight);
    }];
   
    [_userHeaderImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40 * scaleWidth);
        make.top.mas_equalTo(20 * scaleHeight);
        make.width.mas_equalTo(50 * scaleWidth);
        make.height.mas_equalTo(50 * scaleWidth);
    }];
    _userHeaderImageView.layer.cornerRadius = 25 * scaleWidth;
    _userHeaderImageView.layer.masksToBounds = YES;
    
    [_userNamelable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_userHeaderImageView.mas_right).offset(20 * scaleHeight);
        make.centerY.mas_equalTo(_userHeaderImageView.mas_centerY);
        make.width.mas_equalTo(300 * scaleWidth);
    }];
    BaseLableSet(_userNamelable, 52, 52, 52, 28);
    
    
    [_timeLable mas_remakeConstraints:^(MASConstraintMaker *make) {
        _timeLable.adjustsFontSizeToFitWidth = YES;
        CGSize size = [[self getUTCFormateDate:model.commenttime] sizeWithFont:[UIFont systemFontOfSize:18] maxSize:CGSizeMake(999, 14 * scaleHeight)];
        make.right.mas_equalTo(-24 * scaleWidth);
        make.centerY.mas_equalTo(_userHeaderImageView.mas_centerY);
        make.height.mas_equalTo(size.height);
        make.width.mas_equalTo(size.width);
    }];
    BaseLableSet(_timeLable, 178, 178, 178, 24);
    [_timeLockImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(24 * scaleWidth);
        make.height.mas_equalTo(24 * scaleWidth);
        make.right.mas_equalTo(_timeLable.mas_left).offset(-2 * scaleWidth);
        make.centerY.mas_equalTo(_userHeaderImageView.mas_centerY);
    }];
    _timeLockImage.image = [UIImage imageNamed:@"grzx_wdpl_icon.jpg"];
    _timeLockImage.layer.cornerRadius = 12 * scaleWidth;
    _timeLockImage.layer.masksToBounds = YES;

    
    
    [_headerImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(114 * scaleHeight);
        make.left.mas_equalTo(40 * scaleWidth);
        make.width.mas_equalTo(110 * scaleWidth);
        make.height.mas_equalTo(110 * scaleHeight);
    }];
    [_GoodsNameLable mas_remakeConstraints:^(MASConstraintMaker *make) {
        CGSize size = [model.name sizeWithFont:[UIFont systemFontOfSize:21] maxSize:CGSizeMake(999, 28 * scaleHeight)];
        make.left.mas_equalTo(_headerImage.mas_right).offset(24 * scaleWidth);
        make.height.mas_equalTo(size.height);
        make.width.mas_equalTo(size.width + 5);
        make.top.mas_equalTo(114 * scaleHeight);
    }];
    
    [_cateGory mas_remakeConstraints:^(MASConstraintMaker *make) {
        CGSize size = [model.type sizeWithFont:[UIFont systemFontOfSize:21] maxSize:CGSizeMake(999, 28 * scaleHeight)];
        _cateGory.titleLabel.font = BaseFont(28);
        make.left.mas_equalTo(_GoodsNameLable.mas_right).offset(14 * scaleWidth);
        make.top.mas_equalTo(114 * scaleHeight);
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
    [_commentlable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(250 * scaleHeight);
        make.left.mas_equalTo(40 * scaleWidth);
        make.right.mas_equalTo(-40 * scaleWidth);
        make.height.mas_equalTo(160 * scaleHeight);
    }];
    _commentlable.numberOfLines = 0;
    BaseLableSet(_commentlable, 105, 105, 105, 28);
    
    
    [_view1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(90 * scaleHeight);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(3 * scaleHeight);
    }];
    _view1.backgroundColor = BaseColor(249, 249, 249, 1);
    [_view2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(250 * scaleHeight);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(3 * scaleHeight);
    }];
    _view2.backgroundColor = BaseColor(249, 249, 249, 1);
}

//- (void)setcs
//{
//    [_userHeaderImageView sd_setImageWithURL:[NSURL URLWithString:@"http://182.92.224.165/App/Images/product/4/e93e7d74633416743d743629a90308e2"] placeholderImage:[UIImage imageNamed:@"600.png"]];
//    _userNamelable.text = @"我是送小包";
//    _timeLable.text = @"2前";
//    _commentlable.text = @"撒发生纠纷后 会撒娇大会上";
//    [_headerImage sd_setImageWithURL:[NSURL URLWithString:@"http://182.92.224.165/App/Images/product/2/dfe1cc7e8e1065255c34edfe78215ffd"] placeholderImage:[UIImage imageNamed:@"600.png"]];
//    _GoodsNameLable.text = @"河南百通木瓜";
//    [_cateGory setTitle:@"水果" forState:UIControlStateNormal];
//    NSDictionary* style1 = @{@"body":[UIFont systemFontOfSize:18.0],
//                             @"bold":[UIFont boldSystemFontOfSize:18.0],
//                             @"red": BaseColor(255, 104, 104, 1),
//                             @"gray":BaseColor(178, 178, 178, 1)};
////    _goodsMessageLable.text = @"¥15.00/斤｜运费：包邮";
//    _goodsMessageLable.attributedText = [@"<red><bold>¥15.00</bold>/斤</red><gray>｜运费：包邮</gray>" attributedStringWithStyleBook:style1];
//}

- (void)setModel:(myCommentModel *)model
{
    NSDictionary * dict = [NSDictionary dictionaryWithContentsOfFile:UserMessageLocalAdress];

    [_userHeaderImageView sd_setImageWithURL:[NSURL URLWithString:dict[@"smallportraiturl"]] placeholderImage:[UIImage imageNamed:@"1080X1800.png"]];
    _userNamelable.text = dict[@"displayname"];
    _timeLable.text = [self getUTCFormateDate:model.commenttime];
    _commentlable.text = model.comment;
    [_headerImage sd_setImageWithURL:[NSURL URLWithString:model.bigportraiturl] placeholderImage:[UIImage imageNamed:@"1080X1800.png"]];
    _GoodsNameLable.text = model.name;
    [_cateGory setTitle:model.type forState:UIControlStateNormal];
    NSDictionary* style1 = @{@"body":[UIFont systemFontOfSize:18.0],
                             @"bold":[UIFont boldSystemFontOfSize:18.0],
                             @"red": BaseColor(255, 104, 104, 1),
                             @"gray":BaseColor(178, 178, 178, 1)};
    //    _goodsMessageLable.text = @"¥15.00/斤｜运费：包邮";
    _goodsMessageLable.attributedText = [[NSString stringWithFormat:@"<red><bold>¥%@</bold>/%@</red><gray>｜%@：%@</gray>", model.price, model.unit, NSLocalizedString(@"运费", @""),model.freight] attributedStringWithStyleBook:style1];
    [self DTsetyueshu:model];
}
-(NSString *)getUTCFormateDate:(NSString *)newsDate
{
    //    newsDate = @"2013-08-09 17:01";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //    NSLog(@"newsDate = %@",newsDate);
    NSDate *newsDateFormatted = [dateFormatter dateFromString:newsDate];
    // 获得系统时区
    NSTimeZone *tz = [NSTimeZone systemTimeZone];
    // 获得当前时间距离GMT时间相差的秒数!
    NSInteger seconds = [tz secondsFromGMTForDate:[NSDate
                                                   date]];
    NSDate * date2 = [NSDate dateWithTimeInterval:seconds sinceDate:newsDateFormatted];
    // 以[NSDate date]时间为基准,间隔seconds秒后的时间!
    NSDate *localDate = [NSDate dateWithTimeInterval:seconds sinceDate:[NSDate date]];
    
    NSTimeInterval time=[localDate timeIntervalSinceDate:date2];//间隔的秒数
    int month=((int)time)/(3600*24*30);
    int days=((int)time)/(3600*24);
    int hours=((int)time)%(3600*24)/3600;
    int minute=((int)time)%(3600*24)/60;
    
    NSString *dateContent;
    
    if(month!=0){
        
        dateContent = [NSString stringWithFormat:@"%@%i%@",@"   ",month,NSLocalizedString(@"月", @"")];
        
    }else if(days!=0){
        
        dateContent = [NSString stringWithFormat:@"%@%i%@",@"   ",days,NSLocalizedString(@"天", @"")];
    }else if(hours!=0){
        
        dateContent = [NSString stringWithFormat:@"%@%i%@",@"   ",hours,NSLocalizedString(@"时", @"")];
    }else {
        
        dateContent = [NSString stringWithFormat:@"%@%i%@",@"   ",minute,NSLocalizedString(@"分", @"")];
    }
    
    //    NSString *dateContent=[[NSString alloc] initWithFormat:@"%i天%i小时",days,hours];
    
    
    return dateContent;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
