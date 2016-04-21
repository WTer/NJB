//
//  ShouYeViewController.m
//  test
//
//  Created by hpz on 15/11/27.
//  Copyright © 2015年 hpz. All rights reserved.
//

#import "ShouYeViewController.h"
#import "LoginViewController.h"
#import "RegisiterViewController.h"

@interface ShouYeViewController ()

@end

@implementation ShouYeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self createUI];
}


//隐藏导航栏
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    
}

//显示导航栏
- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}

//创建UI
- (void)createUI {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 20, Screen_Width, Screen_Height - 20)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    //第一张图片
    UIImageView *picture = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, Screen_Width, 648 * scaleHeight)];
    picture.image = [UIImage imageNamed:@"shouye_pic_01.png"];
    [view addSubview:picture];
    //第二张图片
    UIImageView *detailPicture = [[UIImageView alloc] initWithFrame:CGRectMake(0, 648 * scaleHeight, Screen_Width, 366 * scaleHeight)];
    detailPicture.image = [UIImage imageNamed:@"shouye_pic_02.png"];
    [self.view addSubview:detailPicture];
    
    //注册按钮
    CGFloat btnWidth = (720 - 24 * 3) / 2 * scaleWidth;
    UIButton *regisiter = [[UIButton alloc] initWithFrame:CGRectMake(24 * scaleWidth, 1054 * scaleHeight, btnWidth, 80 * scaleHeight)];
    [regisiter setTitle:NSLocalizedString(@"REGISTER", @"") forState:UIControlStateNormal];
    regisiter.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [regisiter setTitleColor:BaseColor(204, 204, 204, 1) forState:UIControlStateNormal];
    [regisiter setBackgroundImage:[UIImage imageNamed:@"shouye_btn_zhuce.png"] forState:UIControlStateNormal];
    [regisiter addTarget:self action:@selector(regisiter) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:regisiter];
    
    //登陆按钮
    UIButton *login = [[UIButton alloc] initWithFrame:CGRectMake(48 * scaleWidth + btnWidth, 1054 * scaleHeight, btnWidth, 80 * scaleHeight)];
    [login setTitle:NSLocalizedString(@"LOGIN", @"") forState:UIControlStateNormal];
    login.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [login setBackgroundImage:[UIImage imageNamed:@"shouye_btn_denglu_n.png"] forState:UIControlStateNormal];
    [login addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:login];
    
}
- (void)login {

    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];

}
- (void)regisiter {

    RegisiterViewController *regisiterVC = [[RegisiterViewController alloc] init];
    [self.navigationController pushViewController:regisiterVC animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
