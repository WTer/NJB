//
//  MyTabBarView.m
//  农帮乐
//
//  Created by hpz on 15/12/2.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "MyTabBarView.h"

@implementation MyTabBarView


//在MyTabBarView上添加按钮
- (void)addTabBarItemImage:(NSString *)imageStr selectedImage:(NSString *)seletedImageStr {

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageWithData:UIImagePNGRepresentation([UIImage imageNamed:imageStr])] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithData:UIImagePNGRepresentation([UIImage imageNamed:seletedImageStr])] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    [self itemsFrameAdjust];
    
}
- (void)itemsFrameAdjust {
    
    // 获取item数量
    NSInteger itemNum = self.subviews.count;
    
    // 获取按钮的宽度
    CGFloat itemW = self.frame.size.width / itemNum;
    CGFloat itemH = self.frame.size.height;
    CGFloat itemY = 0;
    
    for (int i = 0; i < itemNum; i ++) {
        CGFloat itemX = i * itemW;
        UIButton *itemC = self.subviews[i];
        itemC.frame = CGRectMake(itemX, itemY, itemW, itemH);
        
        // 赋tag值,确定点击了哪个item
        itemC.tag = i;
        
    }
    
    NSInteger index = 0;
    
    if (self.subviews.count > index) {
        
        [self itemClick:self.subviews[index]];
        
    }
    
}

//按钮的点击事件
- (void)itemClick:(UIButton *)sender {
    
    // 通知代理
    if ([_delegate respondsToSelector:@selector(tabBar:didSelectedFromIndex:toIndex:)]) {
        
        [_delegate tabBar:self didSelectedFromIndex:_selectedBtn.tag toIndex:sender.tag];
        
    }
    
    //把上一个选中的按钮改为未选中
    _selectedBtn.selected = NO;
    
    //把当前选中的按钮改为选中
    sender.selected = YES;
    
    //让当前选中的按钮成为上一按钮
    _selectedBtn = sender;
}



@end
