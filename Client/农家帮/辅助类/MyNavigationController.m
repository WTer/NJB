//
//  MyNavigationController.m
//  test
//
//  Created by hpz on 15/11/27.
//  Copyright © 2015年 hpz. All rights reserved.
//

#import "MyNavigationController.h"

@interface MyNavigationController ()

@end

@implementation MyNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //导航栏的背景颜色
    self.navigationBar.barStyle = UIBarStyleBlack;

    //导航栏的字体颜色
    self.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                   NSFontAttributeName:[UIFont systemFontOfSize:21]
                                                   }];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
