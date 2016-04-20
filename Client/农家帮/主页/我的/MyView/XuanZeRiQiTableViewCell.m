//
//  XuanZeRiQiTableViewCell.m
//  农家帮
//
//  Created by Mac on 16/3/28.
//  Copyright © 2016年 jingqi. All rights reserved.
//

#import "XuanZeRiQiTableViewCell.h"

@implementation XuanZeRiQiTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        if ([reuseIdentifier isEqualToString:@"NianTableViewCell"] == YES) {
            
            _riqi = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 240 * scaleWidth, 70 * scaleHeight)];
        }
        else {
            
            _riqi = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160 * scaleWidth, 70 * scaleHeight)];
        }
        _riqi.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_riqi];
    }
    return self;
}
- (void)configWithDictionary:(NSArray *)array {

    if (array.count == 2) {
        NSDictionary* style = @{@"da" :@[[UIFont fontWithName:@"HelveticaNeue" size:16.0],BaseColor(229, 117, 47, 1)],
                                     @"xiao" :@[[UIFont fontWithName:@"HelveticaNeue-Bold" size:9.0],BaseColor(229, 117, 47, 1)]};
        _riqi.attributedText = [[NSString stringWithFormat:@"<da>%@</da><xiao>%@</xiao>", [NSString stringWithFormat:@"%@",array[0]], [NSString stringWithFormat:@"%@",array[1]]]attributedStringWithStyleBook:style];
    }
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
