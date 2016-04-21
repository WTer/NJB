//
//  TabBarViewController.h
//  农帮乐
//
//  Created by hpz on 15/12/2.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTabBarView.h"
#import "MainViewController.h"

@interface TabBarViewController : UIViewController

@property (nonatomic, strong) MyTabBarView *myTabBarView;
@property (nonatomic, assign) BOOL isRegister;

@end
