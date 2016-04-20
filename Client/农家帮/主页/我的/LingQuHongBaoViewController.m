//
//  LingQuHongBaoViewController.m
//  农家帮
//
//  Created by Mac on 16/4/11.
//  Copyright © 2016年 jingqi. All rights reserved.
//

#import "LingQuHongBaoViewController.h"

@interface LingQuHongBaoViewController ()

@end

@implementation LingQuHongBaoViewController
{
    UILabel * _BigMoneyLable;
    UILabel * _SmallerMoneyLable;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"领取红包";
    [self createUI];
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [button setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(leftBackButtonClick) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}
- (void)leftBackButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)createUI
{
    UIImageView * view = [[UIImageView alloc]initWithFrame:self.view.frame];
    view.image = [UIImage imageNamed:@"zjhb_money.jpg"];
    [self.view addSubview:view];
    view.userInteractionEnabled = YES;
    
    _BigMoneyLable = [[ UILabel alloc]initWithFrame:CGRectMake(256 * scaleWidth, 458 * scaleHeight2 , 230 * scaleWidth, 180* scaleHeight2)];
    [view addSubview:_BigMoneyLable];
    _BigMoneyLable.font = BaseFont(140);
    _BigMoneyLable.textColor = BaseColor(254, 72, 48, 1);
    _BigMoneyLable.adjustsFontSizeToFitWidth = YES;
    
    _SmallerMoneyLable = [[UILabel alloc]initWithFrame:CGRectMake(284 * scaleWidth, 810 * scaleHeight2 , 97 * scaleWidth, 80 * scaleHeight2)];
    _SmallerMoneyLable.font = BaseFont(62);
    _SmallerMoneyLable.textColor = BaseColor(255, 214, 38, 1);
    [view addSubview:_SmallerMoneyLable];
    _SmallerMoneyLable.adjustsFontSizeToFitWidth = YES;
    
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, Screen_Height - 88 * scaleHeight - 64, Screen_Width, 88 * scaleHeight)];
    [view addSubview:button];
    button.backgroundColor = BaseColor(254, 72, 48, 1);
//    button.titleLabel.font = BaseFont(36);
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    _SmallerMoneyLable.text = _hongBaoJinge;
    _BigMoneyLable.text = _hongBaoJinge;
    
}

#pragma mark ---button的电击的方法
- (void)buttonClick
{
    [[JudgeNetState shareInstance] monitorNetworkType:self.view complete:^(NSInteger state) {
        
        if (state == 1 || state == 2) {
            
            JQBaseRequest * jq = [[JQBaseRequest alloc]init];
            [jq MaiJia3ShouQuPuTongDanGeHongBaoPUTWithRedEnvelopeId:_hongbaoID complete:^(NSDictionary *responseObject) {
                
                UIAlertController*alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message: @"红包领取成功"   preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }];
                
                [alertController addAction:otherAction];
                [self presentViewController:alertController animated:YES completion:nil];
                
                
            } fail:^(NSError *error, NSString *errorString) {
                UIAlertController*alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message: @"红包领取失败"   preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }];
                
                [alertController addAction:otherAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }];
            
                
           
        }
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
