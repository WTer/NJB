//
//  AddHongBaoViewController.m
//  农家帮
//
//  Created by Mac on 16/4/6.
//  Copyright © 2016年 jingqi. All rights reserved.
//

#import "AddHongBaoViewController.h"
#import "XuanZeRiQiTableViewCell.h"

@interface AddHongBaoViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@end

@implementation AddHongBaoViewController
{
    UIScrollView *_mainScrollView;
    
    UIView *_tanchuView;
    
    UITextField *_youhuiquanTF;
    UITextField *_jiageTF;
    UITextField *_youxiaoqiTF;
    UITextField *_jiezhiriqiTF;
    UITextField *_tiaojianTF;
    
    
    UITableView *_nianTableView;
    UITableView *_yueTableView;
    UITableView *_riTableView;
    
    
    NSMutableArray *_nianArray;
    NSMutableArray *_yueArray;
    NSMutableArray *_ri1Array;
    NSMutableArray *_ri2Array;
    NSMutableArray *_ri3Array;
    NSMutableArray *_ri4Array;
    
    
    NSString *_nianString;
    NSString *_yueString;
    NSString *_riString;
    
    
    BOOL _isYouXiaoQi;
    BOOL _isJieZhiRiQi;
    
    JQBaseRequest *_jqRequest;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BaseColor(245, 245, 245, 1);
    self.title = @"添加红包";
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [button setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(leftBackButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    _jqRequest = [[JQBaseRequest alloc] init];
    
    _nianArray = [[NSMutableArray alloc] initWithObjects:@"2010",@"2011",@"2012",@"2013",@"2014",@"2015",@"2016",@"2017",@"2018",@"2019",
                  @"2020",@"2021",@"2022",@"2023",@"2024",@"2025",@"2026",@"2027",@"2028",@"2029",@"2030",
                  @"2031",@"2032",@"2033",@"2034",@"2035",@"2036",@"2037",@"2038",@"2039", @"2040",nil];
    
    _yueArray = [[NSMutableArray alloc] initWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",
                 @"11",@"12", nil];
    
    
    //31
    _ri1Array = [[NSMutableArray alloc] initWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",
                 @"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",
                 @"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30", @"31", nil];
    
    //30
    _ri2Array = [[NSMutableArray alloc] initWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",
                 @"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",
                 @"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",nil];
    
    //29
    _ri3Array = [[NSMutableArray alloc] initWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",
                 @"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",
                 @"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29", nil];
    
    //28
    _ri4Array = [[NSMutableArray alloc] initWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",
                 @"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",
                 @"22",@"23",@"24",@"25",@"26",@"27",@"28", nil];
    
    [self createUI];
    
}
- (void)createUI {
    
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height - 64)];
    _mainScrollView.backgroundColor = [UIColor whiteColor];
    _mainScrollView.delegate = self;
    [self.view addSubview:_mainScrollView];
    
    _youhuiquanTF = [[UITextField alloc] initWithFrame:CGRectMake(24 * scaleWidth, 25 * scaleHeight, 672 * scaleWidth, 75 * scaleHeight)];
    _youhuiquanTF.backgroundColor = BaseColor(249, 249, 249, 249);
    _youhuiquanTF.layer.cornerRadius = 10 * scaleHeight;
    _youhuiquanTF.placeholder = @"红包名称";
    _youhuiquanTF.delegate = self;
    _youhuiquanTF.font = [UIFont systemFontOfSize:14.0];
    [_mainScrollView addSubview:_youhuiquanTF];
    UILabel *youhuiquan = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 29 * scaleWidth, 75 * scaleHeight)];
    youhuiquan.textColor = BaseColor(249, 249, 249, 249);
    _youhuiquanTF.leftView = youhuiquan;
    _youhuiquanTF.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    _jiageTF = [[UITextField alloc] initWithFrame:CGRectMake(24 * scaleWidth, 121 * scaleHeight, 672 * scaleWidth, 75 * scaleHeight)];
    _jiageTF.backgroundColor = BaseColor(249, 249, 249, 249);
    _jiageTF.layer.cornerRadius = 10 * scaleHeight;
    _jiageTF.placeholder = @"请输入红包可用金额";
    _jiageTF.delegate = self;
    _jiageTF.font = [UIFont systemFontOfSize:14.0];
    [_mainScrollView addSubview:_jiageTF];
    UILabel *jiage = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120 * scaleWidth, 75 * scaleHeight)];
    jiage.font = [UIFont systemFontOfSize:16.0];
    jiage.text = @"价格";
    jiage.textAlignment = NSTextAlignmentCenter;
    jiage.textColor = BaseColor(105, 105, 105, 1);
    _jiageTF.leftView = jiage;
    _jiageTF.leftViewMode = UITextFieldViewModeAlways;
    UIButton *jiagexialaBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80 * scaleWidth, 75 * scaleHeight)];
    [jiagexialaBtn setBackgroundImage:[UIImage imageNamed:@"fbsp_btu_xiala.png"] forState:UIControlStateNormal];
    [jiagexialaBtn addTarget:self action:@selector(jiagexiala) forControlEvents:UIControlEventTouchUpInside];
    //    _jiageTF.rightView = jiagexialaBtn;
    //    _jiageTF.rightViewMode = UITextFieldViewModeAlways;
    
    
    
    _youxiaoqiTF = [[UITextField alloc] initWithFrame:CGRectMake(24 * scaleWidth, 217 * scaleHeight, 370 * scaleWidth, 75 * scaleHeight)];
    _youxiaoqiTF.backgroundColor = BaseColor(249, 249, 249, 249);
    _youxiaoqiTF.layer.cornerRadius = 10 * scaleHeight;
    _youxiaoqiTF.placeholder = @"00.00.00";
    _youxiaoqiTF.delegate = self;
    _youxiaoqiTF.font = [UIFont systemFontOfSize:12.0];
    [_mainScrollView addSubview:_youxiaoqiTF];
    UILabel *youxiaoqi = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120 * scaleWidth, 75 * scaleHeight)];
    youxiaoqi.font = [UIFont systemFontOfSize:14.0];
    youxiaoqi.text = @"有效期";
    youxiaoqi.textAlignment = NSTextAlignmentCenter;
    youxiaoqi.textColor = BaseColor(105, 105, 105, 1);
    _youxiaoqiTF.leftView = youxiaoqi;
    _youxiaoqiTF.leftViewMode = UITextFieldViewModeAlways;
    UIButton *youxiaoqixialaBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60 * scaleWidth, 75 * scaleHeight)];
    [youxiaoqixialaBtn setBackgroundImage:[UIImage imageNamed:@"fbsp_btu_xiala.png"] forState:UIControlStateNormal];
    [youxiaoqixialaBtn addTarget:self action:@selector(youxiaoqixiala) forControlEvents:UIControlEventTouchUpInside];
    _youxiaoqiTF.rightView = youxiaoqixialaBtn;
    _youxiaoqiTF.rightViewMode = UITextFieldViewModeAlways;
    
    
    
    UILabel *xian = [[UILabel alloc] initWithFrame:CGRectMake(394 * scaleWidth, 250 * scaleHeight, 20 * scaleWidth, 5 * scaleHeight)];
    xian.backgroundColor = BaseColor(105, 105, 105, 1);
    [_mainScrollView addSubview:xian];
    
    
    _jiezhiriqiTF = [[UITextField alloc] initWithFrame:CGRectMake(414 * scaleWidth, 217 * scaleHeight, 282 * scaleWidth, 75 * scaleHeight)];
    _jiezhiriqiTF.backgroundColor = BaseColor(249, 249, 249, 249);
    _jiezhiriqiTF.layer.cornerRadius = 10 * scaleHeight;
    _jiezhiriqiTF.placeholder = @"00.00.00";
    _jiezhiriqiTF.delegate = self;
    _jiezhiriqiTF.font = [UIFont systemFontOfSize:12.0];
    [_mainScrollView addSubview:_jiezhiriqiTF];
    UILabel *jiezhiriqi = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 47 * scaleWidth, 75 * scaleHeight)];
    jiezhiriqi.textColor = BaseColor(249, 249, 249, 249);
    _jiezhiriqiTF.leftView = jiezhiriqi;
    _jiezhiriqiTF.leftViewMode = UITextFieldViewModeAlways;
    
    UIButton *jiezhiriqixialaBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60 * scaleWidth, 75 * scaleHeight)];
    [jiezhiriqixialaBtn setBackgroundImage:[UIImage imageNamed:@"fbsp_btu_xiala.png"] forState:UIControlStateNormal];
    [jiezhiriqixialaBtn addTarget:self action:@selector(jiezhiriqixiala) forControlEvents:UIControlEventTouchUpInside];
    _jiezhiriqiTF.rightView = jiezhiriqixialaBtn;
    _jiezhiriqiTF.rightViewMode = UITextFieldViewModeAlways;
    
    UIButton *querenBtn = [[UIButton alloc] initWithFrame:CGRectMake(24 * scaleWidth, 437 * scaleHeight, 672 * scaleWidth, 80 * scaleHeight)];
    [querenBtn setBackgroundImage:[UIImage imageNamed:@"zjhh_btn_queding _down.png"] forState:UIControlStateNormal];
    [querenBtn setTitle:@"确认" forState:UIControlStateNormal];
    [querenBtn addTarget:self action:@selector(queren) forControlEvents:UIControlEventTouchUpInside];
    [_mainScrollView addSubview:querenBtn];
    
    _mainScrollView.contentSize = CGSizeMake(Screen_Width, Screen_Height + 216);
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.view endEditing:YES];
}
//确认按钮
- (void)queren {
    
    [self.view endEditing:YES];
    
    [[JudgeNetState shareInstance] monitorNetworkType:self.view complete:^(NSInteger state) {
        
        if (state == 1 || state == 2) {
            if (_youxiaoqiTF.text.length == 0 || _jiageTF.text.length == 0 || _youxiaoqiTF.text.length == 0 || _jiezhiriqiTF.text.length == 0) {
                
                UIAlertController*alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"Input can't be empty", @"") preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                    
                    
                    
                }];
                
                [alertController addAction:otherAction];
                [self presentViewController:alertController animated:YES completion:nil];
                
            }
            else {
                
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                
                
                [_jqRequest XinZengPuTongDanGeHongBaoPOSTWithProducerId:[NSString stringWithFormat:@"%@",[ud objectForKey:@"ProducerId"]] Count:@"1" Amount:_jiageTF.text Message:_youhuiquanTF.text complete:^(NSDictionary *responseObject) {
                    UIAlertController*alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:[NSString stringWithFormat:@"%@ 红包添加成功",_youhuiquanTF.text] preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                        
                        [self.navigationController popViewControllerAnimated:YES];
                        
                    }];
                    
                    [alertController addAction:otherAction];
                    [self presentViewController:alertController animated:YES completion:nil];

                    
                } fail:^(NSError *error, NSString *errorString) {
                    UIAlertController*alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:errorString preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                        
                        
                        
                    }];
                    
                    [alertController addAction:otherAction];
                    [self presentViewController:alertController animated:YES completion:nil];

                    
                }];
                
                }
            
        }
    }];
    
}
- (void)jiagexiala {
    
    
}
- (void)youxiaoqixiala {
    
    _isYouXiaoQi = YES;
    
    
    _mainScrollView.alpha = 0.1;
    _mainScrollView.userInteractionEnabled = NO;
    
    _tanchuView = [[UIView alloc] initWithFrame:CGRectMake(40 * scaleWidth, 200 * scaleHeight, 640 * scaleWidth, 560 * scaleHeight)];
    _tanchuView.layer.cornerRadius = 10 * scaleHeight;
    _tanchuView.layer.masksToBounds = YES;
    _tanchuView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tanchuView];
    
    UILabel *riqi = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 640 * scaleWidth, 91 * scaleHeight)];
    riqi.font = [UIFont systemFontOfSize:14.0];
    riqi.textAlignment = NSTextAlignmentCenter;
    riqi.text = @"选择日期";
    [_tanchuView addSubview:riqi];
    
    UILabel *topLine = [[UILabel alloc] initWithFrame:CGRectMake(40 * scaleWidth, 91 * scaleHeight - 1, 560 * scaleWidth, 1)];
    topLine.backgroundColor = BaseColor(227, 227, 227, 1);
    [_tanchuView addSubview:topLine];
    
    UILabel *bottomLine = [[UILabel alloc] initWithFrame:CGRectMake(40 * scaleWidth, 441 * scaleHeight, 560 * scaleWidth, 1)];
    bottomLine.backgroundColor = BaseColor(227, 227, 227, 1);
    [_tanchuView addSubview:bottomLine];
    
    //
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(40 * scaleWidth - 3, 91 * scaleHeight - 1, 3, 350 * scaleHeight + 2)];
    line.backgroundColor = BaseColor(227, 227, 227, 1);
    [_tanchuView addSubview:line];
    
    //年
    _nianTableView = [[UITableView alloc] initWithFrame:CGRectMake(40 * scaleWidth, 91 * scaleHeight, 240 * scaleWidth - 1, 350 * scaleHeight)];
    _nianTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _nianTableView.dataSource = self;
    _nianTableView.delegate = self;
    _nianTableView.pagingEnabled = YES;
    _nianTableView.showsVerticalScrollIndicator = NO;
    _nianTableView.backgroundColor = BaseColor(248, 248, 248, 1);
    [_tanchuView addSubview:_nianTableView];
    
    //
    UILabel *nianLine = [[UILabel alloc] initWithFrame:CGRectMake(280 * scaleWidth - 1, 91 * scaleHeight, 1, 350 * scaleHeight)];
    nianLine.backgroundColor = BaseColor(227, 227, 227, 1);
    [_tanchuView addSubview:nianLine];
    
    //月
    _yueTableView = [[UITableView alloc] initWithFrame:CGRectMake(280 * scaleWidth, 91 * scaleHeight, 160 * scaleWidth - 1, 350 * scaleHeight)];
    _yueTableView.dataSource = self;
    _yueTableView.delegate = self;
    _yueTableView.pagingEnabled = YES;
    _yueTableView.showsVerticalScrollIndicator = NO;
    _yueTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _yueTableView.backgroundColor = BaseColor(248, 248, 248, 1);
    [_tanchuView addSubview:_yueTableView];
    
    UILabel *yueLine = [[UILabel alloc] initWithFrame:CGRectMake(440 * scaleWidth - 1, 91 * scaleHeight, 1, 350 * scaleHeight)];
    yueLine.backgroundColor = BaseColor(227, 227, 227, 1);
    [_tanchuView addSubview:yueLine];
    
    //日
    _riTableView = [[UITableView alloc] initWithFrame:CGRectMake(440 * scaleWidth, 91 * scaleHeight, 160 * scaleWidth, 350 * scaleHeight)];
    _riTableView.dataSource = self;
    _riTableView.delegate = self;
    _riTableView.pagingEnabled = YES;
    _riTableView.showsVerticalScrollIndicator = NO;
    _riTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _riTableView.backgroundColor = BaseColor(248, 248, 248, 1);
    [_tanchuView addSubview:_riTableView];
    
    UILabel *riLine = [[UILabel alloc] initWithFrame:CGRectMake(600 * scaleWidth, 91 * scaleHeight, 1, 350 * scaleHeight)];
    riLine.backgroundColor = BaseColor(227, 227, 227, 1);
    [_tanchuView addSubview:riLine];
    
    
    
    UIButton *quedingBtn = [[UIButton alloc] initWithFrame:CGRectMake(100 * scaleWidth, 461 * scaleHeight, 200 * scaleWidth, 80 * scaleHeight)];
    quedingBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    quedingBtn.layer.cornerRadius = 10 * scaleHeight;
    quedingBtn.layer.masksToBounds = YES;
    [quedingBtn setBackgroundImage:[UIImage imageNamed:@"chxq_btn_queding_down.png"] forState:UIControlStateNormal];
    [quedingBtn setTitle:NSLocalizedString(@"OK", @"") forState:UIControlStateNormal];
    [quedingBtn addTarget:self action:@selector(queding) forControlEvents:UIControlEventTouchUpInside];
    [_tanchuView addSubview:quedingBtn];
    
    UIButton *quxiaoBtn = [[UIButton alloc] initWithFrame:CGRectMake(330 * scaleWidth, 461 * scaleHeight, 200 * scaleWidth, 80 * scaleHeight)];
    quxiaoBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    quxiaoBtn.layer.cornerRadius = 10 * scaleHeight;
    quxiaoBtn.layer.masksToBounds = YES;
    [quxiaoBtn setBackgroundImage:[UIImage imageNamed:@"chxq_btn_quxiao_up.png"] forState:UIControlStateNormal];
    [quxiaoBtn setTitle:NSLocalizedString(@"CANCLE", @"") forState:UIControlStateNormal];
    [quxiaoBtn setTitleColor:BaseColor(13, 185, 58, 1) forState:UIControlStateNormal];
    [quxiaoBtn addTarget:self action:@selector(quxiao) forControlEvents:UIControlEventTouchUpInside];
    [_tanchuView addSubview:quxiaoBtn];
    
}

#pragma mark -UITableView的代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70 * scaleHeight;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == _nianTableView) {
        
        return _nianArray.count;
    }
    else if (tableView == _yueTableView) {
        
        return _yueArray.count;
        
    }
    else {
        
        
        //闰年
        if ([_nianString intValue] % 400 == 0) {
            
            if ([_yueString isEqualToString:@"01"] == YES || [_yueString isEqualToString:@"03"] == YES || [_yueString isEqualToString:@"05"] == YES || [_yueString isEqualToString:@"07"] == YES || [_yueString isEqualToString:@"08"] == YES || [_yueString isEqualToString:@"10"] == YES ||
                [_yueString isEqualToString:@"12"] == YES) {
                
                return _ri1Array.count;
                
            }
            else if ([_yueString isEqualToString:@"02"] == YES) {
                
                return _ri3Array.count;
            }
            else {
                
                return _ri2Array.count;
            }
            
        }
        //
        else {
            
            if ([_yueString isEqualToString:@"01"] == YES || [_yueString isEqualToString:@"03"] == YES || [_yueString isEqualToString:@"05"] == YES || [_yueString isEqualToString:@"07"] == YES || [_yueString isEqualToString:@"08"] == YES || [_yueString isEqualToString:@"10"] == YES ||
                [_yueString isEqualToString:@"12"] == YES) {
                
                return _ri1Array.count;
                
            }
            else if ([_yueString isEqualToString:@"02"] == YES) {
                
                return _ri4Array.count;
            }
            else {
                
                return _ri2Array.count;
            }
            
            
        }
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _nianTableView) {
        XuanZeRiQiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NianTableViewCell"];
        if (!cell) {
            cell = [[XuanZeRiQiTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NianTableViewCell"];
        }
        if (_nianArray.count == 31) {
            
            [cell configWithDictionary:@[_nianArray[indexPath.row],@"年"]];
            
        }
        
        return cell;
    }
    else if (tableView == _yueTableView) {
        
        XuanZeRiQiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YueTableViewCell"];
        if (!cell) {
            cell = [[XuanZeRiQiTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YueTableViewCell"];
        }
        if (_yueArray.count == 12) {
            
            [cell configWithDictionary:@[_yueArray[indexPath.row],@"月"]];
        }
        
        return cell;
    }
    else {
        
        XuanZeRiQiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RiTableViewCell"];
        if (!cell) {
            cell = [[XuanZeRiQiTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RiTableViewCell"];
        }
        if ([_nianString intValue] % 400 == 0) {
            
            if ([_yueString isEqualToString:@"01"] == YES || [_yueString isEqualToString:@"03"] == YES || [_yueString isEqualToString:@"05"] == YES || [_yueString isEqualToString:@"07"] == YES || [_yueString isEqualToString:@"08"] == YES || [_yueString isEqualToString:@"10"] == YES ||
                [_yueString isEqualToString:@"12"] == YES) {
                
                if (_ri1Array.count == 31) {
                    
                    [cell configWithDictionary:@[_ri1Array[indexPath.row],@"日"]];
                }
                
                return cell;
                
            }
            else if ([_yueString isEqualToString:@"02"] == YES) {
                
                if (_ri3Array.count == 29) {
                    
                    [cell configWithDictionary:@[_ri3Array[indexPath.row],@"日"]];
                }
                return cell;
            }
            else {
                
                if (_ri2Array.count == 30) {
                    
                    [cell configWithDictionary:@[_ri2Array[indexPath.row],@"日"]];
                }
                return cell;
            }
            
        }
        else {
            
            if ([_yueString isEqualToString:@"01"] == YES || [_yueString isEqualToString:@"03"] == YES || [_yueString isEqualToString:@"05"] == YES || [_yueString isEqualToString:@"07"] == YES || [_yueString isEqualToString:@"08"] == YES || [_yueString isEqualToString:@"10"] == YES ||
                [_yueString isEqualToString:@"12"] == YES) {
                
                if (_ri1Array.count == 31) {
                    
                    [cell configWithDictionary:@[_ri1Array[indexPath.row],@"日"]];
                }
                
                return cell;
                
            }
            else if ([_yueString isEqualToString:@"02"] == YES) {
                
                if (_ri3Array.count == 29) {
                    
                    [cell configWithDictionary:@[_ri3Array[indexPath.row],@"日"]];
                }
                return cell;
            }
            else {
                
                if (_ri2Array.count == 30) {
                    
                    [cell configWithDictionary:@[_ri2Array[indexPath.row],@"日"]];
                }
                return cell;
            }
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _nianTableView) {
        
        _nianString = [NSString stringWithFormat:@"%@",_nianArray[indexPath.row]];
        
        //[_nianTableView reloadData];
        //[_yueTableView reloadData];
        [_riTableView reloadData];
        
    }
    else if (tableView == _yueTableView) {
        
        _yueString = [NSString stringWithFormat:@"%@",_yueArray[indexPath.row]];
        
        // [_nianTableView reloadData];
        // [_yueTableView reloadData];
        [_riTableView reloadData];
        
    }
    else {
        
        
        
        if ([_yueString isEqualToString:@"01"] == YES || [_yueString isEqualToString:@"03"] == YES || [_yueString isEqualToString:@"05"] == YES || [_yueString isEqualToString:@"07"] == YES || [_yueString isEqualToString:@"08"] == YES || [_yueString isEqualToString:@"10"] == YES ||
            [_yueString isEqualToString:@"12"] == YES) {
            
            if (_ri1Array.count == 31) {
                
                _riString = [NSString stringWithFormat:@"%@",_ri1Array[indexPath.row]];
                
            }
        }
        else if ([_yueString isEqualToString:@"02"] == YES) {
            
            if (_ri3Array.count == 29) {
                
                _riString = [NSString stringWithFormat:@"%@",_ri3Array[indexPath.row]];
                
            }
        }
        else {
            
            if (_ri2Array.count == 30) {
                
                _riString = [NSString stringWithFormat:@"%@",_ri2Array[indexPath.row]];
                
            }
        }
        
    }
}

- (void)quxiao {
    
    _mainScrollView.alpha = 1;
    _mainScrollView.userInteractionEnabled = YES;
    [_tanchuView removeFromSuperview];
    
    _isYouXiaoQi = NO;
    _isJieZhiRiQi = NO;
    
}
- (void)queding {
    
    _mainScrollView.alpha = 1;
    _mainScrollView.userInteractionEnabled = YES;
    [_tanchuView removeFromSuperview];
    
    if (_isYouXiaoQi) {
        
        _youxiaoqiTF.text = [NSString stringWithFormat:@"%@.%@.%@",_nianString, _yueString, _riString];
        
    }
    if (_isJieZhiRiQi) {
        
        _jiezhiriqiTF.text = [NSString stringWithFormat:@"%@.%@.%@",_nianString, _yueString, _riString];
        
    }
    _isYouXiaoQi = NO;
    _isJieZhiRiQi = NO;
    
}
- (void)jiezhiriqixiala {
    
    _isJieZhiRiQi = YES;
    
    _mainScrollView.alpha = 0.1;
    _mainScrollView.userInteractionEnabled = NO;
    
    _tanchuView = [[UIView alloc] initWithFrame:CGRectMake(40 * scaleWidth, 200 * scaleHeight, 640 * scaleWidth, 560 * scaleHeight)];
    _tanchuView.layer.cornerRadius = 10 * scaleHeight;
    _tanchuView.layer.masksToBounds = YES;
    _tanchuView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tanchuView];
    
    UILabel *riqi = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 640 * scaleWidth, 91 * scaleHeight)];
    riqi.font = [UIFont systemFontOfSize:14.0];
    riqi.textAlignment = NSTextAlignmentCenter;
    riqi.text = @"选择日期";
    [_tanchuView addSubview:riqi];
    
    UILabel *topLine = [[UILabel alloc] initWithFrame:CGRectMake(40 * scaleWidth, 91 * scaleHeight - 1, 560 * scaleWidth, 1)];
    topLine.backgroundColor = BaseColor(227, 227, 227, 1);
    [_tanchuView addSubview:topLine];
    
    UILabel *bottomLine = [[UILabel alloc] initWithFrame:CGRectMake(40 * scaleWidth, 441 * scaleHeight, 560 * scaleWidth, 1)];
    bottomLine.backgroundColor = BaseColor(227, 227, 227, 1);
    [_tanchuView addSubview:bottomLine];
    
    //
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(40 * scaleWidth - 3, 91 * scaleHeight - 1, 3, 350 * scaleHeight + 2)];
    line.backgroundColor = BaseColor(227, 227, 227, 1);
    [_tanchuView addSubview:line];
    
    //年
    _nianTableView = [[UITableView alloc] initWithFrame:CGRectMake(40 * scaleWidth, 91 * scaleHeight, 240 * scaleWidth - 1, 350 * scaleHeight)];
    _nianTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _nianTableView.dataSource = self;
    _nianTableView.delegate = self;
    _nianTableView.pagingEnabled = YES;
    _nianTableView.showsVerticalScrollIndicator = NO;
    _nianTableView.backgroundColor = BaseColor(248, 248, 248, 1);
    [_tanchuView addSubview:_nianTableView];
    
    //
    UILabel *nianLine = [[UILabel alloc] initWithFrame:CGRectMake(280 * scaleWidth - 1, 91 * scaleHeight, 1, 350 * scaleHeight)];
    nianLine.backgroundColor = BaseColor(227, 227, 227, 1);
    [_tanchuView addSubview:nianLine];
    
    //月
    _yueTableView = [[UITableView alloc] initWithFrame:CGRectMake(280 * scaleWidth, 91 * scaleHeight, 160 * scaleWidth - 1, 350 * scaleHeight)];
    _yueTableView.dataSource = self;
    _yueTableView.delegate = self;
    _yueTableView.pagingEnabled = YES;
    _yueTableView.showsVerticalScrollIndicator = NO;
    _yueTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _yueTableView.backgroundColor = BaseColor(248, 248, 248, 1);
    [_tanchuView addSubview:_yueTableView];
    
    UILabel *yueLine = [[UILabel alloc] initWithFrame:CGRectMake(440 * scaleWidth - 1, 91 * scaleHeight, 1, 350 * scaleHeight)];
    yueLine.backgroundColor = BaseColor(227, 227, 227, 1);
    [_tanchuView addSubview:yueLine];
    
    //日
    _riTableView = [[UITableView alloc] initWithFrame:CGRectMake(440 * scaleWidth, 91 * scaleHeight, 160 * scaleWidth, 350 * scaleHeight)];
    _riTableView.dataSource = self;
    _riTableView.delegate = self;
    _riTableView.pagingEnabled = YES;
    _riTableView.showsVerticalScrollIndicator = NO;
    _riTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _riTableView.backgroundColor = BaseColor(248, 248, 248, 1);
    [_tanchuView addSubview:_riTableView];
    
    UILabel *riLine = [[UILabel alloc] initWithFrame:CGRectMake(600 * scaleWidth, 91 * scaleHeight, 1, 350 * scaleHeight)];
    riLine.backgroundColor = BaseColor(227, 227, 227, 1);
    [_tanchuView addSubview:riLine];
    
    
    
    UIButton *quedingBtn = [[UIButton alloc] initWithFrame:CGRectMake(100 * scaleWidth, 461 * scaleHeight, 200 * scaleWidth, 80 * scaleHeight)];
    quedingBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    quedingBtn.layer.cornerRadius = 10 * scaleHeight;
    quedingBtn.layer.masksToBounds = YES;
    [quedingBtn setBackgroundImage:[UIImage imageNamed:@"chxq_btn_queding_down.png"] forState:UIControlStateNormal];
    [quedingBtn setTitle:NSLocalizedString(@"OK", @"") forState:UIControlStateNormal];
    [quedingBtn addTarget:self action:@selector(queding) forControlEvents:UIControlEventTouchUpInside];
    [_tanchuView addSubview:quedingBtn];
    
    UIButton *quxiaoBtn = [[UIButton alloc] initWithFrame:CGRectMake(330 * scaleWidth, 461 * scaleHeight, 200 * scaleWidth, 80 * scaleHeight)];
    quxiaoBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    quxiaoBtn.layer.cornerRadius = 10 * scaleHeight;
    quxiaoBtn.layer.masksToBounds = YES;
    [quxiaoBtn setBackgroundImage:[UIImage imageNamed:@"chxq_btn_quxiao_up.png"] forState:UIControlStateNormal];
    [quxiaoBtn setTitle:NSLocalizedString(@"CANCLE", @"") forState:UIControlStateNormal];
    [quxiaoBtn setTitleColor:BaseColor(13, 185, 58, 1) forState:UIControlStateNormal];
    [quxiaoBtn addTarget:self action:@selector(quxiao) forControlEvents:UIControlEventTouchUpInside];
    [_tanchuView addSubview:quxiaoBtn];
    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.view endEditing:YES];
    return YES;
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}
- (void)leftBackButtonClick {
    
    [self.navigationController popViewControllerAnimated:YES];
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
