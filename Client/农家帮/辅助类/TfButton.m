//
//  TfButton.m
//  农帮乐
//
//  Created by hpz on 15/11/30.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "TfButton.h"

@implementation TfButton

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}
//这个按钮title宽度占一半,image宽度占一半
//按纽的title
- (CGRect)titleRectForContentRect:(CGRect)contentRect {

    return CGRectMake(self.frame.size.width * 0.35, 0, self.frame.size.width * 0.5, self.frame.size.height);

}
//按钮的image
- (CGRect)imageRectForContentRect:(CGRect)contentRect {

    return CGRectMake(self.frame.size.width * 0.1, self.frame.size.height * 0.2, self.frame.size.width * 0.15, self.frame.size.height * 0.6);
}
@end
