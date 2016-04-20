

//
//  ZengjiaDizhiViewController.m
//  农帮乐
//
//  Created by hpz on 15/12/14.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "ZengjiaDizhiViewController.h"
#import "ShengShiQuView.h"
#import "SelectDiZhiTableViewCell.h"

@interface ZengjiaDizhiViewController ()<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate,UITextViewDelegate>

@end

@implementation ZengjiaDizhiViewController
{
    UITextField *_mingchengTF;
    UITextField *_shoujiTF;
    UITextView *_jiedaoDizhiTV;
    UILabel *_jiedao;
    ShengShiQuView *_selectWeizhi;
    UIButton *_setMoRenBtn;
    
    UIView *_mainView;
    UIButton *_viewBtn;
    UIView *_bouncedView;
    
    UITextField *_shengTF;
    UITextField *_shiTF;
    UITextField *_quTF;
    
    
    UITableView *_shengTableView;
    NSMutableArray *_dataArray;
    NSMutableArray *_shengDataArray;
    UITableView *_shiTableView;
    NSMutableArray *_shiDataArray;
    UITableView *_quTableView;
    NSMutableArray *_quDataArray;
    JQBaseRequest *_JQRequest;
    
    BOOL _isSelectWeiZhi;
    BOOL _isClickTap;
    
    UIActivityIndicatorView *_indication;
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    if (self.isXiuGai) {
        self.title = NSLocalizedString(@"Modify the address", @"");
    }
    else {
        self.title = NSLocalizedString(@"Add the address", @"");
    }
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    [self createUI];
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)createUI {
    
    _JQRequest = [[JQBaseRequest alloc] init];
    
    _dataArray = [[NSMutableArray alloc] init];
    _shengDataArray = [[NSMutableArray alloc] init];
    _shiDataArray = [[NSMutableArray alloc] init];
    _quDataArray = [[NSMutableArray alloc] init];
    
    _mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height - 64)];
    _mainView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_mainView];
    
    //收货人
    _mingchengTF = [[UITextField alloc] initWithFrame:CGRectMake(24 * scaleWidth, 40 * scaleHeight, 672 * scaleWidth, 80 * scaleHeight)];
    CGSize mingchengSize = [NSLocalizedString(@"The consignee", @"") sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(999, 100)];
    if (self.isXiuGai) {
         _mingchengTF.text = self.nameStr;
    }
    UILabel *mingcheng = [[UILabel alloc]initWithFrame:CGRectMake(30 * scaleWidth, 0, mingchengSize.width, mingchengSize.height)];
    mingcheng.text = NSLocalizedString(@"The consignee", @"");
    mingcheng.textColor = BaseColor(178, 178, 178, 1);
    _mingchengTF.leftView = mingcheng;
    _mingchengTF.leftViewMode = UITextFieldViewModeAlways;
    _mingchengTF.background = [UIImage imageNamed:@"shdz2_input.png"];
    _mingchengTF.delegate = self;
    [_mainView addSubview:_mingchengTF];
    
    //手机号
    _shoujiTF = [[UITextField alloc] initWithFrame:CGRectMake(24 * scaleWidth, 140 * scaleHeight, 672 * scaleWidth, 80 * scaleHeight)];
    CGSize shoujiSize = [NSLocalizedString(@"TELPHONE", @"") sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(999, 100)];
    UILabel *shouji = [[UILabel alloc]initWithFrame:CGRectMake(30 * scaleWidth, 0, shoujiSize.width, shoujiSize.height)];
    shouji.text = NSLocalizedString(@"TELPHONE", @"");
    shouji.textColor = BaseColor(178, 178, 178, 1);
    if (self.isXiuGai) {
        _shoujiTF.text = self.telphoneStr;
    }
    _shoujiTF.leftView = shouji;
    _shoujiTF.leftViewMode = UITextFieldViewModeAlways;
    _shoujiTF.background = [UIImage imageNamed:@"shdz2_input.png"];
    _shoujiTF.delegate = self;
    [_mainView addSubview:_shoujiTF];
    
    //省市区
    _selectWeizhi = [[ShengShiQuView alloc] initWithFrame:CGRectMake(24 * scaleWidth, 220 * scaleHeight, 672 * scaleWidth, 119 * scaleHeight)];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [_selectWeizhi addGestureRecognizer:tapGesture];
    if (self.isXiuGai) {
        CGSize weizhiSize = [[NSString stringWithFormat:@"%@%@%@",self.shengStr,self.shiStr,self.quStr] sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(999, 100)];
        CGSize size = [NSLocalizedString(@"Provinces", @"") sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(999, 100)];
        _selectWeizhi.weizhiLabel.frame = CGRectMake(106 * scaleWidth + size.width, 40 * scaleHeight, weizhiSize.width, weizhiSize.height);
        _selectWeizhi.weizhiLabel.text = [NSString stringWithFormat:@"%@%@%@",self.shengStr,self.shiStr,self.quStr];
        _isSelectWeiZhi = YES;
    }
    [_mainView addSubview:_selectWeizhi];
    
    //街道地址
    _jiedaoDizhiTV = [[UITextView alloc] initWithFrame:CGRectMake(24 * scaleWidth, 339 * scaleHeight, 672 * scaleWidth, 80 * scaleHeight)];
    _jiedaoDizhiTV.font = [UIFont systemFontOfSize:18.0];
    CGSize jiedaoSize = [NSLocalizedString(@"The street address", @"") sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(999, 100)];
    _jiedao = [[UILabel alloc]initWithFrame:CGRectMake(0, 20 * scaleHeight, jiedaoSize.width, jiedaoSize.height)];
    _jiedao.text = NSLocalizedString(@"The street address", @"");
    _jiedao.textColor = BaseColor(178, 178, 178, 1);
    [_jiedaoDizhiTV addSubview:_jiedao];
    _jiedaoDizhiTV.backgroundColor = BaseColor(242, 242, 242, 1);
    _jiedaoDizhiTV.delegate = self;
    if (self.isXiuGai) {
        [_jiedao removeFromSuperview];  
        _jiedaoDizhiTV.text = self.jiedaoStr;
    }
    [_mainView addSubview:_jiedaoDizhiTV];
    
    //设置默认按钮
    _setMoRenBtn = [[UIButton alloc] initWithFrame:CGRectMake(24 * scaleWidth, 459 * scaleHeight, 38 * scaleWidth, 38 * scaleHeight)];
    [_setMoRenBtn setImage:[UIImage imageNamed:@"shdz_radio_nor.png"] forState:UIControlStateNormal];
    [_setMoRenBtn setImage:[UIImage imageNamed:@"shdz_radio_sel.png"] forState:UIControlStateSelected];
    [_setMoRenBtn setTitleColor:BaseColor(52, 52, 52, 52) forState:UIControlStateNormal];
    [_setMoRenBtn addTarget:self action:@selector(setMoRen:) forControlEvents:UIControlEventTouchUpInside];
    if (self.isXiuGai) {
        _setMoRenBtn.selected = self.isMoRenDiZhi;
    }
    [_mainView addSubview:_setMoRenBtn];
    
    CGSize size = [NSLocalizedString(@"Set to the default address", @"") sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(999, 100)];
    UILabel *setMeRenLabel = [[UILabel alloc] initWithFrame:CGRectMake(82 * scaleWidth, 459 * scaleHeight, size.width, size.height)];
    setMeRenLabel.text = NSLocalizedString(@"Set to the default address", @"");
    setMeRenLabel.textColor = BaseColor(52, 52, 52, 52);
    setMeRenLabel.font = [UIFont systemFontOfSize:18.0];
    [_mainView addSubview:setMeRenLabel];
    
    //保存按钮
    UIButton *baocun = [[UIButton alloc] initWithFrame:CGRectMake(24 * scaleWidth, 636 * scaleHeight, 672 * scaleWidth, 80 * scaleHeight)];
    [baocun setBackgroundImage:[UIImage imageNamed:@"shdz2_btn_baocun_down.png"] forState:UIControlStateNormal];
    [baocun setTitle:NSLocalizedString(@"SAVE", @"") forState:UIControlStateNormal];
    [baocun addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [_mainView addSubview:baocun];
}
//UITextView的代理方法
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    [_jiedao removeFromSuperview];
    return YES;
    
}
//保存按钮
- (void)save {
    
    [[JudgeNetState shareInstance] monitorNetworkType:self.view complete:^(NSInteger state) {
        
        if (state == 1 || state == 2) {
            
            _mainView.alpha = 0.6;
            _mainView.userInteractionEnabled = NO;
            _indication = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            _indication.frame = CGRectMake(Screen_Width / 2 - 40, Screen_Height / 2 - 104, 80, 80);
            _indication.backgroundColor = [UIColor blackColor];
            _indication.hidesWhenStopped = NO;
            [_indication startAnimating];
            [self.view addSubview:_indication];
            
            if (_mingchengTF.text.length && _shoujiTF.text.length && _jiedaoDizhiTV.text.length && _shengTF.text.length && _shiTF.text.length && _quTF.text.length &&!self.isXiuGai) {
                
                
                //添加收货地址到服务器
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                [_JQRequest postShouHuoRenConsumerId:[NSString stringWithFormat:@"%@",[ud objectForKey:@"ConsumerId"]] name:_mingchengTF.text telephone:_shoujiTF.text province:_shengTF.text city:_shiTF.text district:_quTF.text address:_jiedaoDizhiTV.text isDefault:_setMoRenBtn.selected Complete:^(NSDictionary *responseObject) {
                    
                    NSLog(@"%@",responseObject);
                    [self.navigationController popViewControllerAnimated:YES];
                    
                } fail:^(NSError *error, NSString *errorString) {
                    NSLog(@"%@",errorString);
                }];
                
            }
            else if (_mingchengTF.text.length && _shoujiTF.text.length && _jiedaoDizhiTV.text.length && _selectWeizhi.weizhiLabel.text.length && self.isXiuGai) {
                //将修改后的收货地址添加到服务器
                //为甚么修改不了收货地址
                NSLog(@"%@",self.ConsigneeId);
                NSLog(@"%@%@%@%@   %ld%@%@",_mingchengTF.text, _shoujiTF.text, _jiedaoDizhiTV.text, _selectWeizhi.weizhiLabel.text, (long)_shengTF.text.length, _shiTF.text, _quTF.text);
                NSLog(@"省%@", self.shengStr);
                NSLog(@"市%@", self.shiStr);
                NSLog(@"区%@", self.quStr);
                
                if (!_shengTF.text.length || !_shiTF.text.length || !_quTF.text.length) {
                    
                    [_JQRequest putXiuGaiShouHuoRenConsigneeId:self.ConsigneeId name:_mingchengTF.text telephone:_shoujiTF.text province:self.shengStr city:self.shiStr district:self.quStr address:_jiedaoDizhiTV.text isDefault:_setMoRenBtn.selected Complete:^(NSDictionary *responseObject) {
                        
                        NSLog(@"%@",responseObject);
                        [self.navigationController popViewControllerAnimated:YES];
                        
                    } fail:^(NSError *error, NSString *errorString) {
                        NSLog(@"%@",errorString);
                    }];
                    
                }
                else {
                    
                    [_JQRequest putXiuGaiShouHuoRenConsigneeId:self.ConsigneeId name:_mingchengTF.text telephone:_shoujiTF.text province:_shengTF.text city:_shiTF.text district:_quTF.text address:_jiedaoDizhiTV.text isDefault:_setMoRenBtn.selected Complete:^(NSDictionary *responseObject) {
                        
                        NSLog(@"%@",responseObject);
                        [self.navigationController popViewControllerAnimated:YES];
                        
                    } fail:^(NSError *error, NSString *errorString) {
                        NSLog(@"%@",errorString);
                    }];
                }
            }
            else if (!_isSelectWeiZhi) {
                
                UIAlertController*alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"Please fill in the shipping address", @"") preferredStyle:UIAlertControllerStyleAlert];
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
- (void)setMoRen:(UIButton *)sender {
    sender.selected = !sender.selected;

    if (sender.selected == NO) {
        NSNotification *noti = [[NSNotification alloc] initWithName:@"qudiaomorendizhi" object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter]postNotification:noti];
    }
    
}
- (void)tap:(UITapGestureRecognizer *)tap {

    _isClickTap = YES;
    
    //创建弹框
    _mainView.alpha = 0.6;
    _mainView.userInteractionEnabled = NO;
    
    
    _viewBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    [_viewBtn addTarget:self action:@selector(viewBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_viewBtn];

    _bouncedView = [[UIView alloc] initWithFrame:CGRectMake(90 * scaleWidth, 140 * scaleHeight, 540 * scaleWidth, 680 * scaleHeight)];
    _bouncedView.backgroundColor = [UIColor whiteColor];
    [_viewBtn addSubview:_bouncedView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 540 * scaleWidth, 100 * scaleHeight - 1)];
    label.text = NSLocalizedString(@"Selected provinces", @"");
    label.textColor = BaseColor(52, 52, 52, 1);
    label.textAlignment = NSTextAlignmentCenter;
    [_bouncedView addSubview:label];
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 100 * scaleHeight - 1, 540 * scaleWidth, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [_bouncedView addSubview:line];
    
    //省份
    CGSize shengSize = [NSLocalizedString(@"Province", @"") sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(999, 100)];
    UILabel *sheng = [[UILabel alloc] initWithFrame:CGRectMake(24 * scaleWidth, 180 * scaleHeight, shengSize.width, shengSize.height)];
    sheng.text = NSLocalizedString(@"Province", @"");
    sheng.textColor = BaseColor(52, 52, 52, 1);
    [_bouncedView addSubview:sheng];
    
    _shengTF = [[UITextField alloc] initWithFrame:CGRectMake(44 *scaleWidth + shengSize.width, 160 * scaleHeight, 392 *scaleWidth - shengSize.width , 80 * scaleHeight)];
    if (self.isXiuGai) {
        _shengTF.text = self.shengStr;
    }
    else {
        _shengTF.placeholder = NSLocalizedString(@"Please Select", @"");
    }
    _shengTF.background = [UIImage imageNamed:@"shdz3_pop_input.png"];
    _shengTF.userInteractionEnabled = NO;
    [_bouncedView addSubview:_shengTF];
    UIButton *shengBtn = [[UIButton alloc] initWithFrame:CGRectMake(436 * scaleWidth, 160 * scaleHeight, 80 * scaleWidth, 80 * scaleHeight)];
    shengBtn.tag = 1000;
    [shengBtn setBackgroundImage:[UIImage imageNamed:@"shdz3_pop_input_btn.png"] forState:UIControlStateNormal];
    [shengBtn addTarget:self action:@selector(selectWeiZhi:) forControlEvents:UIControlEventTouchUpInside];
    [_bouncedView addSubview:shengBtn];
    
    
    UILabel *shi = [[UILabel alloc] initWithFrame:CGRectMake(24 * scaleWidth, 300 * scaleHeight, shengSize.width, shengSize.height)];
    shi.text = NSLocalizedString(@"City", @"");
    shi.textColor = BaseColor(52, 52, 52, 1);
    [_bouncedView addSubview:shi];
    
    _shiTF = [[UITextField alloc] initWithFrame:CGRectMake(44 *scaleWidth + shengSize.width, 280 * scaleHeight, 392 *scaleWidth -shengSize.width, 80 * scaleHeight)];
    _shiTF.placeholder = NSLocalizedString(@"Please Select", @"");
    _shiTF.background = [UIImage imageNamed:@"shdz3_pop_input.png"];
    _shiTF.userInteractionEnabled = NO;
    if (self.isXiuGai) {
        _shiTF.text = self.shiStr;
    }
    else {
        _shiTF.placeholder = NSLocalizedString(@"Please Select", @"");
    }
    [_bouncedView addSubview:_shiTF];
    UIButton *shiBtn = [[UIButton alloc] initWithFrame:CGRectMake(436 * scaleWidth, 280 * scaleHeight, 80 * scaleWidth, 80 * scaleHeight)];
    shiBtn.tag = 1001;
    [shiBtn setBackgroundImage:[UIImage imageNamed:@"shdz3_pop_input_btn.png"] forState:UIControlStateNormal];
    [shiBtn addTarget:self action:@selector(selectWeiZhi:) forControlEvents:UIControlEventTouchUpInside];
    [_bouncedView addSubview:shiBtn];
    
    UILabel *qu = [[UILabel alloc] initWithFrame:CGRectMake(24 * scaleWidth, 440 * scaleHeight, shengSize.width, shengSize.height)];
    qu.text = NSLocalizedString(@"Area", @"");
    qu.textColor = BaseColor(52, 52, 52, 1);
    [_bouncedView addSubview:qu];
    
    _quTF = [[UITextField alloc] initWithFrame:CGRectMake(44 *scaleWidth + shengSize.width, 420 * scaleHeight, 392 *scaleWidth -shengSize.width, 80 * scaleHeight)];
    _quTF.placeholder = NSLocalizedString(@"Please Select", @"");
    _quTF.background = [UIImage imageNamed:@"shdz3_pop_input.png"];
    _quTF.userInteractionEnabled = NO;
    if (self.isXiuGai) {
        _quTF.text = self.quStr;
    }
    else {
        _quTF.placeholder = NSLocalizedString(@"Please Select", @"");
    }

    [_bouncedView addSubview:_quTF];
    UIButton *quBtn = [[UIButton alloc] initWithFrame:CGRectMake(436 * scaleWidth, 420 * scaleHeight, 80 * scaleWidth, 80 * scaleHeight)];
    quBtn.tag = 1002;
    [quBtn setBackgroundImage:[UIImage imageNamed:@"shdz3_pop_input_btn.png"] forState:UIControlStateNormal];
    [quBtn addTarget:self action:@selector(selectWeiZhi:) forControlEvents:UIControlEventTouchUpInside];
    [_bouncedView addSubview:quBtn];
    
    UIButton *quedingBtn = [[UIButton alloc] initWithFrame:CGRectMake(24 * scaleWidth, 540 * scaleHeight, 492 * scaleWidth, 80 * scaleHeight)];
    [quedingBtn setBackgroundImage:[UIImage imageNamed:@"shdz3_pop_btn_baocun_down.png"] forState:UIControlStateNormal];
    [quedingBtn setTitle:NSLocalizedString(@"OK", @"") forState:UIControlStateNormal];
    [quedingBtn addTarget:self action:@selector(OK) forControlEvents:UIControlEventTouchUpInside];
    [_bouncedView addSubview:quedingBtn];
    
}
- (void)viewBtn {
    
    [_viewBtn removeFromSuperview];
    _mainView.alpha = 1;
    _mainView.userInteractionEnabled = YES;
}
- (void)selectWeiZhi:(UIButton *)sender {

    [[JudgeNetState shareInstance] monitorNetworkType:self.view complete:^(NSInteger state) {
        
        if (state == 1 || state == 2) {
            
            _bouncedView.alpha = 0;
            _bouncedView.userInteractionEnabled = NO;
            
            [_shengDataArray removeAllObjects];
            [_shiDataArray removeAllObjects];
            [_quDataArray removeAllObjects];
            
            
            if (sender.tag == 1000) {
                
                [_JQRequest getWeiZhiComplete:^(NSDictionary *responseObject) {
                    
                    NSArray *list = responseObject[@"List"];
                    _dataArray = responseObject[@"List"];
                    
                    //所有省份
                    for (NSInteger i = 0; i < list.count; i++) {
                        NSDictionary *dict = list[i];
                        [_shengDataArray addObject:dict[@"Province"]];
                    }
                    
                    _shengTableView = [[UITableView alloc] initWithFrame:CGRectMake(90 * scaleWidth, 140 * scaleHeight, 540 * scaleWidth, 102 * scaleHeight * _shengDataArray.count)];
                    _shengTableView.dataSource = self;
                    _shengTableView.delegate = self;
                    [_viewBtn addSubview:_shengTableView];
                    
                } fail:^(NSError *error, NSString *errorString) {
                    NSLog(@"%@",errorString);
                }];
                
            }
            if (sender.tag == 1001) {
                
                if (_shengTF.text.length) {
                    
                    [_JQRequest getWeiZhiComplete:^(NSDictionary *responseObject) {
                        
                        NSArray *list = responseObject[@"List"];
                        //所有省份
                        for (NSInteger i = 0; i < list.count; i++) {
                            NSDictionary *dict = list[i];
                            [_shengDataArray addObject:dict[@"Province"]];
                            //该省的所有城市
                            if ([dict[@"Province"] isEqualToString:_shengTF.text] == YES) {
                                
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
                        _shiTableView = [[UITableView alloc] initWithFrame:CGRectMake(90 * scaleWidth, 140 * scaleHeight, 540 * scaleWidth, 102 * scaleHeight * _shiDataArray.count)];
                        _shiTableView.dataSource = self;
                        _shiTableView.delegate = self;
                        [_viewBtn addSubview:_shiTableView];
                        
                        
                    } fail:^(NSError *error, NSString *errorString) {
                        NSLog(@"%@",errorString);
                    }];
                    
                    
                }
                else {
                    
                    UIAlertController*alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"Please select provinces", @"") preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                        
                        _bouncedView.alpha = 1;
                        _bouncedView.userInteractionEnabled = YES;
                        
                    }];
                    
                    [alertController addAction:otherAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                    
                }
            }
            if (sender.tag == 1002) {
                
                if (_shiTF.text.length) {
                    
                    [_JQRequest getWeiZhiComplete:^(NSDictionary *responseObject) {
                        
                        
                        NSArray *list = responseObject[@"List"];
                        NSArray *cityArray = [[NSArray alloc]init];
                        //所有省份
                        for (NSInteger i = 0; i < list.count; i++) {
                            
                            NSDictionary *dict = list[i];
                            
                            [_shengDataArray addObject:dict[@"Province"]];
                            
                            //该省的所有城市
                            if ([dict[@"Province"] isEqualToString:_shengTF.text] == YES) {
                                
                                cityArray = dict[@"City"];
                                
                                for (NSDictionary *cityDict in cityArray) {
                                    
                                    for (NSString *key in cityDict.allKeys) {
                                        
                                        if ([key isEqualToString:@"District"] == NO) {
                                            
                                            [_shiDataArray addObject:cityDict[key]];
                                            
                                        }
                                    }
                                }
                                
                                for (NSInteger i = 0; i < _shiDataArray.count; i++) {
                                    
                                    if ([_shiDataArray[i] isEqualToString:_shiTF.text] == YES) {
                                        
                                        NSDictionary *oneCityDict = cityArray[i];
                                        
                                        NSArray *DistrictArray = oneCityDict[@"District"];
                                        
                                        for (NSDictionary *DistrictDict in DistrictArray) {
                                            
                                            for (NSString *DistrictKey in DistrictDict.allKeys) {
                                                
                                                [_quDataArray addObject:DistrictDict[DistrictKey]];
                                            }
                                        }
                                    }
                                }
                                
                            }
                        }
                        
                        
                        _quTableView = [[UITableView alloc] initWithFrame:CGRectMake(90 * scaleWidth, 140 * scaleHeight, 540 * scaleWidth, 102 * scaleHeight * _quDataArray.count)];
                        _quTableView.dataSource = self;
                        _quTableView.delegate = self;
                        [_viewBtn addSubview:_quTableView];
                        
                        
                    } fail:^(NSError *error, NSString *errorString) {
                        NSLog(@"%@",errorString);
                    }];
                    
                }
                else {
                    
                    UIAlertController*alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"Please select city", @"") preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                        
                        _bouncedView.alpha = 1;
                        _bouncedView.userInteractionEnabled = YES;
                        
                    }];
                    
                    [alertController addAction:otherAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                }
            }
        }
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
    if (tableView == _quTableView) {
        return _quDataArray.count;
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
    if (tableView == _quTableView) {
        
        SelectDiZhiTableViewCell *selectCell = [tableView dequeueReusableCellWithIdentifier:@"quTableViewCell"];
        if (!selectCell) {
            selectCell = [[SelectDiZhiTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"quTableViewCell"];
        }
        selectCell.dizhiLabel.text = _quDataArray[indexPath.row];
        return selectCell;

    }
    return nil;
}
//tableView的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableView == _shengTableView) {
        
        [_shiDataArray removeAllObjects];
        [_quDataArray removeAllObjects];
        
        for (NSInteger i = 0; i < _dataArray.count; i++) {
            NSDictionary *dict = _dataArray[i];
            if ([dict[@"Province"] isEqualToString:_shengDataArray[indexPath.row]] == YES) {
                
                NSArray *cityArray = dict[@"City"];
                for (NSDictionary *cityDict in cityArray) {
                    for (NSString *key in cityDict.allKeys) {
                        if ([key isEqualToString:@"District"] == YES) {
                            
                            NSArray *DistrictArray = cityDict[@"District"];
                            
                            for (NSDictionary *DistrictDict in DistrictArray) {
                                
                                for (NSString *DistrictKey in DistrictDict.allKeys) {
                                    
                                    [_quDataArray addObject:DistrictDict[DistrictKey]];
                                }
                            }
                            
                        }
                        else {
                            [_shiDataArray addObject:cityDict[key]];
                        }
                    }
                }
            }
        }

        _shengTF.text = _shengDataArray[indexPath.row];
        _shiTF.text = _shiDataArray[0];
        _quTF.text = _quDataArray[0];
        [_shengTableView removeFromSuperview];
        _bouncedView.alpha = 1;
        _bouncedView.userInteractionEnabled = YES;
        
    }
    if (tableView == _shiTableView) {
        
        [_shiDataArray removeAllObjects];
        [_quDataArray removeAllObjects];
        
        
        NSArray *cityArray = [[NSArray alloc]init];
        for (NSInteger i = 0; i < _dataArray.count; i++) {
            NSDictionary *dict = _dataArray[i];
            
            if ([dict[@"Province"] isEqualToString:_shengTF.text] == YES) {
                
                cityArray = dict[@"City"];
            
                for (NSDictionary *cityDict in cityArray) {
                    
                    for (NSString *key in cityDict.allKeys) {
                        
                        if ([key isEqualToString:@"District"] == NO) {
                            
                            [_shiDataArray addObject:cityDict[key]];
                            
                        }
                    }
                }
                
                _shiTF.text = _shiDataArray[indexPath.row];
                
                for (NSInteger i = 0; i < _shiDataArray.count; i++) {
                    
                    if ([_shiDataArray[i] isEqualToString:_shiTF.text] == YES) {
                        
                        NSDictionary *oneCityDict = cityArray[i];
                        
                        NSArray *DistrictArray = oneCityDict[@"District"];
                        
                        for (NSDictionary *DistrictDict in DistrictArray) {
                            
                            for (NSString *DistrictKey in DistrictDict.allKeys) {
                                
                                [_quDataArray addObject:DistrictDict[DistrictKey]];
                            }
                        }
                    }
                }

            }
        }
        _quTF.text = _quDataArray[0];
        [_shiTableView removeFromSuperview];
        _bouncedView.alpha = 1;
        _bouncedView.userInteractionEnabled = YES;
        
    }
    if (tableView == _quTableView) {
        
        [_shiDataArray removeAllObjects];
        [_quDataArray removeAllObjects];
        
        for (NSInteger i = 0; i < _dataArray.count; i++) {
            
            NSDictionary *dict = _dataArray[i];
      
            if ([dict[@"Province"] isEqualToString:_shengTF.text] == YES) {
                
                NSArray *cityArray = dict[@"City"];
                
                for (NSDictionary *cityDict in cityArray) {
                    
                    for (NSString *key in cityDict.allKeys) {
                        
                        if ([key isEqualToString:@"District"] == NO) {
                            
                            [_shiDataArray addObject:cityDict[key]];
                            
                        for (NSInteger i = 0; i < _shiDataArray.count; i++) {
                                
                            if ([_shiDataArray[i] isEqualToString:_shiTF.text] == YES) {
                                
                                NSDictionary *oneCityDict = cityArray[i];
                                
                                NSArray *DistrictArray = oneCityDict[@"District"];
                                    
                                for (NSDictionary *DistrictDict in DistrictArray) {
                                        
                                    for (NSString *DistrictKey in DistrictDict.allKeys) {
                                            
                                        [_quDataArray addObject:DistrictDict[DistrictKey]];
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
        _quTF.text = _quDataArray[indexPath.row];
        [_quTableView removeFromSuperview];
        _bouncedView.alpha = 1;
        _bouncedView.userInteractionEnabled = YES;
    }

}
- (void)OK {
    
    if (_shengTF.text.length && _shiTF.text.length && _quTF.text.length) {
        _isSelectWeiZhi = YES;
        
        [_bouncedView removeFromSuperview];
        _mainView.alpha = 1;
        _mainView.userInteractionEnabled = YES;
        
        CGSize weizhiSize = [[NSString stringWithFormat:@"%@ %@ %@",_shengTF.text, _shiTF.text, _quTF.text] sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(999, 100)];
        CGSize size = [NSLocalizedString(@"Provinces", @"") sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(999, 100)];
        _selectWeizhi.weizhiLabel.frame = CGRectMake(106 * scaleWidth + size.width, 40 * scaleHeight, weizhiSize.width, weizhiSize.height);
        _selectWeizhi.weizhiLabel.textAlignment = NSTextAlignmentLeft;
        _selectWeizhi.weizhiLabel.textColor = BaseColor(52, 52, 52, 1);
        _selectWeizhi.weizhiLabel.text = [NSString stringWithFormat:@"%@ %@ %@",_shengTF.text, _shiTF.text, _quTF.text];

    }
    else {
    
        UIAlertController*alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"Input can't be empty", @"") preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
            
            
            
        }];
        
        [alertController addAction:otherAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }

}
//UITextField的代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.view endEditing:YES];
    return YES;
}
//屏幕的点击事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
