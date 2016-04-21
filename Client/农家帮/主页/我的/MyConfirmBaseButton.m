//
//  MyConfirmBaseButton.m
//  农帮乐
//
//  Created by 王朝源 on 15/12/10.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "MyConfirmBaseButton.h"

@implementation MyConfirmBaseButton
{
    UIImageView * _imageView;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.adjustsFontSizeToFitWidth = YES;
        [self setImage:nil forState:UIControlStateNormal];
        [self setTitleColor:BaseColor(52, 52, 52, 1) forState:UIControlStateNormal];
        [self setTitleColor:BaseColor(9, 142, 43, 1) forState:UIControlStateSelected];
    }
    return self;
}

@end
