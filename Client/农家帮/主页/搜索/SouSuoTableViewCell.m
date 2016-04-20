//
//  SouSuoTableViewCell.m
//  农帮乐
//
//  Created by hpz on 15/12/17.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "SouSuoTableViewCell.h"

@implementation SouSuoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createUI];
        
    }
    return self;
}
- (void)createUI {

    _picImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_picImageView];
    //产品名称
    _shuiguoNameLabel = [[UILabel alloc] init];
    _shuiguoNameLabel.textColor = BaseColor(52, 52, 52, 1);
    [self.contentView addSubview:_shuiguoNameLabel];
    
    
    //产品类型
    _shuiguoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_shuiguoBtn setTitleColor:BaseColor(14, 184, 58, 1) forState:UIControlStateNormal];
    _shuiguoBtn.titleLabel.font = [UIFont systemFontOfSize:22 * 0.75];
    [_shuiguoBtn setBackgroundImage:[UIImage imageWithData:UIImagePNGRepresentation([UIImage imageNamed:@"zy_icon_shuiguo.jpg"])] forState:UIControlStateNormal];
    [self.contentView addSubview:_shuiguoBtn];
    
    //产品价格和运费
    _shuiguoPriceLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_shuiguoPriceLabel];
    
    
    
}
- (void)configWithDictionary:(NSDictionary *)dict {

    NSDictionary *ProductInfoDict = dict[@"ProductInfo"];
    NSArray *ProductImagesArray = dict[@"ProductImages"];
     CGSize sizeLabel = [ProductInfoDict[@"name"] sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(999, 100)];
     CGSize sizePrice = [[NSString stringWithFormat:@"<fuhao>¥</fuhao><price>%@</price><type>/%@</type> <yunfei>| 运费:%@</yunfei>",ProductInfoDict[@"price"], ProductInfoDict[@"unit"], ProductInfoDict[@"freight"]] sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(999, 100)];
     _picImageView.frame = CGRectMake(40 * scaleWidth, 20 * scaleHeight, 50 * scaleHeight + sizeLabel.height + sizePrice.height,50 * scaleHeight + sizeLabel.height+ sizePrice.height);
    if (ProductImagesArray.count) {
        NSDictionary *smallportraiturlDict = ProductImagesArray[0];
        [_picImageView sd_setImageWithURL:[NSURL URLWithString:smallportraiturlDict[@"smallportraiturl"]] placeholderImage:[UIImage imageNamed:@""]];
    }
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 100 * scaleWidth + sizeLabel.height + sizePrice.height - 1, Screen_Width, 1)];
    label.backgroundColor = BaseColor(242, 242, 242, 1);
    [self.contentView addSubview:label];
    
    //产品名称
    _shuiguoNameLabel.text = ProductInfoDict[@"name"];
    NSInteger count = 1;
    CGFloat width = sizeLabel.width;
    for (NSInteger i = 0; width >= 632 * scaleWidth; i++) {
        count++;
        width -= 632 * scaleWidth;
    }
    if (count > 1) {
        _shuiguoNameLabel.frame = CGRectMake(60 * scaleWidth + _picImageView.frame.size.width, 20 * scaleHeight, 632 * scaleWidth, sizeLabel.height * count);
    }
    else {
        
        _shuiguoNameLabel.frame = CGRectMake(60 * scaleWidth + _picImageView.frame.size.width, 20 * scaleHeight, sizeLabel.width, sizeLabel.height);
    }
    _shuiguoNameLabel.numberOfLines = 0;
    
    
    //产品类型
    [_shuiguoBtn setTitle:ProductInfoDict[@"type"] forState:UIControlStateNormal];
    CGSize sizeBtn = [_shuiguoBtn.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:22 * 0.75] maxSize:CGSizeMake(999, 1000)];
    _shuiguoBtn.frame = CGRectMake(60 * scaleWidth + _picImageView.frame.size.width + sizeLabel.width + 10 * scaleWidth, 30 * scaleHeight, sizeBtn.width, sizeBtn.height);
    
    
    
    //产品价格和运费
    NSDictionary* priceStyle = @{@"fuhao" :@[[UIFont fontWithName:@"HelveticaNeue" size:21.0],BaseColor(255, 104, 104, 1)],
                                 @"price" :@[[UIFont fontWithName:@"HelveticaNeue-Bold" size:21.0],BaseColor(255, 104, 104, 1)],
                                 @"type" :@[[UIFont fontWithName:@"HelveticaNeue" size:21.0],BaseColor(255, 104, 104, 1)],
                                 @"yunfei":@[[UIFont fontWithName:@"HelveticaNeue" size:21.0],BaseColor(105, 105, 105, 1)]};
    _shuiguoPriceLabel.text = ProductInfoDict[@"price"];
    _shuiguoPriceLabel.attributedText = [[NSString stringWithFormat:@"<fuhao>¥</fuhao><price>%@</price><type>/%@</type> <yunfei>| 运费:%@</yunfei>",ProductInfoDict[@"price"], ProductInfoDict[@"unit"], ProductInfoDict[@"freight"]] attributedStringWithStyleBook:priceStyle];
    _shuiguoPriceLabel.frame = CGRectMake(60 * scaleWidth + _picImageView.frame.size.width, 60 * scaleHeight + _shuiguoNameLabel.frame.size.height, sizePrice.width, sizePrice.height);
    
   
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
