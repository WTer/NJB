//
//  WoDeHongBaoViewController.m
//  农家帮
//
//  Created by Mac on 16/4/5.
//  Copyright © 2016年 jingqi. All rights reserved.
//

#import "WoDeHongBaoViewController.h"

@interface WoDeHongBaoViewController ()

@end

@implementation WoDeHongBaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BaseColor(245, 245, 245, 1);
    
    self.title = NSLocalizedString(@"我的红包", @"");
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [button setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(leftBackButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
}
- (void)leftBackButtonClick {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
