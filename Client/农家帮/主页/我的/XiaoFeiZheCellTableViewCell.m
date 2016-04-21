//
//  XiaoFeiZheCellTableViewCell.m
//  农家帮
//
//  Created by 赵波 on 16/3/6.
//  Copyright © 2016年 jingqi. All rights reserved.
//

#import "XiaoFeiZheCellTableViewCell.h"

@interface XiaoFeiZheCellTableViewCell ()

@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *name;

@end

@implementation XiaoFeiZheCellTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 44, 44)];
        [self.contentView addSubview:_image];
        
        _name = [[UILabel alloc] initWithFrame:CGRectMake(64, 0, Screen_Width-64, 64)];
        _name.textAlignment = NSTextAlignmentLeft;
        _name.font = [UIFont systemFontOfSize:21];
        _name.textColor = BaseColor(52, 52, 52, 0.6);
        _name.adjustsFontSizeToFitWidth = YES;
        [self.contentView  addSubview:_name];
        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(Screen_Width-100, 10, 84, 44);
        button.backgroundColor = [UIColor greenColor];
        button.layer.cornerRadius = 5.0f;
        button.layer.masksToBounds = YES;
        [button setTitle:@"发送邀请" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.contentView addSubview:button];
        [button addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setModel:(XiaoFeiZheModel *)model
{
    _model = model;
    [self.image sd_setImageWithURL:[NSURL URLWithString:model.smallportraiturl]];
    _name.text = model.displayname;
}

- (void)action:(UIControl *)sender
{
    if (_delegate) {
        [_delegate yaoQingXiaoFeiZheCell:self];
    }
}

@end
