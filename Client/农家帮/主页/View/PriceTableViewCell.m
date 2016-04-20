//
//  PriceTableViewCell.m
//  农帮乐
//
//  Created by hpz on 15/12/11.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "PriceTableViewCell.h"
#import "LiaoTianJieMianViewController.h"

@implementation PriceTableViewCell
{
    UIView *_youhuiquanView;
    NSString *_name;
    NSDictionary *_ProducerInfoDict;
    NSDictionary *_ProductInfoDict;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createUI];
        
    }
    return self;
}
- (void)createUI {
    
    _shuiguoPriceLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_shuiguoPriceLabel];
    _shuiguooriginalPriceLabel = [[UILabel alloc] init];
    _shuiguooriginalPriceLabel.textColor = BaseColor(52, 52, 52, 1);
    [self.contentView addSubview:_shuiguooriginalPriceLabel];
    _shuiguoNumberLabel = [[UILabel alloc] init];
    _shuiguoNumberLabel.textColor = BaseColor(178, 178, 178, 1);
    _shuiguoNumberLabel.font = [UIFont systemFontOfSize:18.0];
    [self.contentView addSubview:_shuiguoNumberLabel];
    
}
- (void)configWithDictionary:(NSArray *)array {

    if (array.count == 2) {
        _ProducerInfoDict = array[0];
        _ProductInfoDict = array[1];
        
        _name = [NSString stringWithFormat:@"%@",_ProductInfoDict[@"name"]];
        
        NSDictionary* priceStyle = @{@"fuhao" :@[[UIFont fontWithName:@"HelveticaNeue" size:27.0
                                                  ],BaseColor(255, 104, 104, 1)],
                                     @"price" :@[[UIFont fontWithName:@"HelveticaNeue-Bold" size:27.0],BaseColor(255, 104, 104, 1)],
                                     @"type" :@[[UIFont fontWithName:@"HelveticaNeue" size:18.0],BaseColor(255, 104, 104, 1)]};
        _shuiguoPriceLabel.text = _ProductInfoDict[@"price"];
        _shuiguoPriceLabel.attributedText = [[NSString stringWithFormat:@"<fuhao>¥</fuhao><price>%@</price><type>/%@</type>",_ProductInfoDict[@"price"], _ProductInfoDict[@"unit"]] attributedStringWithStyleBook:priceStyle];
        CGSize sizePrice = [_shuiguoPriceLabel.text sizeWithFont:[UIFont systemFontOfSize:27.0] maxSize:CGSizeMake(999, 100)];
        
        
        _shuiguooriginalPriceLabel.text = [NSString stringWithFormat:@"原价:￥%@", _ProductInfoDict[@"originalprice"]];
        CGSize sizeoriginalPrice = [_shuiguooriginalPriceLabel.text sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(999, 100)];
        [_shuiguooriginalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-20 * scaleWidth);
            make.top.mas_equalTo(40 * scaleHeight);
            make.size.mas_equalTo(CGSizeMake(sizeoriginalPrice.width - 40 * scaleWidth, sizeoriginalPrice.height));
        }];
        
        
        _shuiguoPriceLabel.frame = CGRectMake(24 * scaleWidth, 40 * scaleHeight, sizePrice.width, sizePrice.height);
        
        
        //优惠券
        UIButton *youhuiquanBtn = [[UIButton alloc] init];
        [youhuiquanBtn setBackgroundImage:[UIImage imageNamed:@"cpxq_btn_youhuijuan.png"] forState:UIControlStateNormal];
        [youhuiquanBtn addTarget:self action:@selector(youhuiquan) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:youhuiquanBtn];
        [youhuiquanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-30 * scaleWidth);
            make.top.mas_equalTo(50 * scaleHeight + sizeoriginalPrice.height);
            make.size.mas_equalTo(CGSizeMake(90 * scaleWidth, 41 * scaleHeight));
        }];
        //私聊
        UIButton *siliaoBtn = [[UIButton alloc] init];
        [siliaoBtn setBackgroundImage:[UIImage imageNamed:@"cpxq_btn_siliao.png"] forState:UIControlStateNormal];
        [siliaoBtn addTarget:self action:@selector(siliao) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:siliaoBtn];
        [siliaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-30 * scaleWidth);
            make.top.mas_equalTo(101 * scaleHeight + sizeoriginalPrice.height);
            make.size.mas_equalTo(CGSizeMake(119 * scaleWidth, 39 * scaleHeight));
        }];
        
        
        
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, sizeoriginalPrice.height * 0.5 - 1, sizeoriginalPrice.width - 50 * scaleWidth, 1)];
        line.backgroundColor = [UIColor blackColor];
        [_shuiguooriginalPriceLabel addSubview:line];
        
        //6.4 农场主订单总数查询
        _shuiguoNumberLabel.text = [NSString stringWithFormat:@"已售出  %@ | 运费:￥%@",_ProductInfoDict[@"unit"],_ProductInfoDict[@"freight"]];
        [_shuiguoNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(24 * scaleWidth);
            make.bottom.mas_equalTo(-30 * scaleWidth);
            make.top.mas_equalTo(_shuiguoPriceLabel.mas_bottom).offset(34 * scaleHeight);
        }];
        
        
        CGSize size = [_shuiguoNumberLabel.text sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(999, 100)];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 104 * scaleHeight + _shuiguoPriceLabel.frame.size.height + size.height - 1, Screen_Width, 1)];
        label.backgroundColor = BaseColor(242, 242, 242, 1);
        [self.contentView addSubview:label];
    }

    
}
//私聊
- (void)siliao {
    
    LiaoTianJieMianViewController *liaotianjiemianVC = [[LiaoTianJieMianViewController alloc] init];
    liaotianjiemianVC.producerId = [NSString stringWithFormat:@"%@",_ProductInfoDict[@"producerid"]];
    liaotianjiemianVC.name = [NSString stringWithFormat:@"%@",_ProducerInfoDict[@"displayname"]];
    liaotianjiemianVC.touxiang = [NSString stringWithFormat:@"%@",_ProducerInfoDict[@"smallportraiturl"]];
    [self.viewController.navigationController pushViewController:liaotianjiemianVC animated:YES];

}
 //优惠券
- (void)youhuiquan {

    self.viewController.tableView.alpha = 0.1;
    self.viewController.tableView.userInteractionEnabled = NO;
    _youhuiquanView = [[UIView alloc] initWithFrame:CGRectMake(0, Screen_Height - 64 - 363 * scaleHeight, Screen_Width, 363 * scaleHeight)];
    _youhuiquanView.backgroundColor = [UIColor whiteColor];
    [self.viewController.view addSubview:_youhuiquanView];
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 1)];
    line.backgroundColor = BaseColor(233, 233, 233, 1);
    [_youhuiquanView addSubview:line];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(49 * scaleWidth, 20 * scaleHeight, 623 * scaleWidth, 232 * scaleHeight)];
    imageView.image = [UIImage imageNamed:@"cpxq_ico_youhuijuan.jpg"];
    [_youhuiquanView addSubview:imageView];
    
    UILabel *fuhao = [[UILabel alloc] initWithFrame:CGRectMake(30 * scaleWidth, 110 * scaleHeight, 35 * scaleWidth, 39 * scaleHeight)];
    fuhao.font = [UIFont systemFontOfSize:14.0];
    fuhao.textColor = BaseColor(71, 176, 218, 1);
    fuhao.text = @"￥";
    [imageView addSubview:fuhao];
    

    UILabel *youhuijia = [[UILabel alloc] initWithFrame:CGRectMake(84 * scaleWidth, 73 * scaleHeight, 130 * scaleWidth, 70 * scaleHeight)];
    youhuijia.font = [UIFont boldSystemFontOfSize:27.0];
    youhuijia.textColor = BaseColor(71, 176, 218, 1);
    youhuijia.text = @"100";
    [imageView addSubview:youhuijia];
    
    
    
    UILabel *shangpin = [[UILabel alloc] initWithFrame:CGRectMake(400 * scaleWidth, 25 * scaleHeight, 175 * scaleWidth, 70 * scaleHeight)];
    shangpin.font = [UIFont systemFontOfSize:16.0];
    shangpin.textColor = BaseColor(0, 0, 0, 1);
    shangpin.text = _name;
    shangpin.textAlignment = NSTextAlignmentCenter;
    [imageView addSubview:shangpin];
    
    UILabel *keyong = [[UILabel alloc] initWithFrame:CGRectMake(400 * scaleWidth, 107 * scaleHeight, 175 * scaleWidth, 70 * scaleHeight)];
    keyong.font = [UIFont systemFontOfSize:16.0];
    keyong.textColor = BaseColor(0, 0, 0, 1);
    keyong.text = @"满200可用";
    keyong.textAlignment = NSTextAlignmentCenter;
    [imageView addSubview:keyong];
    
    
    
    
    UILabel *tishi = [[UILabel alloc] initWithFrame:CGRectMake(75 * scaleWidth, 217 * scaleHeight, 300 * scaleWidth, 25 * scaleHeight)];
    tishi.font = [UIFont systemFontOfSize:9.0];
    tishi.textColor = BaseColor(66, 66, 66, 1);
    tishi.text = NSLocalizedString(@"This coupon is only for this product before use", @"");
    [_youhuiquanView addSubview:tishi];
    
    UILabel *shijian = [[UILabel alloc] initWithFrame:CGRectMake(400 * scaleWidth, 217 * scaleHeight, 250 * scaleWidth, 25 * scaleHeight)];
    shijian.font = [UIFont systemFontOfSize:9.0];
    shijian.textColor = BaseColor(66, 66, 66, 1);
    shijian.text = @"2016.03.18-2016.03.30";
    [_youhuiquanView addSubview:shijian];
    
    
    UIButton *queding = [[UIButton alloc] initWithFrame:CGRectMake(89 * scaleWidth, 272 * scaleHeight, 543 * scaleWidth, 80 * scaleHeight)];
    [queding setBackgroundImage:[UIImage imageNamed:@"fbsp_btn_baocun_down.png"] forState:UIControlStateNormal];
    [queding setTitle:NSLocalizedString(@"OK", @"") forState:UIControlStateNormal];
    [queding addTarget:self action:@selector(queding) forControlEvents:UIControlEventTouchUpInside];
    [_youhuiquanView addSubview:queding];
    
    

}
- (void)queding {

    self.viewController.tableView.alpha = 1;
    self.viewController.tableView.userInteractionEnabled = YES;
    [_youhuiquanView removeFromSuperview];
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
