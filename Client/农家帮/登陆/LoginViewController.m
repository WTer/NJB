//
//  LoginViewController.m
//  test
//
//  Created by hpz on 15/11/27.
//  Copyright © 2015年 hpz. All rights reserved.
//

#import "LoginViewController.h"
#import "TfButton.h"
#import "RegisiterViewController.h"
#import "TabBarViewController.h"
#import "MyNavigationController.h"
#import "AppDelegate.h"

@interface LoginViewController ()<UITextFieldDelegate>

@end

@implementation LoginViewController
{
    UIButton *_consumer;
    UIButton *_farmer;
    UITextField *_shoujiTF;
    UITextField *_mimaTF;
    JQBaseRequest *_JQRequest;
    
    UIScrollView *_scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"LOGIN", @"");
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"FindPassword", @"") style:UIBarButtonItemStylePlain target:self action:@selector(zhaohuimima)];
    
    [self createUI];
    _JQRequest = [[JQBaseRequest alloc] init];
    
}

//在注册过程中如果手机号已经注册过就会返回到登录界面
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    _shoujiTF.text = self.shoujiString;
    _mimaTF.text = self.mimaString;
    
    if (self.shoujiString.length) {
        
        if (self.isConsumer ) {
            
            _consumer.selected = YES;
            
        }
        else {
            
            _farmer.selected = YES;
            
        }
    }
}


- (void)createUI {

    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height - 64)];
    [self.view addSubview:_scrollView];
    
    //顶端图片
    UIImageView *topPicture = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 320 * scaleHeight)];
    topPicture.image = [UIImage imageNamed:@"login_banner.png"];
    [_scrollView addSubview:topPicture];
    
    //消费者按钮
    CGFloat btnWidth = (720 - 24 * 3) / 2 * scaleWidth;
    _consumer = [[UIButton alloc] initWithFrame:CGRectMake(24 * scaleWidth, 360 * scaleHeight, btnWidth, 80 * scaleHeight)];
    [_consumer setTitle:NSLocalizedString(@"CONSUMER", @"") forState:UIControlStateNormal];
    [_consumer setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_consumer setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
    [_consumer setBackgroundImage:[UIImage imageNamed:@"login_radio.png"] forState:UIControlStateNormal];
    [_consumer setBackgroundImage:[UIImage imageNamed:@"login_radio_selected.png"] forState:UIControlStateSelected];
    [_consumer addTarget:self action:@selector(consumer) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_consumer];
    
    //农场主按钮
    _farmer = [[UIButton alloc] initWithFrame:CGRectMake(48 * scaleWidth + btnWidth, 360 * scaleHeight, btnWidth, 80 * scaleHeight)];
    [_farmer setTitle:NSLocalizedString(@"FARMER", @"") forState:UIControlStateNormal];
    [_farmer setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_farmer setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
    [_farmer setBackgroundImage:[UIImage imageNamed:@"login_radio.png"] forState:UIControlStateNormal];
    [_farmer setBackgroundImage:[UIImage imageNamed:@"login_radio_selected.png"] forState:UIControlStateSelected];
    [_farmer addTarget:self action:@selector(farmer) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_farmer];
    
    //手机TextField
    CGFloat tfWidth = (720 - 24 * 2) * scaleWidth;
    _shoujiTF = [[UITextField alloc] initWithFrame:CGRectMake(24 * scaleWidth, 480 * scaleHeight, tfWidth, 80 * scaleHeight)];
    _shoujiTF.background = [UIImage imageNamed:@"login_input.png"];
    _shoujiTF.clearButtonMode = UITextFieldViewModeAlways;
    _shoujiTF.keyboardType = UIKeyboardTypePhonePad;
    _shoujiTF.delegate = self;
    CGSize shoujiSize = [NSLocalizedString(@"TEL", @"") sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(990, 100)];
    TfButton *shoujiLeft = [[TfButton alloc] initWithFrame:CGRectMake(0, 0, shoujiSize.width * 2, 80 * scaleHeight)];
    [shoujiLeft setTitle:NSLocalizedString(@"TEL", @"") forState:UIControlStateNormal];
    [shoujiLeft setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [shoujiLeft setImage:[UIImage imageNamed:@"login_icon_shouji.png"] forState:UIControlStateNormal];
    shoujiLeft.userInteractionEnabled = NO;
    _shoujiTF.leftView = shoujiLeft;
    _shoujiTF.leftViewMode = UITextFieldViewModeAlways;
    [_scrollView addSubview:_shoujiTF];
    
    //密码TextField
    _mimaTF = [[UITextField alloc] initWithFrame:CGRectMake(24 * scaleWidth, 580 * scaleHeight, tfWidth, 80 * scaleHeight)];
    _mimaTF.background = [UIImage imageNamed:@"login_input.png"];
    _mimaTF.clearButtonMode = UITextFieldViewModeAlways;
    _mimaTF.delegate = self;
    CGSize mimaSize = [NSLocalizedString(@"PASSWORD", @"") sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(990, 100)];
    TfButton *mimaLeft = [[TfButton alloc]initWithFrame:CGRectMake(0, 0, mimaSize.width * 2, 80 * scaleHeight)];
    [mimaLeft setTitle:NSLocalizedString(@"PASSWORD", @"") forState:UIControlStateNormal];
    [mimaLeft setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [mimaLeft setImage:[UIImage imageNamed:@"login_icon_mima.png"] forState:UIControlStateNormal];
    mimaLeft.userInteractionEnabled = NO;
    _mimaTF.leftView = mimaLeft;
    _mimaTF.leftViewMode = UITextFieldViewModeAlways;
    _mimaTF.secureTextEntry = YES;
    [_scrollView addSubview:_mimaTF];
    
    //登陆按钮
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(24 * scaleWidth, 700 * scaleHeight, tfWidth, 80 * scaleHeight)];
    [loginBtn setTitle:NSLocalizedString(@"LOGIN", @"") forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"shouye_btn_denglu_n.png"] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:loginBtn];
    
    //免费注册按钮
    UIButton *freeZhuCe = [[UIButton alloc] initWithFrame:CGRectMake((Screen_Width  - btnWidth) * 0.5, 950 * scaleHeight, btnWidth, 80 * scaleHeight)];
    [freeZhuCe setBackgroundImage:[UIImage imageNamed:@"login_btn_zhuce.png"] forState:UIControlStateNormal];
    [freeZhuCe setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [freeZhuCe setTitle:NSLocalizedString(@"FREEREGISTER", @"") forState:UIControlStateNormal];
    [freeZhuCe addTarget:self action:@selector(freeRegister) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:freeZhuCe];
    
    _scrollView.contentSize = CGSizeMake(Screen_Width, 1030 * scaleHeight + 216);
}
//免费注册的点击事件

- (void)freeRegister {

    RegisiterViewController *registerVC = [[RegisiterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
    
}

//登录按钮的点击事件，登录的时候检查手机号是否输入正确
- (void)login {

    [self.view endEditing:YES];

    [[JudgeNetState shareInstance] monitorNetworkType:self.view complete:^(NSInteger state) {
       
        if (state == 1 || state == 2) {
            if (_shoujiTF.text.length == 0 || _mimaTF.text.length == 0) {
                
                UIAlertController*alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"Input can't be empty", @"") preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                    
                    
                    
                }];
                
                [alertController addAction:otherAction];
                [self presentViewController:alertController animated:YES completion:nil];
                
            }
            else if (!_consumer.selected && !_farmer.selected) {
                
                UIAlertController*alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"Please select login type", @"") preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                    
                }];
                [alertController addAction:otherAction];
                [self presentViewController:alertController animated:YES completion:nil];
                
            }
            
            else {
                
                NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0-9]))\\d{8}$";
                
                NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
                
                BOOL isMatch = [pred evaluateWithObject:[NSString stringWithFormat:@"%@",_shoujiTF.text]];
                
                if (!isMatch) {
                    
                    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"The phone number you entered is wrong", @"") preferredStyle:UIAlertControllerStyleAlert];
                    
                    
                    UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                        
                        
                        
                    }];
                    
                    [alertController addAction:otherAction];
                    
                    [self presentViewController:alertController animated:YES completion:nil];
                    
                }
                else {
                    
                    //农场主登录到服务器
                    if (!_consumer.selected) {
                        
                        [_JQRequest FarmerOwnerLoginWithLoginName:_shoujiTF.text SessionKey:_mimaTF.text complete:^(NSDictionary *responseObject) {
                            NSLog(@"%@", responseObject);
                            
                            //把农场主id和农场主类型永久存储
                            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                            [ud setObject:[NSString stringWithFormat:@"%@",responseObject[@"id"]] forKey:@"ProducerId"];
                            [ud setObject:[NSString stringWithFormat:@"%@",responseObject[@"id"]] forKey:UserID];
                            [ud setBool:NO forKey:@"IsConsumer"];
                            [ud synchronize];
                            [self saveUserCategory];
                            
                            [self.view removeFromSuperview];
                            TabBarViewController *mainVC = [[TabBarViewController alloc] init];
                            mainVC.isRegister = NO;
                            AppDelegate * app = [UIApplication sharedApplication].delegate;
                            MyNavigationController * mvc = [[MyNavigationController alloc]initWithRootViewController:mainVC];
                            app.window.rootViewController = mvc;
                            
                            
                        } fail:^(NSError *error, NSString *errorString) {
                            
                            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"User record does not exist", @"") preferredStyle:UIAlertControllerStyleAlert];
                            UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                                
                                
                                
                            }];
                            [alertController addAction:otherAction];
                            [self presentViewController:alertController animated:YES completion:nil];
                        }];
                    }
                    //消费者登录到服务器
                    if (_consumer.selected) {
                        
                        [_JQRequest ConsumerLoginWithLoginName:_shoujiTF.text SessionKey:_mimaTF.text complete:^(NSDictionary *responseObject) {
                            NSLog(@"%@", responseObject);
                            
                            //把消费者id和消费者类型永久存储
                            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                            [ud setObject:[NSString stringWithFormat:@"%@",responseObject[@"id"]] forKey:@"ConsumerId"];
                            [ud setBool:YES forKey:@"IsConsumer"];
                            [ud setObject:[NSString stringWithFormat:@"%@",responseObject[@"id"]] forKey:UserID];
                            [ud synchronize];
                            [self saveUserCategory];

                            [self.view removeFromSuperview];
                            TabBarViewController *mainVC = [[TabBarViewController alloc] init];
                            mainVC.isRegister = NO;
                            AppDelegate * app = [UIApplication sharedApplication].delegate;
                            MyNavigationController * mvc = [[MyNavigationController alloc]initWithRootViewController:mainVC];
                            app.window.rootViewController = mvc;
                            
                        } fail:^(NSError *error, NSString *errorString) {
                            
                            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"User record does not exist", @"") preferredStyle:UIAlertControllerStyleAlert];
                            UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                                
                                
                                
                            }];
                            [alertController addAction:otherAction];
                            [self presentViewController:alertController animated:YES completion:nil];
                        }];
                    }
                    
                }
            }

        }
    }];
}


#pragma mark  -- 将用户类型放入userdefault中
- (void)saveUserCategory {
    
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    if (_consumer.selected) {
        [ud setObject:@"消费者" forKey:UserCategory];
    }
    if (_farmer.selected) {
        [ud setObject:@"农场主" forKey:UserCategory];
    }
    [ud synchronize];
}


#pragma mark -UITextFiled的代理方法 
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = CGRectMake(0, - 100 * scaleHeight, Screen_Width, Screen_Height + scaleHeight * 100);
        self.view.frame = frame;
    }];
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [textField resignFirstResponder];
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = CGRectMake(0, 64, Screen_Width, Screen_Height - 64);
        self.view.frame = frame;
    }];
    
    return YES;
}

//消费者按钮的点击事件
- (void)consumer {
    
    if (_consumer.selected) {
        return;
    }
    _consumer.selected = YES;
    _farmer.selected = NO;
}

//农场主按钮的点击事件
- (void)farmer {

    if (_farmer.selected) {
        return;
    }
    _consumer.selected = NO;
    _farmer.selected = YES;
    

}

//点击找回密码的点击事件
- (void)zhaohuimima {

    

}
//导航栏左边的返回按钮
- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
