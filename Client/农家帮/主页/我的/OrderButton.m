//
//  OrderButton.m
//  农帮乐
//
//  Created by 王朝源 on 15/12/9.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "OrderButton.h"

@implementation OrderButton
{
    UIButton * button;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.adjustsFontSizeToFitWidth = YES;
        self.userInteractionEnabled = NO;
        button = self;
    }
    return self;
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGSize size2 = [ button.titleLabel.text sizeWithFont:BaseFont(28) maxSize:CGSizeMake(999, 28 * scaleHeight)];
    if (!self.selected) {
        return CGRectMake(108 * scaleWidth, 0, size2.width, self.frame.size.height);
    }else{
        return CGRectMake(108 * scaleWidth, 0, size2.width, self.frame.size.height);
    }
}
//按钮的image
- (CGRect)imageRectForContentRect:(CGRect)contentRect {

    CGSize size2 = [ button.titleLabel.text sizeWithFont:BaseFont(28) maxSize:CGSizeMake(999, 28 * scaleHeight)];
    if (!self.selected) {
        return CGRectMake(108 * scaleWidth + size2.width + 20 * scaleWidth, (80 - 21) * scaleHeight/ 2.0, 30 * scaleWidth, 21 * scaleHeight);
    }else{
        return CGRectMake(108 * scaleWidth + size2.width + 20 * scaleWidth, (80 - 21) * scaleHeight/ 2.0, 30 * scaleWidth, 21 * scaleHeight);
    }
}

@end
