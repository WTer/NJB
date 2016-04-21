

//
//  ShengShiQuView.m
//  农帮乐
//
//  Created by hpz on 15/12/14.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "ShengShiQuView.h"

@implementation ShengShiQuView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
    }
    return self;
}
- (void)createUI {
    
    CGSize size = [NSLocalizedString(@"Provinces", @"") sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(999, 100)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 40 * scaleHeight, size.width, size.height)];
    label.text = NSLocalizedString(@"Provinces", @"");
    label.textColor = BaseColor(52, 52, 52, 1);
    label.font = [UIFont systemFontOfSize:18.0];
    [self addSubview:label];
    
    CGSize weizhiSize = [NSLocalizedString(@"Click on the select location", @"") sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(999, 100)];
    _weizhiLabel = [[UILabel alloc] initWithFrame:CGRectMake(106 * scaleWidth + size.width, 40 * scaleHeight, weizhiSize.width, weizhiSize.height)];
    _weizhiLabel.text = NSLocalizedString(@"Click on the select location", @"");
    _weizhiLabel.textColor = BaseColor(178, 178, 178, 1);
    _weizhiLabel.font = [UIFont systemFontOfSize:18.0];
    [self addSubview:_weizhiLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(640 * scaleWidth, 50 * scaleHeight, 16 * scaleWidth, 30 * scaleHeight)];
    imageView.image = [UIImage imageNamed:@"shdz1_icon2.png"];
    [self addSubview:imageView];
    
}
@end
