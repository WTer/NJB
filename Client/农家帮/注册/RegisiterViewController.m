//
//  RegisiterViewController.m
//  test
//
//  Created by hpz on 15/11/27.
//  Copyright © 2015年 hpz. All rights reserved.
//

#import "RegisiterViewController.h"
#import "TfButton.h"
#import "SettingMiMaViewController.h"
#import "LoginViewController.h"


@interface RegisiterViewController ()<UITextFieldDelegate>

@end

@implementation RegisiterViewController
{
    UIScrollView *_scrollView;
    
    UITextField *_shoujiTF;
    UITextField *_yanzhengmaTF;
    UIButton *_sendBtn;
    UIButton *_consumer;
    UIButton *_farmer;
    NSTimer *_timer;
    NSInteger _i;
    
    JQBaseRequest *_JQRequest;
    NSString *_idString;
    NSString *_codeString;
    NSString *_telString;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _JQRequest = [[JQBaseRequest alloc] init];
    
    self.title = NSLocalizedString(@"REGISTER", @"");
    self.navigationController.navigationBar.translucent = NO;
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"LOGIN", @"") style:UIBarButtonItemStylePlain target:self action:@selector(login)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];
    
    _i = 60;
}
//回到注册页面结束编辑
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.view endEditing:YES];
    
}
- (void)createUI {
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height - 64)];
    [self.view addSubview:_scrollView];
    
    //标语
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 40 * scaleHeight, Screen_Width, 40 * scaleHeight)];
    label.text = NSLocalizedString(@"We attentively from scratch - Account registration", @"");
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor grayColor];
    label.adjustsFontSizeToFitWidth = YES;
    label.font = [UIFont systemFontOfSize:20];
    [_scrollView addSubview:label];
    
    
    //手机号TextField
    CGFloat tfWidth = (720 - 24 * 2) * scaleWidth;
    _shoujiTF = [[UITextField alloc] initWithFrame:CGRectMake(24 * scaleWidth, 150 * scaleHeight, tfWidth, 80 * scaleHeight)];
    _shoujiTF.background = [UIImage imageNamed:@"login_input.png"];
    _shoujiTF.clearButtonMode = UITextFieldViewModeAlways;
    _shoujiTF.keyboardType = UIKeyboardTypePhonePad;
    _shoujiTF.delegate = self;
    CGSize shoujiSize = [NSLocalizedString(@"TELPHONE", @"") sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(990, 100)];
    TfButton *shoujiLeft = [[TfButton alloc] initWithFrame:CGRectMake(0, 0, shoujiSize.width * 2, 80 * scaleHeight)];
    [shoujiLeft setTitle:NSLocalizedString(@"TELPHONE", @"") forState:UIControlStateNormal];
    [shoujiLeft setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [shoujiLeft setImage:[UIImage imageNamed:@"zhuce1_icon_shouji.png"] forState:UIControlStateNormal];
    shoujiLeft.userInteractionEnabled = NO;
    _shoujiTF.leftView = shoujiLeft;
    _shoujiTF.leftViewMode = UITextFieldViewModeAlways;
    [_scrollView addSubview:_shoujiTF];
    
    //验证码TextField
    _yanzhengmaTF = [[UITextField alloc] initWithFrame:CGRectMake(24 * scaleWidth, 250 * scaleHeight, tfWidth - 170 * scaleWidth, 80 * scaleHeight)];
    _yanzhengmaTF.background = [UIImage imageNamed:@"login_input.png"];
    _yanzhengmaTF.clearButtonMode = UITextFieldViewModeAlways;
    _yanzhengmaTF.keyboardType = UIKeyboardTypePhonePad;
    _yanzhengmaTF.delegate = self;
    CGSize yanzhengmaSize = [NSLocalizedString(@"Verification code", @"") sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(990, 100)];
    TfButton *yanzhengmaLeft = [[TfButton alloc]initWithFrame:CGRectMake(0, 5 * scaleHeight, yanzhengmaSize.width * 2, 80 * scaleHeight)];
    [yanzhengmaLeft setTitle:NSLocalizedString(@"Verification code", @"") forState:UIControlStateNormal];
    [yanzhengmaLeft setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [yanzhengmaLeft setImage:[UIImage imageNamed:@"zhuce1_icon_yanzheng.png"] forState:UIControlStateNormal];
    yanzhengmaLeft.userInteractionEnabled = NO;
    _yanzhengmaTF.leftView = yanzhengmaLeft;
    _yanzhengmaTF.leftViewMode = UITextFieldViewModeAlways;
    [_scrollView addSubview:_yanzhengmaTF];

    
    //发送按钮
    _sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(24 * scaleWidth + _yanzhengmaTF.frame.size.width + 20 * scaleWidth, 250 * scaleHeight, 150 * scaleWidth, 80 * scaleHeight)];
    _sendBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _sendBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [_sendBtn setBackgroundImage:[UIImage imageNamed:@"zhuce1_btn_fasong_p.png"] forState:UIControlStateNormal];
    [_sendBtn setBackgroundImage:[UIImage imageNamed:@"login_input.png"] forState:UIControlStateSelected];
    [_sendBtn setTitle:NSLocalizedString(@"SEND", @"") forState:UIControlStateNormal];
    [_sendBtn setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    [_sendBtn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_sendBtn];
    
    //计时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timing) userInfo:nil repeats:YES];
    _timer.fireDate = [NSDate distantFuture];
    
    //消费者按钮
    CGFloat btnWidth = (720 - 24 * 3) / 2 * scaleWidth;
    _consumer = [[UIButton alloc] initWithFrame:CGRectMake(24 * scaleWidth, 390 * scaleHeight, btnWidth, 80 * scaleHeight)];
    [_consumer setTitle:NSLocalizedString(@"CONSUMER", @"") forState:UIControlStateNormal];
    [_consumer setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_consumer setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
    [_consumer setBackgroundImage:[UIImage imageNamed:@"zhuce1_radio.png"] forState:UIControlStateNormal];
    [_consumer setBackgroundImage:[UIImage imageNamed:@"zhuce1_radio_selected.png"] forState:UIControlStateSelected];
    [_consumer addTarget:self action:@selector(consumer) forControlEvents:UIControlEventTouchUpInside];
    
    [_scrollView addSubview:_consumer];
    
    //农场主按钮
    _farmer = [[UIButton alloc] initWithFrame:CGRectMake(48 * scaleWidth + btnWidth, 390 * scaleHeight, btnWidth, 80 * scaleHeight)];
    [_farmer setTitle:NSLocalizedString(@"FARMER", @"") forState:UIControlStateNormal];
    [_farmer setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_farmer setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
    [_farmer setBackgroundImage:[UIImage imageNamed:@"zhuce1_radio.png"] forState:UIControlStateNormal];
    [_farmer setBackgroundImage:[UIImage imageNamed:@"zhuce1_radio_selected.png"] forState:UIControlStateSelected];
    [_farmer addTarget:self action:@selector(farmer) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_farmer];
    
    //下一步按钮
    UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(24 * scaleWidth, 570 * scaleHeight, tfWidth, 80 * scaleHeight)];
    [nextBtn setBackgroundImage:[UIImage imageNamed:@"zhuce1_btn_xiayibu_p.png"] forState:UIControlStateNormal];
    [nextBtn setTitle:NSLocalizedString(@"NEXT", @"") forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:nextBtn];
    
    _scrollView.contentSize = CGSizeMake(Screen_Width, 650 * scaleHeight + 216);
    
}
//下一步按钮的点击事件
- (void)next {

    //点击下一步按钮取消_shoujiTF和_yanzhengmaTF的响应
    [_shoujiTF resignFirstResponder];
    [_yanzhengmaTF resignFirstResponder];
    NSLog(@"%@ %@ %@", _idString, _codeString, _telString);
    
    //一分钟内要输入正确的验证码，否则验证码无效
    if (_shoujiTF.text.length && _yanzhengmaTF.text.length) {
        
        if ([_codeString isEqualToString:_yanzhengmaTF.text] == YES) {
            
            //农场主验证短信验证码
            if (_farmer.selected) {
                
                [_JQRequest confirmTextMessageWithSmsCodeId:_idString UserSmsCode:_codeString TelephoneNumber:_telString complete:^(NSDictionary *responseObject) {
                    
                    NSLog(@"%@", responseObject);
                    
                    SettingMiMaViewController *setMiMaViewController = [[SettingMiMaViewController alloc] init];
                    setMiMaViewController.telString = _shoujiTF.text;
                    setMiMaViewController.isCosumer = _consumer.selected;
                    setMiMaViewController.typeString = NSLocalizedString(@"FARMER", @"");
                    [self.navigationController pushViewController:setMiMaViewController animated:YES];
                    
                    
                } fail:^(NSError *error, NSString *errorString) {
                    
                    NSLog(@"%@", errorString);
                    
                    UIAlertController*alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"Verification code is wrong", @"") preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                        
                        
                    }];
                    [alertController addAction:otherAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                    
                }];
            }
            //消费者验证短信验证码
            else if (_consumer.selected) {
                
                [_JQRequest confirmTextMessageOfConsumerWithSmsCodeId:_idString UserSmsCode:_codeString TelephoneNumber:_telString complete:^(NSDictionary *responseObject) {
                    
                    NSLog(@"%@", responseObject);
                    SettingMiMaViewController *setMiMaViewController = [[SettingMiMaViewController alloc] init];
                    setMiMaViewController.telString = _shoujiTF.text;
                    setMiMaViewController.isCosumer = _consumer.selected;
                    setMiMaViewController.typeString = NSLocalizedString(@"CONSUMER", @"");
                    [self.navigationController pushViewController:setMiMaViewController animated:YES];
                    
                    
                } fail:^(NSError *error, NSString *errorString) {
                    
                    NSLog(@"%@", errorString);
                    UIAlertController*alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"Verification code is wrong", @"") preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                        
                        
                    }];
                    [alertController addAction:otherAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                    
                }];
            }
            else {
            
            
                UIAlertController*alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"Please select register type", @"") preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                    
                    
                }];
                [alertController addAction:otherAction];
                [self presentViewController:alertController animated:YES completion:nil];
            
            }
        }
        else {
            
            UIAlertController*alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"Verification code is wrong", @"") preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                
                
            }];
            [alertController addAction:otherAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }

    else {
    
        UIAlertController*alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"Input can't be empty", @"") preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
            
            
        }];
        [alertController addAction:otherAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
//消费者按钮的点击事件
- (void)consumer {
    
    if (_consumer.selected) {
        return;
    }
    _consumer.selected = YES;
    _farmer.selected = NO;
}
//农场主的点击事件
- (void)farmer {
    
    if (_farmer.selected) {
        return;
    }
    _consumer.selected = NO;
    _farmer.selected = YES;
    
}

//https://182.92.224.165/Producer/SmsCode/18317896026
//发送按钮的点击事件
- (void)send {
    
    [[JudgeNetState shareInstance] monitorNetworkType:self.view complete:^(NSInteger state) {
        if (state == 1 || state == 2) {
            
            if (!_shoujiTF.text.length) {
                
                UIAlertController*alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"Mobile phone number can't be empty", @"") preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                    
                    
                    
                }];
                
                [alertController addAction:otherAction];
                [self presentViewController:alertController animated:YES completion:nil];
                
                
            }
            else if (!_consumer.selected && !_farmer.selected) {
                
                UIAlertController*alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"Please select register type", @"") preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                    
                    
                    
                }];
                
                [alertController addAction:otherAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            else {
                
                [_JQRequest ConfirmFarmerOwnerPhoneNumberWithLoginName:_shoujiTF.text omplete:^(NSDictionary *responseObject) {
                    if (_shoujiTF.text.length == 0) {
                        
                        UIAlertController*alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"Please enter the phone number", @"") preferredStyle:UIAlertControllerStyleAlert];
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
                            
                            _sendBtn.selected = YES;
                            if (_sendBtn.selected) {
                                
                                _timer.fireDate = [NSDate distantPast];
                                
                                NSLog(@"%d",_consumer.selected);
                                //农场主短信验证码
                                if (!_consumer.selected) {
                                    
                                    [_JQRequest senderTextMessageWithTelephonNumber:_shoujiTF.text complete:^(NSDictionary *responseObject) {
                                        
                                        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 250 * scaleHeight, Screen_Width, 80 * scaleHeight)];
                                        label.text = NSLocalizedString(@"Send Successfully", @"");
                                        label.textAlignment = NSTextAlignmentCenter;
                                        label.textColor = [UIColor redColor];
                                        [self.view addSubview:label];
                                        
                                        [self performSelector:@selector(removeLabel:) withObject:label afterDelay:1];
                                        
                                        _idString = [NSString stringWithFormat:@"%@",responseObject[@"id"]];
                                        _codeString = [NSString stringWithFormat:@"%@",responseObject[@"smsCode"]];
                                        _telString = [NSString stringWithFormat:@"%@",responseObject[@"telephone"]];
                                        
                                        NSLog(@"%@", responseObject);
                                        _timer.fireDate = [NSDate distantFuture];
                                        _sendBtn.selected = NO;
                                        
                                    } fail:^(NSError *error, NSString *errorString) {
                                        
                                        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 250 * scaleHeight, Screen_Width, 80 * scaleHeight)];
                                        label.text = NSLocalizedString(@"Send Failure", @"");
                                        label.textAlignment = NSTextAlignmentCenter;
                                        label.textColor = [UIColor redColor];
                                        [self.view addSubview:label];
                                        
                                        [self performSelector:@selector(removeLabel:) withObject:label afterDelay:1];
                                        
                                        NSLog(@"%@", errorString);
                                        
                                        _timer.fireDate = [NSDate distantFuture];
                                        _sendBtn.selected = NO;
                                    }];
                                }
                                //消费者短信验证码
                                if (_consumer.selected) {
                                    
                                    [_JQRequest senderTextMessageWithTelephonNumberOfConsumer:_shoujiTF.text complete:^(NSDictionary *responseObject) {
                                        
                                        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 250 * scaleHeight, Screen_Width, 80 * scaleHeight)];
                                        label.text = NSLocalizedString(@"Send Successfully", @"");
                                        label.textAlignment = NSTextAlignmentCenter;
                                        label.textColor = [UIColor redColor];
                                        [self.view addSubview:label];
                                        
                                        [self performSelector:@selector(removeLabel:) withObject:label afterDelay:1];
                                        
                                        _idString = [NSString stringWithFormat:@"%@",responseObject[@"id"]];
                                        _codeString = [NSString stringWithFormat:@"%@",responseObject[@"smsCode"]];
                                        _telString = [NSString stringWithFormat:@"%@",responseObject[@"telephone"]];
                                        
                                        NSLog(@"%@", responseObject);
                                        _timer.fireDate = [NSDate distantFuture];
                                        _sendBtn.selected = NO;
                                        
                                    } fail:^(NSError *error, NSString *errorString) {
                                        
                                        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 250 * scaleHeight, Screen_Width, 80 * scaleHeight)];
                                        label.text = NSLocalizedString(@"Send Failure", @"");
                                        label.textAlignment = NSTextAlignmentCenter;
                                        label.textColor = [UIColor redColor];
                                        [self.view addSubview:label];
                                        
                                        [self performSelector:@selector(removeLabel:) withObject:label afterDelay:1];
                                        
                                        NSLog(@"%@", errorString);
                                        
                                        _timer.fireDate = [NSDate distantFuture];
                                        _sendBtn.selected = NO;
                                    }];
                                }
                            }
                        }
                    }
                    
                } fail:^(NSError *error, NSString *errorString) {
                    
                    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"The mobile phone number has been registered, please login directly", @"") preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                        
                        LoginViewController *loginVC = [[LoginViewController alloc] init];
                        loginVC.shoujiString = _shoujiTF.text;
                        loginVC.isConsumer = _consumer.selected;
                        [self.navigationController pushViewController:loginVC animated:YES];
                        
                        
                    }];
                    [alertController addAction:otherAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                    
                }];
            }

        }
    }];
}
- (void)removeLabel:(UILabel *)object {

    [object removeFromSuperview];
    
}
//计时器的触发事件
- (void)timing {
    
    if (_i >= 0) {
        
        [_sendBtn setTitle:[NSString stringWithFormat:@"%@(%ld)",NSLocalizedString(@"SENDING", @""), (long)_i--] forState:UIControlStateSelected];
        
    }
    else {
        
        _sendBtn.selected = NO;
        _timer.fireDate = [NSDate distantFuture];
        
    }
}
//登录按钮的点击事件
- (void)login {

    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];

}
//导航栏的返回按钮
- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
