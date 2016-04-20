//
//  ConsumerZhengShuViewController.m
//  农家帮
//
//  Created by Mac on 16/4/6.
//  Copyright © 2016年 jingqi. All rights reserved.
//

#import "ConsumerZhengShuViewController.h"

@interface ConsumerZhengShuViewController ()

@end

@implementation ConsumerZhengShuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BaseColor(233, 233, 233, 1);
    
    
    self.title = @"我的证书";

    
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
