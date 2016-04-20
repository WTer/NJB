//
//  FarmerViewController.m
//  农帮乐
//
//  Created by hpz on 15/12/1.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "FarmerViewController.h"
#import "TfButton.h"
#import "LoginViewController.h"
#import "AreaButton.h"
#import "TabBarViewController.h"
#import "AppDelegate.h"
#import "MyNavigationController.h"
#import "SelectDiZhiTableViewCell.h"

@interface FarmerViewController ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation FarmerViewController
{
    UITextField *_settingNiChengTF;
    UIButton *_iconBtn;
    UIButton *_setIconBtn;
    AreaButton *_shengBtn;
    AreaButton *_shiBtn;
    
    UITextField *_dizhiTF;
    UITextField *_telphoneTF;
    UITextField *_companyWebTF;
    
    
    UIImagePickerController *_imagePickerController;
    BOOL _isSettingIcon;
    JQBaseRequest *_JQRequest;
    
    NSMutableArray *_dataArray;
    NSMutableArray *_shengDataArray;
    UITableView *_shengTableView;
    NSMutableArray *_shiDataArray;
    UITableView *_shiTableView;
    
    UIScrollView *_scrollView;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _JQRequest = [[JQBaseRequest alloc] init];
    _dataArray = [[NSMutableArray alloc] init];
    _shengDataArray = [[NSMutableArray alloc] init];
    _shiDataArray = [[NSMutableArray alloc] init];
    
    
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
//登录按钮的点击事件
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
    _settingNiChengTF.background = [UIImage imageNamed:@"zhuce3-2_input.png"];
    _settingNiChengTF.clearButtonMode = UITextFieldViewModeAlways;
    _settingNiChengTF.delegate = self;
    CGSize settingNiChengSize = [NSLocalizedString(@"Set up a nickname", @"") sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(990, 100)];
    TfButton *settingNiChengLeft = [[TfButton alloc] initWithFrame:CGRectMake(0, 0, settingNiChengSize.width * 2, 80 * scaleHeight)];
    [settingNiChengLeft setTitle:NSLocalizedString(@"Set up a nickname", @"") forState:UIControlStateNormal];
    [settingNiChengLeft setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [settingNiChengLeft setImage:[UIImage imageNamed:@"zhuce3-2_icon_nicheng.png"] forState:UIControlStateNormal];
    settingNiChengLeft.userInteractionEnabled = NO;
    _settingNiChengTF.leftView = settingNiChengLeft;
    _settingNiChengTF.leftViewMode = UITextFieldViewModeAlways;
    [_scrollView addSubview:_settingNiChengTF];
    
    
    //省份按钮
    CGFloat btnWidth = (720 - 24 * 3) / 2 * scaleWidth;
    _shengBtn = [[AreaButton alloc] initWithFrame:CGRectMake(24 * scaleWidth, 430 * scaleHeight, btnWidth, 80 * scaleHeight)];
    [_shengBtn setBackgroundImage:[UIImage imageNamed:@"zhuce3-2_btn_xuanzedizhi.png"] forState:UIControlStateNormal];
    [_shengBtn setTitle:NSLocalizedString(@"BEIJING", @"") forState:UIControlStateNormal];
    [_shengBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [_shengBtn setImage:[UIImage imageNamed:@"zhuce3-2_btn_icon_xiala.png"] forState:UIControlStateNormal];
    [_shengBtn addTarget:self action:@selector(xuanzeSheng) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_shengBtn];
    
    //城市按钮
    _shiBtn = [[AreaButton alloc] initWithFrame:CGRectMake(48 * scaleWidth + btnWidth, 430 * scaleHeight, btnWidth, 80 * scaleHeight)];
    [_shiBtn setBackgroundImage:[UIImage imageNamed:@"zhuce3-2_btn_xuanzedizhi.png"] forState:UIControlStateNormal];
    [_shiBtn setTitle:NSLocalizedString(@"ChaoYangQu", @"") forState:UIControlStateNormal];
    [_shiBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [_shiBtn setImage:[UIImage imageNamed:@"zhuce3-2_btn_icon_xiala.png"] forState:UIControlStateNormal];
    [_shiBtn addTarget:self action:@selector(xuanzeShi) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_shiBtn];

    
    //地址TextField
    _dizhiTF = [[UITextField alloc] initWithFrame:CGRectMake(24 * scaleWidth, 530 * scaleHeight, tfWidth, 80 * scaleHeight)];
    _dizhiTF.background = [UIImage imageNamed:@"zhuce3-2_input.png"];
    _dizhiTF.clearButtonMode = UITextFieldViewModeAlways;
    _dizhiTF.delegate = self;
    CGSize dizhiSize = [NSLocalizedString(@"Detail Address", @"") sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(990, 100)];
    TfButton *dizhiLeft = [[TfButton alloc] initWithFrame:CGRectMake(0, 0, dizhiSize.width * 2, 80 * scaleHeight)];
    [dizhiLeft setTitle:NSLocalizedString(@"Detail Address", @"") forState:UIControlStateNormal];
    [dizhiLeft setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [dizhiLeft setImage:[UIImage imageNamed:@"zhuce3-2_icon_dizhi.png"] forState:UIControlStateNormal];
    dizhiLeft.userInteractionEnabled = NO;
    _dizhiTF.leftView = dizhiLeft;
    _dizhiTF.leftViewMode = UITextFieldViewModeAlways;
    [_scrollView addSubview:_dizhiTF];
    
    //电话TextField
    _telphoneTF = [[UITextField alloc] initWithFrame:CGRectMake(24 * scaleWidth, 630 * scaleHeight, tfWidth, 80 * scaleHeight)];
    _telphoneTF.background = [UIImage imageNamed:@"zhuce3-2_input.png"];
    _telphoneTF.clearButtonMode = UITextFieldViewModeAlways;
    _telphoneTF.delegate = self;
    CGSize telphoneSize = [NSLocalizedString(@"Contact phone", @"") sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(990, 100)];
    TfButton *telphoneLeft = [[TfButton alloc] initWithFrame:CGRectMake(0, 0, telphoneSize.width * 2, 80 * scaleHeight)];
    [telphoneLeft setTitle:NSLocalizedString(@"Contact phone", @"") forState:UIControlStateNormal];
    [telphoneLeft setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [telphoneLeft setImage:[UIImage imageNamed:@"zhuce3-2_icon_dianhua.png"] forState:UIControlStateNormal];
    telphoneLeft.userInteractionEnabled = NO;
    _telphoneTF.leftView = telphoneLeft;
    _telphoneTF.leftViewMode = UITextFieldViewModeAlways;
    [_scrollView addSubview:_telphoneTF];
    
    //公司网站TextField
    _companyWebTF = [[UITextField alloc] initWithFrame:CGRectMake(24 * scaleWidth, 720 * scaleHeight, tfWidth, 80 * scaleHeight)];
    _companyWebTF.background = [UIImage imageNamed:@"zhuce3-2_input.png"];
    _companyWebTF.clearButtonMode = UITextFieldViewModeAlways;
    _companyWebTF.delegate = self;
    CGSize companyWebSize = [NSLocalizedString(@"Company Web", @"") sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(990, 100)];
    TfButton *companyWebLeft = [[TfButton alloc] initWithFrame:CGRectMake(0, 0, companyWebSize.width * 2, 80 * scaleHeight)];
    [companyWebLeft setTitle:NSLocalizedString(@"Company Web", @"") forState:UIControlStateNormal];
    [companyWebLeft setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [companyWebLeft setImage:[UIImage imageNamed:@"zhuce3-2_icon_wangzhan.png"] forState:UIControlStateNormal];
    companyWebLeft.userInteractionEnabled = NO;
    _companyWebTF.leftView = companyWebLeft;
    _companyWebTF.leftViewMode = UITextFieldViewModeAlways;
    [_scrollView addSubview:_companyWebTF];
    
    //下一步按钮
    UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(24 * scaleWidth, 900 * scaleHeight, tfWidth, 80 * scaleHeight)];
    [nextBtn setBackgroundImage:[UIImage imageNamed:@"zhuce2_btn_xiayibu_p.png"] forState:UIControlStateNormal];
    [nextBtn setTitle:NSLocalizedString(@"NEXT", @"") forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:nextBtn];
    
    _scrollView.contentSize = CGSizeMake(Screen_Width, 980 * scaleHeight + 216);
    
}
#pragma mark -UITextFiled的代理方法
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField != _settingNiChengTF) {
        
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame = CGRectMake(0, - 300 * scaleHeight, Screen_Width, Screen_Height + 300 * scaleHeight);
            self.view.frame = frame;
        }];
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [_settingNiChengTF resignFirstResponder];
    [_settingNiChengTF resignFirstResponder];
    [_dizhiTF resignFirstResponder];
    [_telphoneTF resignFirstResponder];
    [_companyWebTF resignFirstResponder];
    
    if (textField != _settingNiChengTF) {
        
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame = CGRectMake(0, 64, Screen_Width, Screen_Height - 64);
            self.view.frame = frame;
        }];
    }
    
    return YES;
}

//下一步按钮的点击事件
- (void)next {
    
    [self.view endEditing:YES];
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = CGRectMake(0, 64, Screen_Width, Screen_Height - 64);
        self.view.frame = frame;
    }];
    [[JudgeNetState shareInstance] monitorNetworkType:self.view complete:^(NSInteger state) {
        if (state == 1 || state == 2) {
            if (_settingNiChengTF.text.length && _dizhiTF.text.length && _telphoneTF.text.length && _companyWebTF.text.length && _isSettingIcon) {
                
                //农场主注册成功
                NSDictionary * dict = @{@"LoginName":self.telString, @"Password":self.mimaString ,@"DisplayName":_settingNiChengTF.text, @"Province":_shengBtn.titleLabel.text,@"City":_shiBtn.titleLabel.text, @"Address":_dizhiTF.text, @"Telephone":_telphoneTF.text, @"Website":_companyWebTF.text};
                
                [_JQRequest FarmOwnerRegisterBaseMassage:dict complete:^(NSDictionary *responseObject) {
                    NSLog(@"%@" ,responseObject);
                    
                    //把农场主id和农场主类型永久存储
                    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                    [ud setObject:[NSString stringWithFormat:@"%@",responseObject[@"id"]] forKey:@"ProducerId"];
                    [ud setBool:NO forKey:@"IsConsumer"];
                    [ud setObject:[NSString stringWithFormat:@"%@",responseObject[@"id"]] forKey:UserID];
                    [ud synchronize];
                    [self saveUserCategory];
                    
                    //农场主上传头像到服务器
                    NSDictionary * iconDict = @{@"BigPortrait":_iconBtn.currentBackgroundImage, @"SmallPortrait":_iconBtn.currentBackgroundImage};
                    [_JQRequest FarmerOwnerRegisterOrAlertHeaderImageWithProducerID:[NSString stringWithFormat:@"%@", responseObject[@"id"]] dictMessage:iconDict complete:^(NSDictionary *responseObject) {
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
                    NSLog(@"%@" ,errorString);
                    
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"Nickname already exist or mobile phone number has been registered. Please enter directly", @"") preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction *otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                        
                    }];
                    [alertController addAction:otherAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                }];
                
            }
            else if (!_isSettingIcon) {
                
                UIAlertController*alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"Oh you haven't choose！", @"") preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                    
                    
                }];
                [alertController addAction:otherAction];
                [self presentViewController:alertController animated:YES completion:nil];
                
                
            }
            else {
                
                UIAlertController*alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"Input can't be empty", @"") preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                    
                }];
                [alertController addAction:otherAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }

        }
    }];
}
#pragma mark  ---存储用户类型
- (void)saveUserCategory {
    
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@"农场主" forKey:UserCategory];
    [ud synchronize];
}
//选择城市
- (void)xuanzeSheng {
    
    [self.view endEditing:YES];
    _scrollView.alpha = 0.6;
    _scrollView.userInteractionEnabled = NO;
    
    [_JQRequest getWeiZhiComplete:^(NSDictionary *responseObject) {
        
        NSLog(@"%@",responseObject);
        [_dataArray removeAllObjects];
        [_shengDataArray removeAllObjects];
        
        _dataArray = responseObject[@"List"];
        NSArray *list = responseObject[@"List"];
       
        
        //所有省份
        for (NSInteger i = 0; i < list.count; i++) {
            NSDictionary *dict = list[i];
            [_shengDataArray addObject:dict[@"Province"]];
        }
        
        _shengTableView = [[UITableView alloc] initWithFrame:CGRectMake(90 * scaleWidth, 140 * scaleHeight, 540 * scaleWidth, 102 * scaleHeight * (_shengDataArray.count + 1))];
        _shengTableView.dataSource = self;
        _shengTableView.delegate = self;
        [self.view addSubview:_shengTableView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 540 * scaleWidth, 102 * scaleHeight)];
        label.text = NSLocalizedString(@"Please select a province", @"");
        _shengTableView.tableHeaderView = label;
        
        
    } fail:^(NSError *error, NSString *errorString) {
        NSLog(@"%@",errorString);
    }];

}
//tableView的代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 102 * scaleHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == _shengTableView) {
        return _shengDataArray.count;
    }
    if (tableView == _shiTableView) {
        return _shiDataArray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _shengTableView) {
        
        SelectDiZhiTableViewCell *selectCell = [tableView dequeueReusableCellWithIdentifier:@"shengTableViewCell"];
        if (!selectCell) {
            selectCell = [[SelectDiZhiTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"shengTableViewCell"];
        }
        selectCell.dizhiLabel.text = _shengDataArray[indexPath.row];
        return selectCell;
    }
    if (tableView == _shiTableView) {
        
        SelectDiZhiTableViewCell *selectCell = [tableView dequeueReusableCellWithIdentifier:@"shiTableViewCell"];
        if (!selectCell) {
            selectCell = [[SelectDiZhiTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"shiTableViewCell"];
        }
        selectCell.dizhiLabel.text = _shiDataArray[indexPath.row];
        return selectCell;
        
    }
    return nil;
}
//tableView的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //shengTableView
    if (tableView == _shengTableView) {
        
        [_shiDataArray removeAllObjects];
                
        for (NSInteger i = 0; i < _dataArray.count; i++) {
            NSDictionary *dict = _dataArray[i];
            if ([dict[@"Province"] isEqualToString:_shengDataArray[indexPath.row]] == YES) {
                
                NSArray *cityArray = dict[@"City"];
                for (NSDictionary *cityDict in cityArray) {
                    for (NSString *key in cityDict.allKeys) {
                        if ([key isEqualToString:@"District"] == YES) {
                            
                        }
                        else {
                            [_shiDataArray addObject:cityDict[key]];
                        }
                    }
                }
            }
        }
        
        
        [_shengTableView removeFromSuperview];
        _scrollView.alpha = 1;
        _scrollView.userInteractionEnabled = YES;
        [_shengBtn setTitle:_shengDataArray[indexPath.row] forState:UIControlStateNormal];
        if (_shiDataArray.count) {
            [_shiBtn setTitle:_shiDataArray[0] forState:UIControlStateNormal];
        }
        
        
    }
    //shiTableView
    if (tableView == _shiTableView) {
        
        [_shiDataArray removeAllObjects];
       
        NSArray *cityArray = [[NSArray alloc] init];
        for (NSInteger i = 0; i < _dataArray.count; i++) {
            NSDictionary *dict = _dataArray[i];
            
            if ([dict[@"Province"] isEqualToString:_shengBtn.titleLabel.text] == YES) {
                
                cityArray = dict[@"City"];
                
                for (NSDictionary *cityDict in cityArray) {
                    
                    for (NSString *key in cityDict.allKeys) {
                        
                        if ([key isEqualToString:@"District"] == NO) {
                            
                            [_shiDataArray addObject:cityDict[key]];
                            
                        }
                    }
                }
                
                [_shiBtn setTitle:_shiDataArray[indexPath.row] forState:UIControlStateNormal];
                
            }
        }
        
        [_shiTableView removeFromSuperview];
        _scrollView.alpha = 1;
        _scrollView.userInteractionEnabled = YES;
    }
}
//选择地区
- (void)xuanzeShi {
    
    [self.view endEditing:YES];
    _scrollView.alpha = 0.6;
    _scrollView.userInteractionEnabled = NO;
    
    if (_shengBtn.titleLabel.text.length) {
        
        NSLog(@"选择城市");
        
        [_shengTableView removeFromSuperview];
        
        [_JQRequest getWeiZhiComplete:^(NSDictionary *responseObject) {
            
            NSArray *list = responseObject[@"List"];
            [_shiDataArray removeAllObjects];
            //所有省份
            for (NSInteger i = 0; i < list.count; i++) {
                NSDictionary *dict = list[i];
                [_shengDataArray addObject:dict[@"Province"]];
                //该省的所有城市
                if ([dict[@"Province"] isEqualToString:_shengBtn.titleLabel.text] == YES) {
                    
                    NSArray *cityArray = dict[@"City"];
                    
                    for (NSDictionary *cityDict in cityArray) {
                        
                        for (NSString *key in cityDict.allKeys) {
                            
                            if ([key isEqualToString:@"District"] == YES) {
                                
                            }
                            else {
                                [_shiDataArray addObject:cityDict[key]];
                            }
                        }
                    }
                }
            }
            _shiTableView = [[UITableView alloc] initWithFrame:CGRectMake(90 * scaleWidth, 140 * scaleHeight, 540 * scaleWidth, 102 * scaleHeight * (_shiDataArray.count + 1))];
            _shiTableView.dataSource = self;
            _shiTableView.delegate = self;
            [self.view addSubview:_shiTableView];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 540 * scaleWidth, 102 * scaleHeight)];
            label.text = NSLocalizedString(@"Please select a city", @"");
            _shiTableView.tableHeaderView = label;
            
        } fail:^(NSError *error, NSString *errorString) {
            NSLog(@"%@",errorString);
        }];
    }

}
//设置头像的点击按钮
- (void)iconSetting {
    
    [self.view endEditing:YES];
    
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
