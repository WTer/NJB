//
//  ErWeiMaViewController.m
//  农家帮
//
//  Created by 赵波 on 16/3/7.
//  Copyright © 2016年 jingqi. All rights reserved.
//

#import "ErWeiMaViewController.h"
#import "MBProgressHUD.h"

@interface ErWeiMaViewController ()

@property (nonatomic, strong) UIImageView *weima;

@end

@implementation ErWeiMaViewController
{
    JQBaseRequest *_jqRequest;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _jqRequest = [[JQBaseRequest alloc] init];
    
    [self loadViews];
    [self requstErWeiMa];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadViews
{
    self.title = @"二维码名片";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"创建", @"") style:UIBarButtonItemStylePlain target:self action:@selector(chuangJian)];

    
    
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 150, Screen_Width - 100, Screen_Width - 100)];
//    imageView.image = [UIImage imageNamed:@"2weima.png"];
//    imageView.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:imageView];
//    
//    CGFloat gap = 62, wh = 190;
//    
//    _weima = [[UIImageView alloc] initWithFrame:CGRectMake(gap, gap, wh, wh)];
//    [imageView addSubview:_weima];
    
    UIImageView *touxingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20 * ScaleWidth, 30 * ScaleWidth, 80 * ScaleWidth, 80 * ScaleWidth)];
    [touxingImageView sd_setImageWithURL:[NSURL URLWithString:self.touxiang]];
    [self.view addSubview:touxingImageView];
    
    UILabel *yonghumingLabel = [[UILabel alloc] initWithFrame:CGRectMake(110 * ScaleWidth, 30 * ScaleWidth, 140 * ScaleWidth, 30 * ScaleWidth)];
    yonghumingLabel.font = [UIFont systemFontOfSize:21.0];
    yonghumingLabel.text = self.yonghuming;
    [self.view addSubview:yonghumingLabel];
    
    UIImageView *renzhengImageView = [[UIImageView alloc] initWithFrame:CGRectMake(250 * ScaleWidth, 35 * ScaleWidth, 35 * scaleWidth, 35 * scaleHeight)];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [_jqRequest chaXunShiMimgRenZhengWith:[NSString stringWithFormat:@"%@",[ud objectForKey:@"ProducerId"]] complete:^(NSDictionary *responseObject) {
        
        NSLog(@"认证:%@",responseObject);
        
        renzhengImageView.image = [UIImage imageNamed:@"V标_icon.png"];
        [self.view addSubview:renzhengImageView];
        
    } fail:^(NSError *error, NSString *errorString) {
        //renzhengImageView.backgroundColor = [UIColor redColor];
        renzhengImageView.image = [UIImage imageNamed:@"V标_icon.png"];
        [self.view addSubview:renzhengImageView];
        NSLog(@"未认证:%@",errorString);
        
    }];
    
    
    UILabel *yonghudizhiLabel = [[UILabel alloc] initWithFrame:CGRectMake(110 * ScaleWidth, 60 * ScaleWidth, 200 * ScaleWidth, 30 * ScaleWidth)];
    yonghudizhiLabel.font = [UIFont systemFontOfSize:16.0];
    yonghudizhiLabel.text = self.yonghudizhi;
    yonghudizhiLabel.textColor = [UIColor grayColor];
    [self.view addSubview:yonghudizhiLabel];
    
    
    
    _weima = [[UIImageView alloc] initWithFrame:CGRectMake(50 * ScaleWidth, 150 * ScaleWidth, Screen_Width - 100 * ScaleWidth, Screen_Width - 100 * ScaleWidth)];
    [self.view addSubview:_weima];
    
    UILabel *tishi = [[UILabel alloc] initWithFrame:CGRectMake(50 * ScaleWidth, Screen_Width + 60 * ScaleWidth, Screen_Width - 100 * ScaleWidth, 30 * ScaleWidth)];
    tishi.font = [UIFont systemFontOfSize:14.0];
    tishi.textAlignment = NSTextAlignmentCenter;
    tishi.text = @"扫一扫上面的二维码团,加我为好友";
    tishi.textColor = [UIColor grayColor];
    [self.view addSubview:tishi];
}

- (void)requstErWeiMa
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    JQBaseRequest * jq = [[JQBaseRequest alloc]init];
    
    if ([ud boolForKey:@"IsConsumer"]) {
        [jq chaXun2WeiMaWithConsumerId:[NSString stringWithFormat:@"%@",[ud objectForKey:@"ConsumerId"]]
                              complete:^(NSDictionary *responseObject) {
                                  [_weima sd_setImageWithURL:[NSURL URLWithString:[responseObject valueForKey:@"url"]]];
                                  self.navigationItem.rightBarButtonItem = nil;
                                  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"删除", @"") style:UIBarButtonItemStylePlain target:self action:@selector(shanChu)];
                              }
                                  fail:^(NSError *error, NSString *errorString) {
                                      self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"创建", @"") style:UIBarButtonItemStylePlain target:self action:@selector(chuangJian)];
                                  }];
    }
    else {
        
        [jq chaXun2WeiMaWithProducerId:[NSString stringWithFormat:@"%@",[ud objectForKey:@"ProducerId"]]
                              complete:^(NSDictionary *responseObject) {
                                  [_weima sd_setImageWithURL:[NSURL URLWithString:[responseObject valueForKey:@"url"]]];
                                  self.navigationItem.rightBarButtonItem = nil;
                                  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"删除", @"") style:UIBarButtonItemStylePlain target:self action:@selector(shanChu)];
                              }
                                  fail:^(NSError *error, NSString *errorString) {
                                      self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"创建", @"") style:UIBarButtonItemStylePlain target:self action:@selector(chuangJian)];
                                  }];
    }
}

- (void)chuangJian
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    JQBaseRequest * jq = [[JQBaseRequest alloc]init];
    
    if ([ud boolForKey:@"IsConsumer"]) {
        [jq chuangJian2WeiMaWithConsumerId:[NSString stringWithFormat:@"%@",[ud objectForKey:@"ConsumerId"]]
                                  complete:^(NSDictionary *responseObject) {
                                      [self requstErWeiMa];
                                  }
                                      fail:^(NSError *error, NSString *errorString) {
                                          [MBProgressHUD showHUDAddedTo:self.view animated:YES label:errorString afterDelay:1.5f];
                                      }];

    }
    else {
        
        [jq chuangJian2WeiMaWithProducerId:[NSString stringWithFormat:@"%@",[ud objectForKey:@"ProducerId"]]
                                  complete:^(NSDictionary *responseObject) {
                                      [self requstErWeiMa];
                                  }
                                      fail:^(NSError *error, NSString *errorString) {
                                          [MBProgressHUD showHUDAddedTo:self.view animated:YES label:errorString afterDelay:1.5f];
                                      }];

    }
    
}

- (void)shanChu
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    JQBaseRequest * jq = [[JQBaseRequest alloc]init];
    
    if ([ud boolForKey:@"IsConsumer"]) {
        [jq shanChu2WeiMaWithConsumerId:[NSString stringWithFormat:@"%@",[ud objectForKey:@"ConsumerId"]]
                               complete:^(NSDictionary *responseObject) {
                                   [MBProgressHUD showHUDAddedTo:self.view animated:YES label:@"删除成功" afterDelay:1.5f];
                                   _weima.image = nil;
                                   self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"创建", @"") style:UIBarButtonItemStylePlain target:self action:@selector(chuangJian)];
                               }
                                   fail:^(NSError *error, NSString *errorString) {
                                       [MBProgressHUD showHUDAddedTo:self.view animated:YES label:errorString afterDelay:1.5f];
                                   }];
    }
    else {
    
        [jq shanChu2WeiMaWithProducerId:[NSString stringWithFormat:@"%@",[ud objectForKey:@"ProducerId"]]
                               complete:^(NSDictionary *responseObject) {
                                   [MBProgressHUD showHUDAddedTo:self.view animated:YES label:@"删除成功" afterDelay:1.5f];
                                   _weima.image = nil;
                                   self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"创建", @"") style:UIBarButtonItemStylePlain target:self action:@selector(chuangJian)];
                               }
                                   fail:^(NSError *error, NSString *errorString) {
                                       [MBProgressHUD showHUDAddedTo:self.view animated:YES label:errorString afterDelay:1.5f];
                                   }];
    
    }
}

@end
