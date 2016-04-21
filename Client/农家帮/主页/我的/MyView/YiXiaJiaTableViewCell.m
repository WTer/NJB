//
//  YiXiaJiaTableViewCell.m
//  农家帮
//
//  Created by Mac on 16/3/10.
//  Copyright © 2016年 jingqi. All rights reserved.
//

#import "YiXiaJiaTableViewCell.h"

@implementation YiXiaJiaTableViewCell
{
    UIImageView *_bgIamgeView;
    
    NSArray *_ProductImages;
    NSDictionary *_ProductInfo;
    NSDictionary *_ProducerInfo;
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = BaseColor(242, 242, 242, 1);
        
        _bgIamgeView = [[UIImageView alloc]init];
        _bgIamgeView.image = [UIImage imageWithData:UIImagePNGRepresentation([UIImage imageNamed:@"zy_bg（农场直供-带线）.jpg"])];
        
        
        _bgIamgeView.userInteractionEnabled = YES;
        [self.contentView addSubview:_bgIamgeView];
        
        [self createUI];
    }
    return self;
}
- (void)createUI {
    
    //时间Label
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 * scaleWidth, 20 * scaleHeight, 680 * scaleWidth, 80 * scaleHeight)];
    [_bgIamgeView addSubview:_timeLabel];
    
    
    //产品名称
    _shuiguoNameLabel = [[UILabel alloc] init];
    _shuiguoNameLabel.textColor = BaseColor(52, 52, 52, 1);
    [_bgIamgeView addSubview:_shuiguoNameLabel];
    
    
    //产品类型
    _shuiguoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_shuiguoBtn setTitleColor:BaseColor(14, 184, 58, 1) forState:UIControlStateNormal];
    _shuiguoBtn.titleLabel.font = [UIFont systemFontOfSize:22 * 0.75];
    [_shuiguoBtn setBackgroundImage:[UIImage imageWithData:UIImagePNGRepresentation([UIImage imageNamed:@"zy_icon_shuiguo.jpg"])] forState:UIControlStateNormal];
    [_bgIamgeView addSubview:_shuiguoBtn];
    
    //产品详情
    _shuiguoDetailLabel = [[UILabel alloc] init];
    _shuiguoDetailLabel.textColor = BaseColor(105, 105, 105, 1);
    _shuiguoDetailLabel.font = [UIFont systemFontOfSize:18.0];
    [_bgIamgeView addSubview:_shuiguoDetailLabel];
    
    //产品价格和运费
    _shuiguoPriceLabel = [[UILabel alloc] init];
    [_bgIamgeView addSubview:_shuiguoPriceLabel];
    
    
}

- (void)configWithDictionary:(NSDictionary *)dict withAll:(BOOL)isAll {
    
    //时间
    NSDictionary* style = @{@"body" :@[[UIFont fontWithName:@"HelveticaNeue" size:18.0],BaseColor(178, 178, 178, 1)],
                            @"asd" :@[[UIFont fontWithName:@"HelveticaNeue" size:16.0],[UIColor blueColor]],
                            @"shijian":[UIImage imageWithData:UIImagePNGRepresentation([UIImage imageNamed:@"zy_icon_shijian.jpg"])] };
    TimeString *timeStr = [[TimeString alloc] init];
    //2015-12-18 15:33:25
    if (isAll) {
    
        _timeLabel.attributedText = [[NSString stringWithFormat:@"<shijian> </shijian>  <asd>发布时间</asd> :%@", [timeStr getDayTimeFromLastmodifiedtime:dict[@"lastmodifiedtime"]]]attributedStringWithStyleBook:style];
        
    }
    else {
    
        _timeLabel.attributedText = [[NSString stringWithFormat:@"<shijian> </shijian>  <asd>下架时间</asd> :%@", [timeStr getDayTimeFromLastmodifiedtime:dict[@"lastmodifiedtime"]]]attributedStringWithStyleBook:style];
    }
    
    
    //产品名称
    _shuiguoNameLabel.text = [NSString stringWithFormat:@"%@",dict[@"name"]];
    CGSize sizeLabel = [_shuiguoNameLabel.text sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(990, 100)];
    if (sizeLabel.width >= 990) {
        sizeLabel.height = sizeLabel.height * 0.5;
    }
    NSInteger count = 1;
    CGFloat width = sizeLabel.width;
    for (NSInteger i = 0; width >= 632 * scaleWidth; i++) {
        count++;
        width -= 632 * scaleWidth;
    }
    if (count > 1) {
        _shuiguoNameLabel.frame = CGRectMake(20 * scaleWidth, 120 * scaleHeight, 632 * scaleWidth, sizeLabel.height * count);
    }
    else {
        
        _shuiguoNameLabel.frame = CGRectMake(20 * scaleWidth, 120 * scaleHeight, sizeLabel.width, sizeLabel.height);
    }
    _shuiguoNameLabel.numberOfLines = 0;
    
    
    
    //产品类型
    [_shuiguoBtn setTitle:[NSString stringWithFormat:@"%@",dict[@"type"]] forState:UIControlStateNormal];
    CGSize sizeBtn = [_shuiguoBtn.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:22 * 0.75] maxSize:CGSizeMake(990, 1000)];
    _shuiguoBtn.frame = CGRectMake(sizeLabel.width + 20 * scaleWidth, 130 * scaleHeight, sizeBtn.width, sizeBtn.height);
    
    
    //产品详情
    _shuiguoDetailLabel.text = [NSString stringWithFormat:@"%@",dict[@"description"]];
    CGSize sizeDetailLabel = [_shuiguoDetailLabel.text sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(990, 1000)];
    if (sizeDetailLabel.width >= 990) {
        sizeDetailLabel.height = sizeDetailLabel.height * 0.5;
    }
    NSInteger detailCount = 1;
    for (NSInteger i = 0; sizeDetailLabel.width >= 632 * scaleWidth; i++) {
        detailCount++;
        sizeDetailLabel.width -= 632 * scaleWidth;
    }
    if (detailCount > 1) {
        _shuiguoDetailLabel.frame = CGRectMake(20 * scaleWidth, 150 * scaleHeight + _shuiguoNameLabel.frame.size.height, 632 * scaleWidth, sizeDetailLabel.height * detailCount);
    }
    else {
        
        _shuiguoDetailLabel.frame = CGRectMake(20 * scaleWidth, 150 * scaleHeight + _shuiguoNameLabel.frame.size.height, sizeDetailLabel.width, sizeDetailLabel.height);
    }
    _shuiguoDetailLabel.numberOfLines = 0;
    
    
    //产品价格和运费
    NSDictionary* priceStyle = @{@"fuhao" :@[[UIFont fontWithName:@"HelveticaNeue" size:27.0],BaseColor(255, 104, 104, 1)],
                                 @"price" :@[[UIFont fontWithName:@"HelveticaNeue-Bold" size:27.0],BaseColor(255, 104, 104, 1)],
                                 @"type" :@[[UIFont fontWithName:@"HelveticaNeue" size:18.0],BaseColor(255, 104, 104, 1)],
                                 @"yunfei":@[[UIFont fontWithName:@"HelveticaNeue" size:18.0],BaseColor(105, 105, 105, 1)]};
    _shuiguoPriceLabel.text = dict[@"price"];
    _shuiguoPriceLabel.attributedText = [[NSString stringWithFormat:@"<fuhao>¥</fuhao><price>%@</price><type>/%@</type> <yunfei>| 运费:%@</yunfei>",dict[@"price"], dict[@"unit"], dict[@"freight"]] attributedStringWithStyleBook:priceStyle];
    CGSize sizePrice = [_shuiguoPriceLabel.text sizeWithFont:[UIFont systemFontOfSize:27.0] maxSize:CGSizeMake(990, 100)];
    _shuiguoPriceLabel.frame = CGRectMake(20 * scaleWidth, 170 * scaleHeight + _shuiguoNameLabel.frame.size.height + _shuiguoDetailLabel.frame.size.height, sizePrice.width - 250 * scaleWidth, sizePrice.height - 15 * scaleHeight);
    _shuiguoPriceLabel.adjustsFontSizeToFitWidth = YES;
    
    
   
    
    _bgIamgeView.frame = CGRectMake(24 * scaleWidth, 20 * scaleHeight, Screen_Width - 48 * scaleWidth, 220 * scaleHeight + _shuiguoNameLabel.frame.size.height + _shuiguoDetailLabel.frame.size.height + _shuiguoPriceLabel.frame.size.height);
    
    
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
