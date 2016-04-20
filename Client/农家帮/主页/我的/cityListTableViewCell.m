//
//  cityListTableViewCell.m
//  农帮乐
//
//  Created by 王朝源 on 15/12/18.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "cityListTableViewCell.h"

@implementation cityListTableViewCell
{
    UIButton * _button;
    UIButton * _button2;
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
    
    _cityLable = [[UILabel alloc]init];
    [self.contentView addSubview:_cityLable];
    [_cityLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40 * scaleWidth);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(self.contentView.mas_height);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    _cityLable.textColor = [UIColor blackColor];
    
    _selectedButton = [[UIButton alloc]init];
    [self.contentView addSubview:_selectedButton];
    [_selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-40 * scaleWidth);
        make.width.height.mas_equalTo(40 * scaleWidth);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    [_selectedButton setImage:[UIImage imageNamed:@"grzx_wddd_radio_nor.png"]forState:UIControlStateNormal];
    [_selectedButton setImage:[UIImage imageNamed:@"grzx_wddd_radio_sel.png"]forState:UIControlStateSelected];
    _selectedButton.userInteractionEnabled = NO;
    
    _button2 = _selectedButton;
    _button = [[UIButton alloc]init];
    _button.frame = self.contentView.frame;
    [self.contentView addSubview:_button];
    [_button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
}

- (void)click
{
    _block(_button2);
}

-(void)cellBeClick:(myBlock)block
{
    _block = block;
}

//- (void)click:(UIButton *)button
//{
//    button.selected = YES;
//}
//    

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
