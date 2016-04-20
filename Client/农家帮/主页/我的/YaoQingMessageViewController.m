//
//  YaoQingMessageViewController.m
//  农家帮
//
//  Created by 赵波 on 16/3/7.
//  Copyright © 2016年 jingqi. All rights reserved.
//

#import "YaoQingMessageViewController.h"
#import "MBProgressHUD.h"

@interface YaoQingMessageViewController ()

@property (nonatomic, strong) UITextView *textView;

@end

@implementation YaoQingMessageViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"邀请信息";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)loadViews
{
    UITextView *textField = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, Screen_Width-20, 200)];
    
    textField.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:textField];
    self.textView = textField;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.backgroundColor = [UIColor greenColor];
    button.layer.cornerRadius = 8;
    button.layer.masksToBounds = YES;
    button.frame = CGRectMake(50, 230, Screen_Width-100, 60);
    [button setTitle:@"确认邀请" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)action:(UIControl *)sender
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    JQBaseRequest * jq = [[JQBaseRequest alloc]init];
    
    if (_consumerId) {
        [jq piPeiKeHuFaChuYaoQingWithProducerId:[ud objectForKey:UserID]
                                     consumerId:_consumerId
                                        message:_textView.text
                                       complete:^(NSDictionary *responseObject) {
                                           [MBProgressHUD showHUDAddedTo:self.view animated:YES label:@"邀请成功！" afterDelay:1.5];
                                           [self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:[NSNumber numberWithBool:YES] afterDelay:3.0];
                                       }
                                           fail:^(NSError *error, NSString *errorString) {
                                               [MBProgressHUD showHUDAddedTo:self.view animated:YES label:errorString afterDelay:1.5];
                                               
                                           }];
    }
    
    if (_producerId) {
        [jq piPeiKeHuFaChuYaoQingWithProducerId:_producerId
                                     consumerId:[ud objectForKey:UserID]
                                        message:_textView.text
                                       complete:^(NSDictionary *responseObject) {
                                           [MBProgressHUD showHUDAddedTo:self.view animated:YES label:@"邀请成功！" afterDelay:1.5];
                                           [self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:[NSNumber numberWithBool:YES] afterDelay:3.0];
                                       }
                                           fail:^(NSError *error, NSString *errorString) {
                                               [MBProgressHUD showHUDAddedTo:self.view animated:YES label:errorString afterDelay:1.5];
                                               
                                           }];
    }
}

@end
