//
//  CosumerViewController.m
//  农帮乐
//
//  Created by hpz on 15/12/1.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "CosumerViewController.h"
#import "TfButton.h"
#import "LoginViewController.h"
#import "TabBarViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "MyNavigationController.h"
@interface CosumerViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>

@end

@implementation CosumerViewController
{
    UITextField *_settingNiChengTF;
    UIButton *_iconBtn;
    UIButton *_setIconBtn;
    UIImagePickerController * _imagePickerController;
    BOOL _isSettingIcon;
    JQBaseRequest *_JQRequest;
    
    UIScrollView *_scrollView;
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
    
    _JQRequest = [[JQBaseRequest alloc] init];
}
//点击登录按钮的响应事件
- (void)login {
    
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
    
}
//导航栏的返回按钮
- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createUI {
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height - 64)];
    [self.view addSubview:_scrollView];
    
    //topPicture
    UIImageView *topPicture = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 260 * scaleHeight)];
    topPicture.backgroundColor = [UIColor greenColor];
    topPicture.userInteractionEnabled = YES;
    [_scrollView addSubview:topPicture];
    
    //头像按钮
    _iconBtn = [[UIButton alloc] initWithFrame:CGRectMake(Screen_Width / 2 - 75 * scaleWidth, 30 * scaleHeight, 150 * scaleHeight, 150 * scaleHeight)];
    [_iconBtn setBackgroundImage:[UIImage imageNamed:@"zhuce3_btn_shezhitouxiang_n.png"] forState:UIControlStateNormal];
    [_iconBtn addTarget:self action:@selector(iconSetting) forControlEvents:UIControlEventTouchUpInside];
    _iconBtn.layer.cornerRadius = _iconBtn.frame.size.width * 0.5;
    _iconBtn.layer.masksToBounds = YES;
    [topPicture addSubview:_iconBtn];
    //设置头像文字按钮
    _setIconBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 210 * scaleHeight, Screen_Width, 30 * scaleHeight)];
    [_setIconBtn setTitle:NSLocalizedString(@"Click on set up your icon", @"") forState:UIControlStateNormal];
    [_setIconBtn addTarget:self action:@selector(iconSetting) forControlEvents:UIControlEventTouchUpInside];
    [topPicture addSubview:_setIconBtn];
    
    
    //设置昵称TextField
    CGFloat tfWidth = (720 - 24 * 2) * scaleWidth;
    _settingNiChengTF = [[UITextField alloc] initWithFrame:CGRectMake(24 * scaleWidth, 330 * scaleHeight, tfWidth, 80 * scaleHeight)];
    _settingNiChengTF.background = [UIImage imageNamed:@"zhuce3_input.png"];
    _settingNiChengTF.clearButtonMode = UITextFieldViewModeAlways;
    CGSize settingNiChengSize = [NSLocalizedString(@"Set up a nickname", @"") sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(990, 100)];
    TfButton *settingNiChengLeft = [[TfButton alloc] initWithFrame:CGRectMake(0, 0, settingNiChengSize.width * 2, 80 * scaleHeight)];
    [settingNiChengLeft setTitle:NSLocalizedString(@"Set up a nickname", @"") forState:UIControlStateNormal];
    [settingNiChengLeft setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [settingNiChengLeft setImage:[UIImage imageNamed:@"zhuce3_icon_shezhitouxiang.png"] forState:UIControlStateNormal];
    settingNiChengLeft.userInteractionEnabled = NO;
    _settingNiChengTF.leftView = settingNiChengLeft;
    _settingNiChengTF.leftViewMode = UITextFieldViewModeAlways;
    _settingNiChengTF.delegate = self;
    [_scrollView addSubview:_settingNiChengTF];

    //下一步按钮
    UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(24 * scaleWidth, 510 * scaleHeight, tfWidth, 80 * scaleHeight)];
    [nextBtn setBackgroundImage:[UIImage imageNamed:@"zhuce3_btn_xiayibu_p.png"] forState:UIControlStateNormal];
    [nextBtn setTitle:NSLocalizedString(@"NEXT", @"") forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:nextBtn];
    
    _scrollView.contentSize = CGSizeMake(Screen_Width, 590 * scaleHeight + 216);
    
}
//点击下一步按钮
- (void)next {

    [self.view endEditing:YES];
    

    [[JudgeNetState shareInstance] monitorNetworkType:self.view complete:^(NSInteger state) {
        if (state ==1 || state == 2) {
            NSLog(@"%d",_isSettingIcon);
            if (_settingNiChengTF.text.length && _isSettingIcon) {
                
                NSLog(@"%@ %@ %@", self.telString, self.mimaString, _settingNiChengTF.text);
                //消费者注册成功
                NSDictionary * dict = @{@"LoginName":self.telString, @"Password":self.mimaString, @"DisplayName":_settingNiChengTF.text};
                [_JQRequest ConsumerRegisterBaseMessageWithMessageDict:dict complete:^(NSDictionary *responseObject) {
                    
                    NSLog(@"%@", responseObject);
                    
                    //把消费者id和消费者类型永久存储
                    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                    [ud setObject:[NSString stringWithFormat:@"%@",responseObject[@"id"]] forKey:@"ConsumerId"];
                    [ud setBool:YES forKey:@"IsConsumer"];
                    [ud setObject:[NSString stringWithFormat:@"%@",responseObject[@"id"]] forKey:UserID];
                    [ud synchronize];
                    [self saveUserCategory];

                    
                    //消费者上传头像到服务器
                    NSDictionary * iconDict = @{@"BigPortrait":_iconBtn.currentBackgroundImage, @"SmallPortrait":_iconBtn.currentBackgroundImage};
                    [_JQRequest ConsumerRegisterOrAlertHeaderImageWithConsumerID:[NSString stringWithFormat:@"%@", responseObject[@"id"]] ConsumerDictMessage:iconDict complete:^(NSDictionary *responseObject) {
                        NSLog(@"%@", responseObject);
                        
                        [self.view removeFromSuperview];
                        TabBarViewController *mainVC = [[TabBarViewController alloc] init];
                        mainVC.isRegister = YES;
                        AppDelegate * app = [UIApplication sharedApplication].delegate;
                        MyNavigationController * mvc = [[MyNavigationController alloc]initWithRootViewController:mainVC];
                        app.window.rootViewController = mvc;
                        
                    } fail:^(NSError *error, NSString *errorString) {
                        NSLog(@"%@", errorString);
                    }];
                    
                    
                } fail:^(NSError *error, NSString *errorString) {
                    NSLog(@"%@",errorString);
                    
                    UIAlertController*alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"Nickname already exist or mobile phone number has been registered. Please enter directly", @"") preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                        
                        
                    }];
                    [alertController addAction:otherAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                }];
            }
            else if (!_settingNiChengTF.text.length) {
                
                UIAlertController*alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"The nickName is not empty", @"") preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                    
                }];
                [alertController addAction:otherAction];
                [self presentViewController:alertController animated:YES completion:nil];
                
            }
            else {
                
                UIAlertController*alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"Oh you haven't choose！", @"") preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                    
                    [self.view endEditing:YES];
                    
                }];
                [alertController addAction:otherAction];
                [self presentViewController:alertController animated:YES completion:nil];
                
            }

        }
    }];
}
#pragma mark  -- 将用户类型放入userdefault中
- (void)saveUserCategory
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@"消费者" forKey:UserCategory];
    [ud synchronize];
}

#pragma mark -UITextFiled的代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [_settingNiChengTF resignFirstResponder];
    
    return YES;
}

//点击设置头像按钮
- (void)iconSetting {

    
    _imagePickerController = [[UIImagePickerController alloc] init];
    
    //操作类型
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == YES) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"CANCLE", @"") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Camera", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //相机
            _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:_imagePickerController animated:YES completion:nil];
            
        }];
        UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Choose from the album", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            //相册
            _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //设置代理
            _imagePickerController.delegate = self;
            
            [self presentViewController:_imagePickerController animated:YES completion:nil];
            
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:deleteAction];
        [alertController addAction:archiveAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    else{
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"CANCLE", @"") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            //相机
            _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:_imagePickerController animated:YES completion:nil];
            
        }];
        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Camera", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Choose from the album", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //相册
            _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //设置代理
            _imagePickerController.delegate = self;
            
            [self presentViewController:_imagePickerController animated:YES completion:nil];
            
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:deleteAction];
        [alertController addAction:archiveAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    


    
}
#pragma mark -UIImagePickerController的代理方法

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    [_iconBtn setBackgroundImage:info[UIImagePickerControllerOriginalImage] forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
    _isSettingIcon = YES;
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    _isSettingIcon = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
