//
//  WoDeYouHuiQuanTableViewCell.m
//  农家帮
//
//  Created by Mac on 16/3/27.
//  Copyright © 2016年 jingqi. All rights reserved.
//

#import "WoDeYouHuiQuanTableViewCell.h"

@implementation WoDeYouHuiQuanTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _youhuiquanView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 280 * scaleHeight)];
        _youhuiquanView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_youhuiquanView];
        
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(49 * scaleWidth, 20 * scaleHeight, 623 * scaleWidth, 232 * scaleHeight)];
        imageView.image = [UIImage imageNamed:@"zjhb_ico_youhuijuan_youxiaozhong.jpg"];
        [_youhuiquanView addSubview:imageView];
        
        UIImageView *zhangImageView = [[UIImageView alloc] initWithFrame:CGRectMake(490 * scaleWidth, 20 * scaleHeight, 159 * scaleWidth, 176 * scaleHeight)];
        zhangImageView.image = [UIImage imageNamed:@"zjhh_ico_tuzhang_weishiyongHB.png"];
        [_youhuiquanView addSubview:zhangImageView];
        
        UIImageView *jiantouImageView = [[UIImageView alloc] initWithFrame:CGRectMake(680 * scaleWidth, 100 * scaleHeight, 25 * scaleWidth, 47 * scaleHeight)];
        jiantouImageView.image = [UIImage imageNamed:@"zjhb_btn_jiantou.jpg"];
        [_youhuiquanView addSubview:jiantouImageView];
        
        UILabel *youhuijia = [[UILabel alloc] initWithFrame:CGRectMake(84 * scaleWidth, 73 * scaleHeight, 130 * scaleWidth, 70 * scaleHeight)];
        youhuijia.font = [UIFont boldSystemFontOfSize:27.0];
        youhuijia.textColor = BaseColor(71, 176, 218, 1);
        youhuijia.text = @"100";
        [imageView addSubview:youhuijia];
        
        
        
        UILabel *shangpin = [[UILabel alloc] initWithFrame:CGRectMake(400 * scaleWidth, 25 * scaleHeight, 175 * scaleWidth, 70 * scaleHeight)];
        shangpin.font = [UIFont systemFontOfSize:16.0];
        shangpin.textColor = BaseColor(0, 0, 0, 1);
       
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
