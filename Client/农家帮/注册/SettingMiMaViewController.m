//
//  SettingMiMaViewController.m
//  农帮乐
//
//  Created by hpz on 15/12/1.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "SettingMiMaViewController.h"
#import "TfButton.h"
#import "CosumerViewController.h"
#import "FarmerViewController.h"
#import "LoginViewController.h"

@interface SettingMiMaViewController ()<UITextFieldDelegate>

@end

@implementation SettingMiMaViewController
{
    UIScrollView *_scrollView;
    
    UITextField *_settingMiMaTF;
    UITextField *_QueRenMiMaTF;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

}

- (void)createUI {

    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height - 64)];
    [self.view addSubview:_scrollView];
    
    //标语
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 40 * scaleHeight, Screen_Width, 40 * scaleHeight)];
    label.text = NSLocalizedString(@"We attentively from scratch - Account registration", @"");
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:20];
    [_scrollView addSubview:label];
    
    //账号
    CGFloat tfWidth = (720 - 24 * 2) * scaleWidth;
    UILabel *zhanghao = [[UILabel alloc] initWithFrame:CGRectMake(24 * scaleWidth, 160 * scaleHeight, 80 * scaleWidth, 40 * scaleHeight)];
    zhanghao.font = [UIFont systemFontOfSize:20];
    zhanghao.text = [NSString stringWithFormat:@"%@:", NSLocalizedString(@"ACCOUNT", @"")];
    zhanghao.adjustsFontSizeToFitWidth = YES;
    zhanghao.textColor = [UIColor grayColor];
    [_scrollView addSubview:zhanghao];
    
    UILabel *telLabel = [[UILabel alloc] initWithFrame:CGRectMake(24 * scaleWidth + zhanghao.frame.size.width, 160 * scaleHeight, tfWidth - zhanghao.frame.size.width, 40 * scaleHeight)];
    telLabel.text = [NSString stringWithFormat:@"%@(%@)", self.telString, self.typeString];
    telLabel.textColor = [UIColor greenColor];
    telLabel.font = [UIFont systemFontOfSize:20];
    [_scrollView addSubview:telLabel];
    
    //设置密码TextField
    _settingMiMaTF = [[UITextField alloc] initWithFrame:CGRectMake(24 * scaleWidth, 240 * scaleHeight, tfWidth, 80 * scaleHeight)];
    _settingMiMaTF.background = [UIImage imageNamed:@"zhuce2_input.png"];
    _settingMiMaTF.clearButtonMode = UITextFieldViewModeAlways;
    _settingMiMaTF.delegate = self;
    _settingMiMaTF.secureTextEntry = YES;
    CGSize setmimaSize = [NSLocalizedString(@"SETPASSWORD", @"") sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(990, 100)];
    TfButton *setmimaLeft = [[TfButton alloc] initWithFrame:CGRectMake(0, 0, setmimaSize.width * 2, 80 * scaleHeight)];
    [setmimaLeft setTitle:NSLocalizedString(@"SETPASSWORD", @"") forState:UIControlStateNormal];
    [setmimaLeft setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [setmimaLeft setImage:[UIImage imageNamed:@"zhuce2_icon_shezhimima.png"] forState:UIControlStateNormal];
    setmimaLeft.userInteractionEnabled = NO;
    _settingMiMaTF.leftView = setmimaLeft;
    _settingMiMaTF.leftViewMode = UITextFieldViewModeAlways;
    [_scrollView addSubview:_settingMiMaTF];
    
    //确认密码TextField
    _QueRenMiMaTF = [[UITextField alloc] initWithFrame:CGRectMake(24 * scaleWidth, 340 * scaleHeight, tfWidth, 80 * scaleHeight)];
    _QueRenMiMaTF.background = [UIImage imageNamed:@"zhuce2_input.png"];
    _QueRenMiMaTF.clearButtonMode = UITextFieldViewModeAlways;
    _QueRenMiMaTF.delegate = self;
    _QueRenMiMaTF.secureTextEntry = YES;
    CGSize querenmimaSize = [NSLocalizedString(@"Confirm Password", @"") sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(990, 100)];
    TfButton *querenmimaLeft = [[TfButton alloc]initWithFrame:CGRectMake(0, 0, querenmimaSize.width * 2, 80 * scaleHeight)];
    [querenmimaLeft setTitle:NSLocalizedString(@"Confirm Password", @"") forState:UIControlStateNormal];
    [querenmimaLeft setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [querenmimaLeft setImage:[UIImage imageNamed:@"zhuce2_icon_querenmima.png"] forState:UIControlStateNormal];
    querenmimaLeft.userInteractionEnabled = NO;
    _QueRenMiMaTF.leftView = querenmimaLeft;
    _QueRenMiMaTF.leftViewMode = UITextFieldViewModeAlways;
    _QueRenMiMaTF.secureTextEntry = YES;
    [_scrollView addSubview:_QueRenMiMaTF];
    
    //下一步按钮
    UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(24 * scaleWidth, 520 * scaleHeight, tfWidth, 80 * scaleHeight)];
    [nextBtn setBackgroundImage:[UIImage imageNamed:@"zhuce2_btn_xiayibu_p.png"] forState:UIControlStateNormal];
    [nextBtn setTitle:NSLocalizedString(@"NEXT", @"") forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:nextBtn];
    
    _scrollView.contentSize = CGSizeMake(Screen_Width, 600 * scaleHeight + 216);
    
}

//下一步按钮的点击事件
- (void)next {
    
    [_settingMiMaTF resignFirstResponder];
    [_QueRenMiMaTF resignFirstResponder];
    
    if ( _settingMiMaTF.text.length && _QueRenMiMaTF.text.length) {
        
        if ([_settingMiMaTF.text isEqualToString:_QueRenMiMaTF.text] == YES) {
            if (self.isCosumer) {
                CosumerViewController *cosumerViewController = [[CosumerViewController alloc] init];
                cosumerViewController.mimaString = _settingMiMaTF.text;
                cosumerViewController.telString = self.telString;
                [self.navigationController pushViewController:cosumerViewController animated:YES];
            }
            else {
                FarmerViewController *farmerViewController = [[FarmerViewController alloc] init];
                farmerViewController.mimaString = _settingMiMaTF.text;
                farmerViewController.telString = self.telString;
                [self.navigationController pushViewController:farmerViewController animated:YES];
            }
        }
        else {
            
            UIAlertController*alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"Passwords don't match", @"") preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                
                [self.view endEditing:YES];
                [UIView animateWithDuration:0.5 animations:^{
                    CGRect frame = CGRectMake(0, 0, Screen_Width, Screen_Height);
                    self.view.frame = frame;
                }];
                
            }];
            [alertController addAction:otherAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }

    }
    else {
    
        UIAlertController*alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"The password is not empty", @"") preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
            
            
        }];
        [alertController addAction:otherAction];
        [self presentViewController:alertController animated:YES completion:nil];
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

#pragma mark -UITextFiled的代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
