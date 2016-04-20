//
//  AlertUserMessageViewController.m
//  农帮乐
//
//  Created by 王朝源 on 15/12/14.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "AlertUserMessageViewController.h"
#import "TfButton.h"
#import "LoginViewController.h"
#import "AreaButton.h"
#import "TabBarViewController.h"
#import "UIImageView+WebCache.h"
#import "cityListTableViewCell.h"

@interface AlertUserMessageViewController ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@end

@implementation AlertUserMessageViewController
{
    UITextField *_settingNiChengTF;
    UIButton *_iconBtn;
    UIButton *_setIconBtn;
    AreaButton *_cityBtn;
    AreaButton *_quBtn;
    
    UITextField *_dizhiTF;
    UITextField *_telphoneTF;
    UITextField *_companyWebTF;
    
    BOOL _isSelectCity;
    
    UIPickerView *_cityPickerView;
    UIPickerView *_quPickerView;
    
    UIImagePickerController *_imagePickerController;
    BOOL _isSettingIcon;
    JQBaseRequest *_JQRequest;
    
    UIImage * _image;//用户从相机或者相册获取的图片
    UIImageView * _imageView;
    
    NSMutableArray * _dataDictionary;
    NSMutableArray * _dataCityList;//数据字典用于放省份 以及城市
    
    UITableView * _tableView;
    
    UIButton * _xuanzhediqu;
    
    NSInteger  _indexCity;
    
    BOOL _isprovence;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _indexCity = 0;
    _isprovence = YES;
    _JQRequest = [[JQBaseRequest alloc] init];
    _dataDictionary = [[NSMutableArray alloc]init];
    _dataCityList = [[NSMutableArray alloc]init];
    self.title = NSLocalizedString(@"我的信息", @"");
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self pdUserCateGory];
    [self requestCityList];
}
#pragma mark  ---创建tableview
- (void)createTableView
{
    _tableView = nil;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width - 80 * scaleWidth, 400* scaleHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[cityListTableViewCell class] forCellReuseIdentifier:@"cell"];
    [_xuanzhediqu addSubview:_tableView];
    _tableView.center = _xuanzhediqu.center;
    _tableView.rowHeight = 40;
    [self setExtraCellLineHidden:_tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isprovence) {
        if (_dataDictionary.count == 0) {
            return 0;
        }
        return [_dataDictionary count];
    }else{
        [self panduanCitlistDijizhu];
        if (_dataCityList.count == 0) {
            return 0;
        }
        return [_dataCityList[_indexCity] count];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cityListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (_isprovence) {
        cell.cityLable.text = _dataDictionary[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell cellBeClick:^(UIButton *button) {
            cell.selectedButton.selected = YES;
            [_cityBtn setTitle:_dataDictionary[indexPath.row] forState:UIControlStateNormal];
            [self panduanCitlistDijizhu];
            [_quBtn setTitle:_dataCityList[_indexCity][0] forState:UIControlStateNormal];
            [self performSelector:@selector(removebj) withObject:nil afterDelay:0.1];
        }];
    }else{
        [self panduanCitlistDijizhu];
        cell.cityLable.text = _dataCityList[_indexCity][indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell cellBeClick:^(UIButton *button) {
            cell.selectedButton.selected = YES;
            [_quBtn setTitle:_dataCityList[_indexCity][indexPath.row] forState:UIControlStateNormal];
            [self performSelector:@selector(removebj) withObject:nil afterDelay:0.1];
        }];
    }
    return cell;
}
- (void)removebj
{
    [_xuanzhediqu removeFromSuperview];
}

#pragma mark --判定city是第几主
- (void)panduanCitlistDijizhu
{
    for (int i = 0; i < [_dataDictionary count]; i++) {
        if ([_dataDictionary[i] isEqualToString:_cityBtn.titleLabel.text] == YES) {
            _indexCity = i;
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    [[UITableViewHeaderFooterView appearance] setTintColor:[UIColor whiteColor]];
    if (_isprovence) {
        return NSLocalizedString(@"修改省份", @"");
    }
    return NSLocalizedString(@"修改城市", @"");
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

#pragma mark ---请求城市列表
- (void)requestCityList
{
    NSDictionary * responseObject1 = [NSDictionary dictionaryWithContentsOfFile:CityList];
    if (responseObject1) {
        [self jiazaiCityList];
    }else{
        [_JQRequest GETrequestWitUrlString:@"http://182.92.224.165/Common/ProvinceCityList" para:nil complete:^(NSDictionary *responseObject) {
            [responseObject writeToFile:CityList atomically:YES];
            [self jiazaiCityList];
            [_tableView reloadData];
        } fail:^(NSError *error, NSString *errorString) {
            
        }];
    }
}

#pragma mark ---根据本地的citylist请求数据
- (void)jiazaiCityList
{
    NSDictionary * responseObject = [NSDictionary dictionaryWithContentsOfFile:CityList];
    NSArray * array = responseObject[@"List"];
    for (NSDictionary * dict in array) {
        NSMutableArray * arr = [[NSMutableArray alloc]init];
        NSString * str = dict[@"Province"];
        NSArray * arr2 = dict[@"City"];
        for (NSDictionary * dicct in arr2) {
            for (NSString * key in dicct) {
                if ([key isEqualToString:@"District"] == NO) {
                    [arr addObject:dicct[key]];
                }
            }
        }
        [_dataDictionary addObject:str];
        [_dataCityList addObject:arr];
    }
}

//导航栏的返回按钮
- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)pdUserCateGory
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    NSString * str = [ud objectForKey:UserCategory];
    if ([str isEqualToString:@"消费者"]== YES) {
        [self createuiConsumer];
    }else{
        [self createUIFarm];
    }
}
- (void)createuiConsumer
{
    NSDictionary * dict = [NSDictionary dictionaryWithContentsOfFile:UserMessageLocalAdress];
//    [headerImageView sd_setImageWithURL:[NSURL URLWithString:dict[@"bigportraiturl"]] placeholderImage:[UIImage imageNamed:@"grzx_btn_touxiang.png"]];
    UIImageView *topPicture = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 260 * scaleHeight)];
    topPicture.backgroundColor = BaseColor(14, 184, 58, 1);
    topPicture.userInteractionEnabled = YES;
    [self.view addSubview:topPicture];
    
    //头像按钮
    _iconBtn = [[UIButton alloc] initWithFrame:CGRectMake(Screen_Width / 2 - 75 * scaleWidth, 30 * scaleHeight, 150 * scaleHeight, 150 * scaleHeight)];
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(Screen_Width / 2 - 75 * scaleWidth, 30 * scaleHeight, 150 * scaleHeight, 150 * scaleHeight)];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:dict[@"bigportraiturl"]] placeholderImage:[UIImage imageNamed:@"grzx_btn_touxiang.png"]];
    [_iconBtn addTarget:self action:@selector(iconSetting) forControlEvents:UIControlEventTouchUpInside];
    _imageView.layer.cornerRadius = _iconBtn.frame.size.width / 2.0;
    _imageView.layer.masksToBounds = YES;
    [topPicture addSubview:_iconBtn];
    //设置头像文字按钮
    _setIconBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 210 * scaleHeight, Screen_Width, 30 * scaleHeight)];
    [_setIconBtn setTitle:NSLocalizedString(@"Click on set up your icon", @"") forState:UIControlStateNormal];
    [_setIconBtn addTarget:self action:@selector(iconSetting) forControlEvents:UIControlEventTouchUpInside];
    [topPicture addSubview:_imageView];
    [topPicture addSubview:_setIconBtn];
    
    
    //设置昵称TextField
    CGFloat tfWidth = (720 - 24 * 2) * scaleWidth;
    _settingNiChengTF = [[UITextField alloc] initWithFrame:CGRectMake(24 * scaleWidth, 330 * scaleHeight, tfWidth, 80 * scaleHeight)];
    _settingNiChengTF.background = [UIImage imageNamed:@"zhuce3-2_input.png"];
    _settingNiChengTF.clearButtonMode = UITextFieldViewModeAlways;
    CGSize settingNiChengSize = [NSLocalizedString(@"Set up a nickname", @"") sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(990, 100)];
    TfButton *settingNiChengLeft = [[TfButton alloc] initWithFrame:CGRectMake(0, 0, settingNiChengSize.width * 2, 80 * scaleHeight)];
    [settingNiChengLeft setTitle:NSLocalizedString(@"Set up a nickname", @"") forState:UIControlStateNormal];
    [settingNiChengLeft setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [settingNiChengLeft setImage:[UIImage imageNamed:@"zhuce3-2_icon_nicheng.png"] forState:UIControlStateNormal];
    settingNiChengLeft.userInteractionEnabled = NO;
    _settingNiChengTF.leftView = settingNiChengLeft;
    _settingNiChengTF.leftViewMode = UITextFieldViewModeAlways;
    _settingNiChengTF.text = dict[@"displayname"];
    [self.view addSubview:_settingNiChengTF];
    
    UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(24 * scaleWidth, 500 * scaleHeight, tfWidth, 80 * scaleHeight)];
    [nextBtn setBackgroundImage:[UIImage imageNamed:@"zhuce2_btn_xiayibu_p.png"] forState:UIControlStateNormal];
    [nextBtn setTitle:NSLocalizedString(@"NEXT", @"") forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
}

- (void)createUIFarm {
    
    NSDictionary * dict = [NSDictionary dictionaryWithContentsOfFile:UserMessageLocalAdress];
    //topPicture
    UIImageView *topPicture = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 260 * scaleHeight)];
    topPicture.backgroundColor = BaseColor(14, 184, 58, 1);
    topPicture.userInteractionEnabled = YES;
    [self.view addSubview:topPicture];
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(Screen_Width / 2 - 75 * scaleWidth, 30 * scaleHeight, 150 * scaleHeight, 150 * scaleHeight)];
    [topPicture addSubview:_imageView];
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:dict[@"bigportraiturl"]] placeholderImage:[UIImage imageNamed:@"grzx_btn_touxiang.png"]];
    
    //设置imageView的圆角
    _imageView.layer.cornerRadius = 75 * scaleHeight;
    _imageView.layer.masksToBounds = YES;
    //头像按钮
    _iconBtn = [[UIButton alloc] initWithFrame:CGRectMake(Screen_Width / 2 - 75 * scaleWidth, 30 * scaleHeight, 150 * scaleHeight, 150 * scaleHeight)];
    [_iconBtn addTarget:self action:@selector(iconSetting) forControlEvents:UIControlEventTouchUpInside];
    _iconBtn.layer.cornerRadius = _iconBtn.frame.size.width / 2.0;
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
    CGSize settingNiChengSize = [NSLocalizedString(@"Set up a nickname", @"") sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(990, 100)];
    TfButton *settingNiChengLeft = [[TfButton alloc] initWithFrame:CGRectMake(0, 0, settingNiChengSize.width * 2, 80 * scaleHeight)];
    [settingNiChengLeft setTitle:NSLocalizedString(@"Set up a nickname", @"") forState:UIControlStateNormal];
    [settingNiChengLeft setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [settingNiChengLeft setImage:[UIImage imageNamed:@"zhuce3-2_icon_nicheng.png"] forState:UIControlStateNormal];
    settingNiChengLeft.userInteractionEnabled = NO;
    _settingNiChengTF.leftView = settingNiChengLeft;
    _settingNiChengTF.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_settingNiChengTF];
    
    _settingNiChengTF.text = dict[@"displayname"];
//    _settingNiChengTF.delegate = self;
    
    
    //城市按钮
    CGFloat btnWidth = (720 - 24 * 3) / 2 * scaleWidth;
    _cityBtn = [[AreaButton alloc] initWithFrame:CGRectMake(24 * scaleWidth, 430 * scaleHeight, btnWidth, 80 * scaleHeight)];
    [_cityBtn setBackgroundImage:[UIImage imageNamed:@"zhuce3-2_btn_xuanzedizhi.png"] forState:UIControlStateNormal];
    [_cityBtn setTitle:NSLocalizedString(@"BEIJING", @"") forState:UIControlStateNormal];
    [_cityBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [_cityBtn setImage:[UIImage imageNamed:@"zhuce3-2_btn_icon_xiala.png"] forState:UIControlStateNormal];
    [_cityBtn addTarget:self action:@selector(xuanzeCity) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cityBtn];
    [_cityBtn setTitle:dict[@"province"] forState:UIControlStateNormal];
    
    //区域按钮
    _quBtn = [[AreaButton alloc] initWithFrame:CGRectMake(48 * scaleWidth + btnWidth, 430 * scaleHeight, btnWidth, 80 * scaleHeight)];
    [_quBtn setBackgroundImage:[UIImage imageNamed:@"zhuce3-2_btn_xuanzedizhi.png"] forState:UIControlStateNormal];
    [_quBtn setTitle:NSLocalizedString(@"ChaoYangQu", @"") forState:UIControlStateNormal];
    [_quBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [_quBtn setImage:[UIImage imageNamed:@"zhuce3-2_btn_icon_xiala.png"] forState:UIControlStateNormal];
    [_quBtn addTarget:self action:@selector(xuanzeQu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_quBtn];
    
    [_quBtn setTitle:dict[@"city"] forState:UIControlStateNormal];
    
    
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
    [self.view addSubview:_dizhiTF];
    _dizhiTF.text =dict[@"address"];
    
    //电话TextField
    _telphoneTF = [[UITextField alloc] initWithFrame:CGRectMake(24 * scaleWidth, 630 * scaleHeight, tfWidth, 80 * scaleHeight)];
    _telphoneTF.background = [UIImage imageNamed:@"zhuce3-2_input.png"];
    _telphoneTF.clearButtonMode = UITextFieldViewModeAlways;
    _telphoneTF.delegate = self;
    CGSize telSize = [NSLocalizedString(@"Contact phone", @"") sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(990, 100)];
    TfButton *telphoneLeft = [[TfButton alloc] initWithFrame:CGRectMake(0, 0, telSize.width * 2, 80 * scaleHeight)];
    [telphoneLeft setTitle:NSLocalizedString(@"Contact phone", @"") forState:UIControlStateNormal];
    [telphoneLeft setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [telphoneLeft setImage:[UIImage imageNamed:@"zhuce3-2_icon_dianhua.png"] forState:UIControlStateNormal];
    telphoneLeft.userInteractionEnabled = NO;
    _telphoneTF.leftView = telphoneLeft;
    _telphoneTF.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_telphoneTF];
    _telphoneTF.text = dict[@"telephone"];
    
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
    [self.view addSubview:_companyWebTF];
    _companyWebTF.text = dict[@"website"];
    
    //下一步按钮
    UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(24 * scaleWidth, 900 * scaleHeight, tfWidth, 80 * scaleHeight)];
    [nextBtn setBackgroundImage:[UIImage imageNamed:@"zhuce2_btn_xiayibu_p.png"] forState:UIControlStateNormal];
    [nextBtn setTitle:NSLocalizedString(@"NEXT", @"") forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    
}
#pragma mark -UITextFiled的代理方法
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = CGRectMake(0, - 150, Screen_Width, Screen_Height + 150);
        self.view.frame = frame;
    }];
    
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [_settingNiChengTF resignFirstResponder];
    [_dizhiTF resignFirstResponder];
    [_telphoneTF resignFirstResponder];
    [_companyWebTF resignFirstResponder];
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = CGRectMake(0, 64, Screen_Width, Screen_Height);
        self.view.frame = frame;
    }];
    [_cityPickerView removeFromSuperview];
    [_quPickerView removeFromSuperview];
    return YES;
}

//下一步按钮的点击事件
- (void)next {
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    NSString * str = [ud objectForKey:UserCategory];
    JQBaseRequest * jq = [[JQBaseRequest alloc]init];
    if ([str isEqualToString:@"消费者"]== YES) {
        if (_isSettingIcon) {
            NSDictionary * dict = @{@"DisplayName":_settingNiChengTF.text};
            [jq ConsumerAlertBaseMessageWithConsumerID:[ud objectForKey:UserID] ConsumerDictMessage:dict complete:^(NSDictionary *responseObject) {
                [responseObject writeToFile:UserMessageLocalAdress atomically:YES];
            } fail:^(NSError *error, NSString *errorString) {
                
            }];
            UIImage * image = _image;
            UIImage * image2 = _image;
            NSDictionary * dict2 = @{@"BigPortrait":image, @"SmallPortrait":image2};
            [jq ConsumerRegisterOrAlertHeaderImageWithConsumerID:[ud objectForKey:UserID] ConsumerDictMessage:dict2 complete:^(NSDictionary *responseObject) {
                [jq ConsumerSelectedBaseMessageWithConsumerID:[ud objectForKey:UserID] complete:^(NSDictionary *responseObject) {
                    [responseObject writeToFile:UserMessageLocalAdress atomically:YES];
                    [self.navigationController popViewControllerAnimated:YES];
                } fail:^(NSError *error, NSString *errorString) {
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            } fail:^(NSError *error, NSString *errorString) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }else{
            NSDictionary * dict = @{@"DisplayName":_settingNiChengTF.text};
            [jq ConsumerAlertBaseMessageWithConsumerID:[ud objectForKey:UserID] ConsumerDictMessage:dict complete:^(NSDictionary *responseObject) {
                [responseObject writeToFile:UserMessageLocalAdress atomically:YES];
                [self.navigationController popViewControllerAnimated:YES];
            } fail:^(NSError *error, NSString *errorString) {
                [self.navigationController popViewControllerAnimated:YES];
                
            }];
        }
        
    }else{
#warning 未实现
        
        if (_isSettingIcon) {
            NSDictionary * dict2 = @{@"DisplayName":_settingNiChengTF.text ,@"Province": _cityBtn.titleLabel.text,@"City": _quBtn.titleLabel.text,@"Address": _dizhiTF.text,@"Telephone": _telphoneTF.text,@"Website":_companyWebTF.text};
            [jq FarmerOwnerAlertBaseMessageWithProducerID:[ud objectForKey:UserID] dictMessage:dict2 complete:^(NSDictionary *responseObject) {
                UIImage * image = _image;
                UIImage * image2 = _image;
                NSDictionary * dict = @{@"BigPortrait":image, @"SmallPortrait":image2};
                [jq FarmerOwnerRegisterOrAlertHeaderImageWithProducerID:[ud objectForKey:UserID] dictMessage:dict complete:^(NSDictionary *responseObject) {
                    [responseObject writeToFile:UserMessageLocalAdress atomically:YES];
                    [self.navigationController popViewControllerAnimated:YES];
                } fail:^(NSError *error, NSString *errorString) {
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            } fail:^(NSError *error, NSString *errorString) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }else{
            NSDictionary * dict2 = @{@"DisplayName":_settingNiChengTF.text ,@"Province": _cityBtn.titleLabel.text,@"City": _quBtn.titleLabel.text,@"Address": _dizhiTF.text,@"Telephone": _telphoneTF.text,@"Website":_companyWebTF.text};
            [jq FarmerOwnerAlertBaseMessageWithProducerID:[ud objectForKey:UserID] dictMessage:dict2 complete:^(NSDictionary *responseObject) {
               [responseObject writeToFile:UserMessageLocalAdress atomically:YES];
                 [self.navigationController popViewControllerAnimated:YES];
            } fail:^(NSError *error, NSString *errorString) {
               [self.navigationController popViewControllerAnimated:YES];
            }];

        }
        
    }
    
}


#pragma mark --选择地区
- (void)xuanzeQu {
    _isprovence = NO;
    _xuanzhediqu = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    _xuanzhediqu.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
    [_xuanzhediqu addTarget:self action:@selector(cancleQuxiaoSelected:) forControlEvents:UIControlEventTouchUpInside];
    [[UIApplication sharedApplication].keyWindow addSubview:_xuanzhediqu];
    [self createTableView];
    
}
- (void)xuanzeCity
{
    _isprovence = YES;
    _xuanzhediqu = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    _xuanzhediqu.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
    [_xuanzhediqu addTarget:self action:@selector(cancleQuxiaoSelected:) forControlEvents:UIControlEventTouchUpInside];
    [[UIApplication sharedApplication].keyWindow addSubview:_xuanzhediqu];
    [self createTableView];
}
#pragma mark  --取消选择地区
- (void)cancleQuxiaoSelected:(UIButton *)button
{
    [button removeFromSuperview];
}

//设置头像的点击按钮
- (void)iconSetting {
    
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]==NO) {
//        NSLog(@"设备不可用");
//        
//    }
//    _imagePickerController = [[UIImagePickerController alloc] init];
//    
//    //操作类型
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]==YES) {
//        //相机可用
//        _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
//    }
//    else{
//        //媒体库
//        _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    }
//    
//    //设置代理
//    _imagePickerController.delegate = self;
//    
//    [self presentViewController:_imagePickerController animated:YES completion:nil];
    
    [self panduanCamerOrcamerBook];
}

#pragma mark  --确定是拍照还是从相册中选取、
- (void)panduanCamerOrcamerBook
{
     _imagePickerController = [[UIImagePickerController alloc] init];
    //设置代理
    _imagePickerController.delegate = self;
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * action = [UIAlertAction actionWithTitle:NSLocalizedString(@"拍照", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]==YES) {
            //相机可用
            _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        else{
            //媒体库
            _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        [self presentViewController:_imagePickerController animated:YES completion:nil];
    }];
    UIAlertAction * action2 = [UIAlertAction actionWithTitle:NSLocalizedString(@"相册", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:_imagePickerController animated:YES completion:nil];
    }];
    UIAlertAction * action3 = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", @"") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:action];
    [alertController addAction:action2];
    [alertController addAction:action3];
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
}
#pragma mark -UIImagePickerController的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    _imageView.image = info[UIImagePickerControllerOriginalImage];
    _image = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    _isSettingIcon = YES;
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    _isSettingIcon = NO;
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    NSString * str = [ud objectForKey:UserCategory];
    JQBaseRequest * jq = [[JQBaseRequest alloc]init];
    if ([str isEqualToString:@"消费者"]== YES) {
        [jq ConsumerSelectedBaseMessageWithConsumerID:[ud objectForKey:UserID] complete:^(NSDictionary *responseObject) {
            [responseObject writeToFile:UserMessageLocalAdress atomically:YES];
        } fail:^(NSError *error, NSString *errorString) {
            
        }];
    }else{
        [jq FarmerOwnerSelectedBaseMessageWithProducerID:[ud objectForKey:UserID] complete:^(NSDictionary *responseObject) {
            [responseObject writeToFile:UserMessageLocalAdress atomically:YES];
        } fail:^(NSError *error, NSString *errorString) {
            
        }];
    }
    
}

//点击屏幕触发的事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = CGRectMake(0, 64, Screen_Width, Screen_Height);
        self.view.frame = frame;
    }];
    [_cityPickerView removeFromSuperview];
    [_quPickerView removeFromSuperview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
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
