//
//  DiZhiTableViewCell.m
//  农帮乐
//
//  Created by hpz on 15/12/11.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "DiZhiTableViewCell.h"

@implementation DiZhiTableViewCell
{
    NSString *_morenDizhi;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
      
        
        [self createUI];
    }
    return self;
}
- (void)createUI {
    
    CGSize size = [NSLocalizedString(@"Sent to the", @"") sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(999, 100)];
    UILabel *songzhi = [[UILabel alloc]initWithFrame:CGRectMake(24 * scaleWidth, 40 * scaleHeight, size.width, size.height)];
    songzhi.text = NSLocalizedString(@"Sent to the", @"");
    [self.contentView addSubview:songzhi];
    
     _dizhi = [[UILabel alloc] init];
    
    _dizhi.textColor = BaseColor(178, 178, 178, 1);
    [self.contentView addSubview:_dizhi];
    
}
- (void)configWithDiZhi:(NSString *)dizhiString {

    
    CGSize size = [NSLocalizedString(@"Sent to the", @"") sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(999, 100)];
    
    if (dizhiString.length) {
        
        CGSize dizhiSize = [dizhiString sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(999, 100)];
        if (dizhiSize.width >= 990) {
            dizhiSize.height = dizhiSize.height * 0.5;
        }
        CGFloat width = dizhiSize.width;
        NSInteger count = 1;
        for (NSInteger i = 0; width >= 540 * scaleWidth; i++) {
            count++;
            width -= 540 * scaleWidth;
        }
        if (count > 1) {
            _dizhi.frame = CGRectMake(40 * scaleWidth + size.width, 10 * scaleHeight, 540 * scaleWidth, dizhiSize.height * count);
        }
        else {
            
            _dizhi.frame = CGRectMake(40 * scaleWidth + size.width, 40 * scaleHeight, dizhiSize.width, dizhiSize.height);
        }
        _dizhi.text = dizhiString;
        _dizhi.numberOfLines = 0;
       
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, _dizhi.frame.origin.y + dizhiSize.height * count + 40 * scaleHeight - 1, Screen_Width, 1)];
        label.backgroundColor = BaseColor(242, 242, 242, 1);
        [self.contentView addSubview:label];
        
    }
    else {
        
        CGSize shouhuoSize = [NSLocalizedString(@"Please select your shipping address", @"") sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(999, 100)];
        _dizhi.frame = CGRectMake(44 * scaleWidth + size.width, 40 * scaleHeight, shouhuoSize.width, shouhuoSize.height);
        _dizhi.text = NSLocalizedString(@"Please select your shipping address", @"");
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 160 * scaleHeight - 1, Screen_Width, 1)];
        label.backgroundColor = BaseColor(242, 242, 242, 1);
        [self.contentView addSubview:label];
        
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
