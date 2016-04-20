//
//  TimeButton.m
//  农帮乐
//
//  Created by hpz on 15/12/3.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "TimeButton.h"

@implementation TimeButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        //title的自适应
        self.titleLabel.adjustsFontSizeToFitWidth = YES;
        
    }
    return self;
}
//按纽的title
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    return CGRectMake(self.frame.size.width * 0.5, 0, self.frame.size.width * 0.5, self.frame.size.height);
    
}
//按钮的image
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    
    return CGRectMake(self.frame.size.width * 0.2, self.frame.size.height * 0.3, self.frame.size.width * 0.2, self.frame.size.height * 0.6);
}


@end
