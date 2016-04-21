//
//  GuanZhuFenSiBtn.m
//  农家帮
//
//  Created by Mac on 16/4/6.
//  Copyright © 2016年 jingqi. All rights reserved.
//

#import "GuanZhuFenSiBtn.h"

@implementation GuanZhuFenSiBtn

- (instancetype) initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.font = [UIFont systemFontOfSize:16.0];
        
    }
    return self;
}


- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    return CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    
    return CGRectMake(0, self.frame.size.height * 0.3, 30 * ScaleWidth, 38 * ScaleHeight);
}


@end
