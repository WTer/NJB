//
//  TabBarViewController.m
//  农帮乐
//
//  Created by hpz on 15/12/2.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "TabBarViewController.h"
#import "MainViewController.h"
#import "SousuoViewController.h"
#import "FabuViewController.h"
#import "FaBuQiuGouShangPinViewController.h"
#import "WodeViewController.h"

@interface TabBarViewController ()<MyTabBarDelegate>

@end

@implementation TabBarViewController
{
    UILabel *_label;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addViewControllers];
    [self addTabBarView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(fanhui) name:@"fanhui" object:nil];
    //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(fabu) name:@"fabu" object:nil];
    
}
- (void)fanhui {
    
    [self tabBar:_myTabBarView didSelectedFromIndex:1 toIndex:0];
   
    //UIButton *button = _myTabBarView.subviews[1];
    UIButton *selectBtn = _myTabBarView.subviews[0];
    
   
    [_myTabBarView itemClick:selectBtn];
}
- (void)fabu {
    
    [self tabBar:_myTabBarView didSelectedFromIndex:2 toIndex:0];
    
    UIButton *selectBtn = _myTabBarView.subviews[0];
    [_myTabBarView itemClick:selectBtn];
}

//增加子视图控制器
- (void)addViewControllers {
    
    NSArray *array = @[@"MainViewController", @"SousuoViewController", @"FabuViewController", @"WodeViewController"];
    
    NSArray *consumerArray = @[@"MainViewController", @"SousuoViewController", @"FaBuQiuGouShangPinViewController", @"WodeViewController"];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([ud boolForKey:@"IsConsumer"]) {
        
        for (int i = 0; i < consumerArray.count; i ++) {
            Class class = NSClassFromString(consumerArray[i]);
            
            //将控制器添加为当前控制器的子控制器
            if (i == 0) {
                MainViewController *viewController = [[class alloc] init];
                viewController.isRegister = self.isRegister;
                [self addChildViewController:viewController];
            }
            else {
                UIViewController *viewController = [[class alloc] init];
                [self addChildViewController:viewController];
            }
        }

    }
    else {
        
        for (int i = 0; i < array.count; i ++) {
            Class class = NSClassFromString(array[i]);
            
            //将控制器添加为当前控制器的子控制器
            if (i == 0) {
                MainViewController *viewController = [[class alloc] init];
                viewController.isRegister = self.isRegister;
                [self addChildViewController:viewController];
            }
            else {
                UIViewController *viewController = [[class alloc] init];
                [self addChildViewController:viewController];
            }
        }

    }
    
}
- (void)removeLabel:(UILabel *)label {
    
    [label removeFromSuperview];
    
    UIButton *selectBtn = _myTabBarView.subviews[0];
    [_myTabBarView itemClick:selectBtn];
   
}
//在当前控制器上添加TabBar
- (void)addTabBarView {
    
    _myTabBarView = [[MyTabBarView alloc] init];
    CGFloat tabBarH = 49;
    CGFloat tabBarW = self.view.frame.size.width;
    CGFloat tabBarX = 0;
    CGFloat tabBarY = self.view.frame.size.height - tabBarH;
    _myTabBarView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    _myTabBarView.frame = CGRectMake(tabBarX, tabBarY, tabBarW, tabBarH);
    _myTabBarView.backgroundColor =[UIColor whiteColor];
    _myTabBarView.delegate = self;
    [self.view addSubview:_myTabBarView];
    
    //添加item
    [self addItems];
}

- (void)addItems {
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([ud boolForKey:@"IsConsumer"]) {
        
        [_myTabBarView addTabBarItemImage:@"zy_nav_shouye_nor.png" selectedImage:@"zy_nav_shouye_sel.png"];
        [_myTabBarView addTabBarItemImage:@"zy_nav_sousuo_nor.jpg" selectedImage:@"zy_nav_sousuo_sel.png"];
        [_myTabBarView addTabBarItemImage:@"zy_nav_fabu_nor.jpg" selectedImage:@"zy_nav_fabu_nol.png"];
        [_myTabBarView addTabBarItemImage:@"zy_nav_wode_nor.jpg" selectedImage:@"zy_nav_wode_sel.png"];
    }
    else  {
        
        [_myTabBarView addTabBarItemImage:@"zy_nav_shouye_nor.png" selectedImage:@"zy_nav_shouye_sel.png"];
        [_myTabBarView addTabBarItemImage:@"zy_nav_sousuo_nor.jpg" selectedImage:@"zy_nav_sousuo_sel.png"];
        [_myTabBarView addTabBarItemImage:@"zy_nav_fabu_nor.jpg" selectedImage:@"zy_nav_fabu_sel.png"];
        [_myTabBarView addTabBarItemImage:@"zy_nav_wode_nor.jpg" selectedImage:@"zy_nav_wode_sel.png"];
    }
}

//协议方法
- (void)tabBar:(MyTabBarView *)tabBar didSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([ud boolForKey:@"IsConsumer"]) {
    
        //if (toIndex == 2) {
            
            
//            CGSize size = [NSLocalizedString(@"Only the farmer can release goods", @"") sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(999, 100)];
//            CGFloat labelX = (720 * scaleWidth - size.width) / 2 ;
//            _label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, 1200 * scaleHeight - 64, size.width, size.height)];
//            _label.backgroundColor = [UIColor blackColor];
//            _label.textAlignment = NSTextAlignmentCenter;
//            _label.textColor = [UIColor whiteColor];
//            _label.text = NSLocalizedString(@"Only the farmer can release goods", @"");
//            [self.view addSubview:_label];
//            [self.view bringSubviewToFront:_label];
//            [self performSelector:@selector(removeLabel:) withObject:_label afterDelay:1];
        
            
            
        //}
        //else {
            
            // 获取旧的控制器并移除
            UIViewController *oldViewController = self.childViewControllers[fromIndex];
            [oldViewController.view removeFromSuperview];
            
            //添加新的视图控制器
            UIViewController *newViewController = self.childViewControllers[toIndex];
            
            CGFloat viewW = self.view.frame.size.width;
            CGFloat viewH = self.view.frame.size.height - _myTabBarView.frame.size.height;
            CGFloat viewX = 0;
            CGFloat viewY = 0;
            newViewController.view.frame = CGRectMake(viewX, viewY, viewW, viewH);
            [self.view addSubview:newViewController.view];
            
            
            // 将新控制器的属性赋值给当前控制器
            self.navigationItem.rightBarButtonItem = newViewController.navigationItem.rightBarButtonItem;
            self.navigationItem.rightBarButtonItems = newViewController.navigationItem.rightBarButtonItems;
            self.navigationItem.leftBarButtonItem = newViewController.navigationItem.leftBarButtonItem;
            self.navigationItem.leftBarButtonItems = newViewController.navigationItem.leftBarButtonItems;
            self.navigationItem.title = newViewController.navigationItem.title;
            self.navigationItem.titleView = newViewController.navigationItem.titleView;
            
        //}
    }
    else {
    
        // 获取旧的控制器并移除
        UIViewController *oldViewController = self.childViewControllers[fromIndex];
        [oldViewController.view removeFromSuperview];
        
        //添加新的视图控制器
        UIViewController *newViewController = self.childViewControllers[toIndex];
        
        CGFloat viewW = self.view.frame.size.width;
        CGFloat viewH = self.view.frame.size.height - _myTabBarView.frame.size.height;
        CGFloat viewX = 0;
        CGFloat viewY = 0;
        newViewController.view.frame = CGRectMake(viewX, viewY, viewW, viewH);
        [self.view addSubview:newViewController.view];
        
        
        // 将新控制器的属性赋值给当前控制器
        self.navigationItem.rightBarButtonItem = newViewController.navigationItem.rightBarButtonItem;
        self.navigationItem.rightBarButtonItems = newViewController.navigationItem.rightBarButtonItems;
        self.navigationItem.leftBarButtonItem = newViewController.navigationItem.leftBarButtonItem;
        self.navigationItem.leftBarButtonItems = newViewController.navigationItem.leftBarButtonItems;
        self.navigationItem.title = newViewController.navigationItem.title;
        self.navigationItem.titleView = newViewController.navigationItem.titleView;

    
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
