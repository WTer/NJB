//
//  SelectDiZhiTableViewCell.m
//  农帮乐
//
//  Created by hpz on 15/12/15.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "SelectDiZhiTableViewCell.h"

@implementation SelectDiZhiTableViewCell
{
    UIButton *_selectBtn;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createUI];
        
    }
    return self;
    
}
- (void)createUI {
    
    _selectBtn = [[UIButton alloc] initWithFrame:CGRectMake(24 * scaleWidth, 32 * scaleHeight, 38 * scaleWidth, 38 * scaleHeight)];
    [_selectBtn setBackgroundImage:[UIImage imageNamed:@"shdz4_pop_radio_nor.png"] forState:UIControlStateNormal];
    [_selectBtn setBackgroundImage:[UIImage imageNamed:@"shdz4_pop_radio_sel.png"] forState:UIControlStateSelected];
    [self.contentView addSubview:_selectBtn];
    
    _dizhiLabel = [[UILabel alloc] initWithFrame:CGRectMake(102 * scaleWidth, 32 * scaleHeight, 438 * scaleWidth, 38 * scaleHeight)];
    _dizhiLabel.font = [UIFont systemFontOfSize:18.0];
    _dizhiLabel.textColor = BaseColor(52, 52, 52, 1);
    [self.contentView addSubview:_dizhiLabel];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
