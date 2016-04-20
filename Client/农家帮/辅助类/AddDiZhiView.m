//
//  AddDiZhiView.m
//  农帮乐
//
//  Created by hpz on 15/12/23.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "AddDiZhiView.h"

@implementation AddDiZhiView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
        
    }
    return self;
}
- (void)createUI {

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(24 * scaleWidth, 20 * scaleHeight, 24 * scaleWidth, 32 * scaleHeight)];
    imageView.image = [UIImage imageNamed:@"shdz1_icon.png"];
    [self addSubview:imageView];
    
    CGSize size = [NSLocalizedString(@"Add a shipping address", @"") sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(999, 100)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(72 * scaleWidth, 20 * scaleHeight, size.width, size.height)];
    label.text = NSLocalizedString(@"Add a shipping address", @"");
    [self addSubview:label];
    
    UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(660 * scaleWidth, 20 * scaleHeight, 20 * scaleWidth, 30 * scaleHeight)];
    rightImageView.image = [UIImage imageNamed:@"shdz1_icon2.png"];
    [self addSubview:rightImageView];
    
}
@end
