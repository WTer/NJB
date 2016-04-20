//
//  FaSongHongBaoCell.m
//  农家帮
//
//  Created by Mac on 16/4/11.
//  Copyright © 2016年 jingqi. All rights reserved.
//

#import "FaSongHongBaoCell.h"

@implementation FaSongHongBaoCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    _IsSelectedButton = [[UIButton alloc]initWithFrame:CGRectMake(16 * scaleWidth, 25 * scaleHeight, 19 * scaleWidth, 19 * scaleWidth)];
    _IsSelectedButton.layer.borderColor = [UIColor grayColor].CGColor;
    _IsSelectedButton.layer.borderWidth = 1;
    _IsSelectedButton.layer.cornerRadius = 19 * scaleWidth / 2;
    [self.contentView addSubview:_IsSelectedButton];
    [_IsSelectedButton addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
    [_IsSelectedButton setBackgroundImage:nil forState:UIControlStateNormal];
    [_IsSelectedButton setBackgroundImage:[UIImage imageNamed:@"zjhy_ico_xuanzhong.jpg"] forState:UIControlStateSelected];
    
    _headerImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(60 * scaleWidth, 4.5 * scaleHeight, 60 * scaleHeight, 60 * scaleHeight)];
    [self.contentView addSubview:_headerImageView];
    
    
    _nameLable = [[UILabel alloc]initWithFrame:CGRectMake(135 * scaleWidth, 15 * scaleHeight, 350 * scaleWidth, 40  *scaleHeight)];
    _nameLable.font = BaseFont(22);
    _nameLable.textColor = BaseColor(43, 43, 43, 1);
    [self.contentView addSubview:_nameLable];
}

- (void)buttonclick:(UIButton * )button
{
    
    button.selected =! button.selected;
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
