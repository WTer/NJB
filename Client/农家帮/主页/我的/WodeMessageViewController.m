//
//  WodeMessageViewController.m
//  农帮乐
//
//  Created by 王朝源 on 15/12/8.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "WodeMessageViewController.h"
#import "UIImageView+WebCache.h"
#import "AlertUserMessageViewController.h"
#import "ErWeiMaViewController.h"

@interface WodeMessageViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation WodeMessageViewController
{
    UITableView * _tableView;
    NSArray * _dataArray;
    JQBaseRequest *_jqRequest;
    NSString *_erweimaURL;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    NSString * str = [ud objectForKey:UserCategory];
    NSDictionary * dict = [NSDictionary dictionaryWithContentsOfFile:UserMessageLocalAdress];
    
    if (dict.count) {
        if ([str isEqualToString:@"消费者"] == YES) {
            
            _dataArray = @[dict[@"smallportraiturl"],dict[@"id"],dict[@"displayname"],@"消费者"];
            
            
        }else{
            _dataArray = @[dict[@"smallportraiturl"],dict[@"id"],dict[@"displayname"],[NSString stringWithFormat:@"%@%@%@", dict[@"province"], dict[@"city"], dict[@"address"]],dict[@"telephone"],dict[@"website"],@"农场主"];
        }
    }
    self.navigationItem.title = NSLocalizedString(@"我的信息", @"");
    [self createTableView];
    [self createBaocunButton];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    NSString * str = [ud objectForKey:UserCategory];
    NSDictionary * dict = [NSDictionary dictionaryWithContentsOfFile:UserMessageLocalAdress];
    _jqRequest = [[JQBaseRequest alloc] init];
    
    if (dict.count) {
        
        if ([str isEqualToString:@"消费者"] == YES) {
            
            NSLog(@"消费者");
            
            _dataArray = @[dict[@"smallportraiturl"],dict[@"id"],dict[@"displayname"],@"消费者"];
            
            //消费者查询二维码
            [_jqRequest chaXun2WeiMaWithConsumerId:[NSString stringWithFormat:@"%@",[ud objectForKey:@"ConsumerId"]] complete:^(NSDictionary *responseObject) {
                
                _erweimaURL = [NSString stringWithFormat:@"%@",responseObject[@"url"]];
                
                NSLog(@"查询消费者二维码成功%@",responseObject);
                
                [_tableView reloadData];
                
                
            } fail:^(NSError *error, NSString *errorString) {
                
                NSLog(@"查询消费者二维码失败%@",errorString);
                
                //消费者创建二维码
                [_jqRequest chuangJian2WeiMaWithConsumerId:[NSString stringWithFormat:@"%@",[ud objectForKey:@"ConsumerId"]] complete:^(NSDictionary *responseObject) {
                    
                    _erweimaURL = [NSString stringWithFormat:@"%@",responseObject[@"url"]];
                    
                    NSLog(@"创建消费者二维码成功%@",responseObject);
                    
                    [_tableView reloadData];
                    
                    
                    
                } fail:^(NSError *error, NSString *errorString) {
                    NSLog(@"创建消费者二维码失败%@",errorString);
                    
                    
                    //        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:errorString preferredStyle:UIAlertControllerStyleAlert];
                    //        UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                    //
                    //
                    //
                    //        }];
                    //        [alertController addAction:otherAction];
                    //        [self presentViewController:alertController animated:YES completion:nil];
                    
                }];
                
            }];

            
        }
        else{
            _dataArray = @[dict[@"smallportraiturl"],dict[@"id"],dict[@"displayname"],[NSString stringWithFormat:@"%@%@%@", dict[@"province"], dict[@"city"], dict[@"address"]],dict[@"telephone"],dict[@"website"],@"农场主"];
            //农场主查询二维码
            [_jqRequest chaXun2WeiMaWithProducerId:[NSString stringWithFormat:@"%@",[ud objectForKey:@"ProducerId"]] complete:^(NSDictionary *responseObject) {
                
                _erweimaURL = [NSString stringWithFormat:@"%@",responseObject[@"url"]];
                
                [_tableView reloadData];
                
                
            } fail:^(NSError *error, NSString *errorString) {
                
                //农场主创建二维码
                [_jqRequest chuangJian2WeiMaWithProducerId:[NSString stringWithFormat:@"%@",[ud objectForKey:@"ProducerId"]] complete:^(NSDictionary *responseObject) {
                    
                    _erweimaURL = [NSString stringWithFormat:@"%@",responseObject[@"url"]];
                    
                    [_tableView reloadData];
                    
                } fail:^(NSError *error, NSString *errorString) {
                    
                    //        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:errorString preferredStyle:UIAlertControllerStyleAlert];
                    //        UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                    //
                    //
                    //
                    //        }];
                    //        [alertController addAction:otherAction];
                    //        [self presentViewController:alertController animated:YES completion:nil];
                    
                }];
                
            }];

            
        }
    }
    
   
}

//我的信息从沙盒中取出不需要网络请求
#pragma mark 获取用户信息

//创建tableView
- (void)createTableView {
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 104 * _dataArray.count * scaleHeight) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableView.rowHeight = 104 * scaleHeight;
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    //   _tableView.bounces = NO;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * array = nil;
    if ([_dataArray count] == 4) {
        array = @[NSLocalizedString(@"头像", @""),
                  NSLocalizedString(@"用户ID", @""),
                  NSLocalizedString(@"用户昵称", @""),
                  NSLocalizedString(@"用户类型", @"")];
    }
    else{
        array = @[NSLocalizedString(@"头像", @""),
                  NSLocalizedString(@"用户ID", @""),
                  NSLocalizedString(@"用户昵称", @""),
                  NSLocalizedString(@"我的地址", @""),
                  NSLocalizedString(@"联系方式", @""),
                  NSLocalizedString(@"农场网站", @""),
                  NSLocalizedString(@"用户类型", @"")];
    }
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = array[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:21];
    cell.textLabel.textColor = BaseColor(105, 105, 105, 1);
    if ([_dataArray count] == 7) {
        
        if (indexPath.row != 1 && indexPath.row != 6) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else{
            UIView * view = [[UIView alloc]init];
            [cell addSubview:view];
            view.layer.contents = (id)[[UIImage imageNamed:@"grzx_wdxx_icon.png"]CGImage];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(cell.mas_right).offset(-40 * scaleWidth);
                make.width.mas_equalTo(21 * scaleWidth);
                make.height.mas_equalTo(27 * scaleHeight);
                make.centerY.mas_equalTo(cell.mas_centerY);
            }];
        }
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;//（一般最好设置一下）
        if (indexPath.row != 0) {
            CGSize size = [array[indexPath.row] sizeWithFont:[UIFont systemFontOfSize:21] maxSize:CGSizeMake(999, 21)];
            UILabel * lable = [[UILabel  alloc]init];
            lable.textColor = BaseColor(178, 178, 178, 1);
            lable.font = [UIFont systemFontOfSize:21];
            [cell addSubview:lable];
            [lable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(size.width + scaleHeight * 64);
                make.width.mas_equalTo(180);
                make.height.mas_equalTo(21);
                make.centerY.mas_equalTo(cell.mas_centerY);
            }];
            lable.text = _dataArray[indexPath.row];
        }
        else {
             CGSize size = [array[indexPath.row] sizeWithFont:[UIFont systemFontOfSize:21] maxSize:CGSizeMake(999, 21)];
            UIImageView * view = [[UIImageView alloc]init];
            [cell addSubview:view];
            [view sd_setImageWithURL:[NSURL URLWithString:_dataArray[0]] placeholderImage:[UIImage imageNamed:@"grzx_btn_touxiang.png"]];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(size.width + scaleHeight * 64);
                make.width.mas_equalTo(50 * scaleWidth);
                make.height.mas_equalTo(50 * scaleWidth);
                make.centerY.mas_equalTo(cell.mas_centerY);
            }];
            view.layer.cornerRadius = 25 * scaleWidth;
            view.layer.masksToBounds = YES;
            
            UIImageView * erweima = [[UIImageView alloc]init];
            [cell addSubview:erweima];
            [erweima sd_setImageWithURL:[NSURL URLWithString:_erweimaURL] placeholderImage:[UIImage imageNamed:@"grzx_btn_touxiang.png"]];
            [erweima mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(scaleHeight * -80);
                make.width.mas_equalTo(80 * scaleWidth);
                make.height.mas_equalTo(80 * scaleWidth);
                make.centerY.mas_equalTo(cell.mas_centerY);
            }];

        }
    }
    else{
        if (indexPath.row != 1 && indexPath.row != 3) {
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }
        else{
            UIView * view = [[UIView alloc]init];
            [cell addSubview:view];
            view.layer.contents = (id)[[UIImage imageNamed:@"grzx_wdxx_icon.png"]CGImage];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(cell.mas_right).offset(-40 * scaleWidth);
                make.width.mas_equalTo(21 * scaleWidth);
                make.height.mas_equalTo(27 * scaleHeight);
                make.centerY.mas_equalTo(cell.mas_centerY);
            }];
        }
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;//（一般最好设置一下）
        if (indexPath.row != 0) {
            CGSize size = [array[indexPath.row] sizeWithFont:[UIFont systemFontOfSize:21] maxSize:CGSizeMake(999, 21)];
            UILabel * lable = [[UILabel  alloc]init];
            lable.textColor = BaseColor(178, 178, 178, 1);
            lable.font = [UIFont systemFontOfSize:21];
            [cell addSubview:lable];
            [lable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(size.width + scaleHeight * 64);
                make.width.mas_equalTo(180);
                make.height.mas_equalTo(21);
                make.centerY.mas_equalTo(cell.mas_centerY);
            }];
            lable.text = _dataArray[indexPath.row];
        }else
        {
            CGSize size = [array[indexPath.row] sizeWithFont:[UIFont systemFontOfSize:21] maxSize:CGSizeMake(999, 21)];
            UIImageView * view = [[UIImageView alloc]init];
            [cell addSubview:view];
            [view sd_setImageWithURL:[NSURL URLWithString:_dataArray[0]] placeholderImage:[UIImage imageNamed:@"grzx_btn_touxiang.png"]];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(size.width + scaleHeight * 64);
                make.width.mas_equalTo(50 * scaleWidth);
                make.height.mas_equalTo(50 * scaleWidth);
                make.centerY.mas_equalTo(cell.mas_centerY);
            }];
            view.layer.cornerRadius = 25 * scaleWidth;
            view.layer.masksToBounds = YES;
            
            UIImageView * erweima = [[UIImageView alloc]init];
            [cell addSubview:erweima];
            [erweima sd_setImageWithURL:[NSURL URLWithString:_erweimaURL] placeholderImage:[UIImage imageNamed:@"grzx_btn_touxiang.png"]];
            [erweima mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(scaleHeight * -80);
                make.width.mas_equalTo(80 * scaleWidth);
                make.height.mas_equalTo(80 * scaleWidth);
                make.centerY.mas_equalTo(cell.mas_centerY);
            }];

        }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataArray.count == 4) {
        if (indexPath.row == 0) {
            
            ErWeiMaViewController *evc = [[ErWeiMaViewController alloc] init];
            NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
            NSString * str = [ud objectForKey:UserCategory];
            NSDictionary * dict = [NSDictionary dictionaryWithContentsOfFile:UserMessageLocalAdress];
            if (dict.count) {
                if ([str isEqualToString:@"消费者"] == YES) {
                    
                    _dataArray = @[dict[@"smallportraiturl"],dict[@"id"],dict[@"displayname"],@"消费者"];
                    
                    evc.yonghuming = dict[@"displayname"];
                    evc.touxiang = dict[@"smallportraiturl"];
                    evc.yonghudizhi = [NSString stringWithFormat:@"%@%@%@", dict[@"province"], dict[@"city"], dict[@"address"]];
                    
                }
                else{
                    _dataArray = @[dict[@"smallportraiturl"],dict[@"id"],dict[@"displayname"],[NSString stringWithFormat:@"%@%@%@", dict[@"province"], dict[@"city"], dict[@"address"]],dict[@"telephone"],dict[@"website"],@"农场主"];
                    evc.yonghuming = dict[@"displayname"];
                    evc.touxiang = dict[@"smallportraiturl"];
                    evc.yonghudizhi = [NSString stringWithFormat:@"%@%@%@", dict[@"province"], dict[@"city"], dict[@"address"]];
                }
            }
            [self.navigationController pushViewController:evc animated:YES];
            
        }
        else {
        
            if (!(indexPath.row == 1 || indexPath.row == 3)) {
                AlertUserMessageViewController * avc = [[AlertUserMessageViewController alloc]init];
                [self.navigationController pushViewController:avc animated:YES];
            }

        }
        
    }
    else{
        if (indexPath.row == 0) {
            
            ErWeiMaViewController *evc = [[ErWeiMaViewController alloc] init];
            NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
            NSString * str = [ud objectForKey:UserCategory];
            NSDictionary * dict = [NSDictionary dictionaryWithContentsOfFile:UserMessageLocalAdress];
            if (dict.count) {
                if ([str isEqualToString:@"消费者"] == YES) {
                    
                }else{
                    _dataArray = @[dict[@"smallportraiturl"],dict[@"id"],dict[@"displayname"],[NSString stringWithFormat:@"%@%@%@", dict[@"province"], dict[@"city"], dict[@"address"]],dict[@"telephone"],dict[@"website"],@"农场主"];
                    evc.yonghuming = dict[@"displayname"];
                    evc.touxiang = dict[@"smallportraiturl"];
                    evc.yonghudizhi = [NSString stringWithFormat:@"%@%@%@", dict[@"province"], dict[@"city"], dict[@"address"]];
                }
            }
            [self.navigationController pushViewController:evc animated:YES];
            
        }
        else {
            if (!(indexPath.row == 1 || indexPath.row == 6)) {
                AlertUserMessageViewController * avc = [[AlertUserMessageViewController alloc]init];
                [self.navigationController pushViewController:avc animated:YES];
            }            
        }
    }
}

//创建保存按钮
- (void)createBaocunButton
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"shouye_btn_denglu_n.png"] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(BaocunButton) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:NSLocalizedString(@"保存", @"") forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_tableView.mas_bottom).offset(100 * scaleHeight);
        make.left.mas_equalTo(scaleWidth * 24);
        make.height.mas_equalTo(scaleHeight * 80);
        make.right.mas_equalTo(-scaleWidth * 24);
    }];
}
- (void)BaocunButton
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
