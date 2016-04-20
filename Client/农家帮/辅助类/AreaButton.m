//
//  AreaButton.m
//  农帮乐
//
//  Created by hpz on 15/12/1.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "AreaButton.h"

@implementation AreaButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        //title的自适应
        self.titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    return self;
}
//按钮的title
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    return CGRectMake(self.frame.size.width * 0.3, 0, self.frame.size.width * 0.5, self.frame.size.height);
    
}
//按钮的image
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    return CGRectMake(self.frame.size.width * 0.8, self.frame.size.height * 0.4, self.frame.size.width * 0.1, self.frame.size.height * 0.1);
}


@end
