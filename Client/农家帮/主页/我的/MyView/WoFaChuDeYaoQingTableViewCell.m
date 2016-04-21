//
//  WoFaChuDeYaoQingTableViewCell.m
//  农家帮
//
//  Created by Mac on 16/3/14.
//  Copyright © 2016年 jingqi. All rights reserved.
//

#import "WoFaChuDeYaoQingTableViewCell.h"

@implementation WoFaChuDeYaoQingTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _picture = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 44, 44)];
        _picture.layer.cornerRadius = 10;
        [self.contentView addSubview:_picture];
        
        _name = [[UILabel alloc] initWithFrame:CGRectMake(64, 0, Screen_Width-64, 64)];
        _name.textAlignment = NSTextAlignmentLeft;
        _name.font = [UIFont systemFontOfSize:21];
        _name.textColor = BaseColor(52, 52, 52, 0.6);
        _name.adjustsFontSizeToFitWidth = YES;
        [self.contentView  addSubview:_name];
        
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
