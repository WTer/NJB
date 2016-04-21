//
//  PingLunTableViewCell.m
//  农帮乐
//
//  Created by hpz on 15/12/11.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "PingLunTableViewCell.h"

@implementation PingLunTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createUI];
        
    }
    return self;
}
- (void)createUI {

    /**********头像***********/
    _icon = [[UIImageView alloc] init];
    _icon.layer.cornerRadius = 30 * scaleWidth;
    _icon.layer.masksToBounds = YES;
    [self.contentView addSubview:_icon];
    //代码给_icon添加约束
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20 * scaleWidth);
        make.top.mas_equalTo(20 * scaleHeight);
        make.size.mas_equalTo(CGSizeMake(60 * scaleWidth, 60 * scaleHeight));
        
    }];
    
    /**********昵称***********/
    //昵称的size是400 * 100;
    _niChengLabel = [[UILabel alloc] init];
    _niChengLabel.font = [UIFont systemFontOfSize:21.0];
    _niChengLabel.textColor = BaseColor(52, 52, 52, 1);
    [self.contentView addSubview:_niChengLabel];
    
    //时间Label
    _timeLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_timeLabel];
    
    
    //代码给_timeLabel添加约束
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20 * scaleWidth);
        make.top.mas_equalTo(20 * scaleHeight);
        
    }];
    
    //评论Label
    _commentLabel = [[UILabel alloc] init];
    _commentLabel.textColor = BaseColor(105, 105, 105, 1);
    _commentLabel.font = [UIFont systemFontOfSize:18.0];
    [self.contentView addSubview:_commentLabel];

    
}
- (void)configWithDictionary:(NSDictionary *)dict {

    //头像
    NSString *iconStr = dict[@"smallportraiturl"];
    if (iconStr.length) {
        [_icon sd_setImageWithURL:[NSURL URLWithString:iconStr] placeholderImage:[UIImage imageNamed:@""]];
    }
    else {
        _icon.image = [UIImage imageNamed:@"zhuce3_btn_shezhitouxiang_n.png"];
    }
    
    //昵称
    CGSize size = [dict[@"displayname"] sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(999, 100)];
    if (size.width >= 990) {
        size.height = size.height * 0.5;
    }
    NSInteger num = 1;
    CGFloat widthNum = size.width;
    for (NSInteger i = 0; widthNum >= 632 * scaleWidth; i++) {
        num++;
        widthNum -= 632 * scaleWidth;
    }
    if (num > 1) {
        _niChengLabel.frame = CGRectMake(100 * scaleWidth, 20 * scaleHeight, 580 * scaleWidth - _timeLabel.frame.size.width, size.height * num);
    }
    else {
        
        _niChengLabel.frame = CGRectMake(100 * scaleWidth, 20 * scaleHeight, size.width, size.height);
    }
    _niChengLabel.text = dict[@"displayname"];
    _niChengLabel.numberOfLines = 0;
    
    //时间
    NSDictionary* style = @{@"body" :@[[UIFont fontWithName:@"HelveticaNeue" size:18.0],BaseColor(178, 178, 178, 1)],
                            @"shijian":[UIImage imageWithData:UIImagePNGRepresentation([UIImage imageNamed:@"zy_icon_shijian.jpg"])] };
    TimeString *timeStr = [[TimeString alloc] init];
    _timeLabel.attributedText = [[NSString stringWithFormat:@"<shijian> </shijian>  %@", [timeStr getDayTimeFromLastmodifiedtime:dict[@"lastmodifiedtime"]]]attributedStringWithStyleBook:style];
    
    //评论内容
    CGSize sizeLabel = [dict[@"comment"] sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(999, 100)];
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
        _commentLabel.frame = CGRectMake(100 * scaleWidth, 40 * scaleHeight +  size.height * num, 600 * scaleWidth, sizeLabel.height * count);
    }
    else {
        
        _commentLabel.frame = CGRectMake(100 * scaleWidth, 40 * scaleHeight + size.height * num, sizeLabel.width, sizeLabel.height);
    }
    _commentLabel.text = dict[@"comment"];
    _commentLabel.numberOfLines = 0;
    
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 60 * scaleHeight + size.height * num + sizeLabel.height * count - 1, Screen_Width, 1)];
    line.backgroundColor = BaseColor(242, 242, 242, 1);
    [self.contentView addSubview:line];
    
    

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
