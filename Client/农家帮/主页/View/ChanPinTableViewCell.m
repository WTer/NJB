//
//  ChanPinTableViewCell.m
//  农帮乐
//
//  Created by hpz on 15/12/11.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "ChanPinTableViewCell.h"

@implementation ChanPinTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createUI];
        
    }
    return self;
}
- (void)createUI {
    
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
    
    //产品详情
    _shuiguoDetailLabel = [[UILabel alloc] init];
    _shuiguoDetailLabel.textColor = BaseColor(105, 105, 105, 1);
    _shuiguoDetailLabel.font = [UIFont systemFontOfSize:18.0];
    [self.contentView addSubview:_shuiguoDetailLabel];
    
}
- (void)configWithDictionary:(NSDictionary *)dict {
    
    //产品名称
    _shuiguoNameLabel.text = dict[@"name"];
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
        _shuiguoNameLabel.frame = CGRectMake(24 * scaleWidth, 40 * scaleHeight, 632 * scaleWidth, sizeLabel.height * count);
    }
    else {
        
        _shuiguoNameLabel.frame = CGRectMake(24 * scaleWidth, 40 * scaleHeight, sizeLabel.width, sizeLabel.height);
    }
    _shuiguoNameLabel.numberOfLines = 0;
    
    //产品类型
    [_shuiguoBtn setTitle:dict[@"type"] forState:UIControlStateNormal];
    CGSize sizeBtn = [_shuiguoBtn.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:22 * 0.75] maxSize:CGSizeMake(990, 100)];
    _shuiguoBtn.frame = CGRectMake(sizeLabel.width + 20 * scaleWidth, 40 * scaleHeight, sizeBtn.width, sizeBtn.height);
    
    //产品详情
    _shuiguoDetailLabel.text = [NSString stringWithFormat:@"%@",dict[@"description"]];
    CGSize sizeDetailLabel = [_shuiguoDetailLabel.text sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(990, 100)];
    if (sizeDetailLabel.width >= 990) {
        sizeDetailLabel.height = sizeDetailLabel.height * 0.5;
    }
    NSInteger detailCount = 1;
    for (NSInteger i = 0; sizeDetailLabel.width >= 632 * scaleWidth; i++) {
        detailCount++;
        sizeDetailLabel.width -= 632 * scaleWidth;
    }
    if (detailCount > 1) {
        _shuiguoDetailLabel.frame = CGRectMake(20 * scaleWidth, 60 * scaleHeight + _shuiguoNameLabel.frame.size.height, 632 * scaleWidth, sizeDetailLabel.height * detailCount);
    }
    else {
        
        _shuiguoDetailLabel.frame = CGRectMake(20 * scaleWidth, 60 * scaleHeight + _shuiguoNameLabel.frame.size.height, sizeDetailLabel.width, sizeDetailLabel.height);
    }
    _shuiguoDetailLabel.numberOfLines = 0;
    
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 90 * scaleHeight + sizeLabel.height * count + sizeDetailLabel.height * detailCount - 1, Screen_Width, 1)];
    label.backgroundColor = BaseColor(242, 242, 242, 1);
    [self.contentView addSubview:label];
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
