//
//  MyTabBarView.h
//  农帮乐
//
//  Created by hpz on 15/12/2.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyTabBarView;
@protocol MyTabBarDelegate <NSObject>

- (void)tabBar:(MyTabBarView *)tabBar didSelectedFromIndex:(NSInteger )fromIndex toIndex:(NSInteger )toIndex;

@end

@interface MyTabBarView : UIView

- (void)addTabBarItemImage:(NSString *)imageStr selectedImage:(NSString *)seletedImageStr;

//按钮的点击事件
- (void)itemClick:(UIButton *)sender;


@property (nonatomic,weak) id<MyTabBarDelegate>delegate;
@property (nonatomic, strong) UIButton *selectedBtn;

@end
