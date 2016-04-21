//
//  GuanLiYouHuiQuanViewController.m
//  农家帮
//
//  Created by Mac on 16/3/14.
//  Copyright © 2016年 jingqi. All rights reserved.
//

#import "GuanLiYouHuiQuanViewController.h"
#import "WoDeYouHuiQuanTableViewCell.h"
#import "YouHuiQuanYouXiaoZhongTableViewCell.h"
#import "YouHuiQuanYiShiYongTableViewCell.h"
#import "YouHuiQuanYiGuoQiTableViewCell.h"
#import "ZengJiaYouHuiQuanViewController.h"

@interface GuanLiYouHuiQuanViewController ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>

@end

@implementation GuanLiYouHuiQuanViewController
{
    JQBaseRequest *_jqRequest;
    NSMutableArray *_dataArray;
    NSMutableArray *_youxiaozhongArray;
    NSMutableArray *_yishiyongArray;
    NSMutableArray *_yiguoqiArray;
    
    
    NSInteger _lastSelectTag;
    NSInteger _lastLineTag;
    
    UIButton *_tianjia;
    
    
    //上提刷新
    MJRefreshHeaderView *_headerView;
    //下拉刷新
    MJRefreshFooterView *_footerView;
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BaseColor(245, 245, 245, 1);
    
    self.title = NSLocalizedString(@"我的优惠券", @"");
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [button setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(leftBackButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    _jqRequest = [[JQBaseRequest alloc] init];
    _dataArray = [[NSMutableArray alloc] init];
    _youxiaozhongArray = [[NSMutableArray alloc] init];
    _yishiyongArray = [[NSMutableArray alloc] init];
    _yiguoqiArray = [[NSMutableArray alloc] init];
    
    
    [self createUI];
    
    [self requestDataWithOffSet:@"0" DataLimit:@"10"];
    
    [self RefreshUI];
    
    
}

- (void)dealloc {
    
    [_headerView free];
    [_footerView free];
}

//刷新
- (void)RefreshUI {
    
    _headerView = [MJRefreshHeaderView header];
    _headerView.delegate  = self;
    _headerView.scrollView = _tableView;
    
    
    _footerView = [MJRefreshFooterView footer];
    _footerView.delegate  = self;
    _footerView.scrollView = _tableView;
    
    
}
// 开始进入刷新状态就会调用
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView {
    
    if (refreshView == _headerView) {
        
        [_dataArray removeAllObjects];
        
        [self requestDataWithOffSet:@"0" DataLimit:@"10"];
        
        
    }
    
    if (refreshView == _footerView) {
        
        [self requestDataWithOffSet:[NSString stringWithFormat:@"%ld",(long)_dataArray.count] DataLimit:@"10"];
        
        
    }
}

- (void)requestDataWithOffSet:(NSString *)OffSet DataLimit:(NSString *)limit {
    
    //先判断网络状态,没网络时可以先从缓存的内容里面读取
    [[JudgeNetState shareInstance]monitorNetworkType:self.view complete:^(NSInteger state) {
        if (state == 1 || state == 2) {
            
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            //查询消费者的全部优惠券
            if ([ud boolForKey:@"IsConsumer"]) {
                
                [_jqRequest ChaXunProducerFaFangShangPinAllYouHuiQuanWithProducerId:[NSString stringWithFormat:@"%@",[ud objectForKey:@"ConsumerId"]] OffSet:OffSet limit:limit complete:^(NSDictionary *responseObject) {
                    
                    [_dataArray removeAllObjects];
                    
                    [_youxiaozhongArray removeAllObjects];
                    [_yishiyongArray removeAllObjects];
                    [_yiguoqiArray removeAllObjects];
                    
                    
                    [_dataArray addObjectsFromArray:responseObject[@"List"]];
                    
                    
                    
                    for (NSDictionary *dict in _dataArray) {
                        if ([dict[@"status"] intValue] == 0) {
                            [_youxiaozhongArray addObject:dict];
                        }
                        if ([dict[@"status"] intValue] == 1) {
                            [_yishiyongArray addObject:dict];
                        }
                        if ([dict[@"status"] intValue] == 2) {
                            [_yiguoqiArray addObject:dict];
                        }
                    }
                    
                    
                    
                    [_tableView reloadData];
                    
                    [_headerView endRefreshing];
                    [_footerView endRefreshing];
                    
                    
                } fail:^(NSError *error, NSString *errorString) {
                    
                    [_headerView endRefreshing];
                    [_footerView endRefreshing];
                    
                    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:errorString preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                        
                        
                        
                    }];
                    [alertController addAction:otherAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                    
                }];

                
            }
            else {
                
                [_jqRequest ChaXunProducerFaFangShangPinAllYouHuiQuanWithProducerId:[NSString stringWithFormat:@"%@",[ud objectForKey:@"ProducerId"]] OffSet:OffSet limit:limit complete:^(NSDictionary *responseObject) {
                    
                    [_dataArray removeAllObjects];
                    
                    [_youxiaozhongArray removeAllObjects];
                    [_yishiyongArray removeAllObjects];
                    [_yiguoqiArray removeAllObjects];
                    
                    
                    [_dataArray addObjectsFromArray:responseObject[@"List"]];
                    
                    
                    
                    for (NSDictionary *dict in _dataArray) {
                        if ([dict[@"status"] intValue] == 0) {
                            [_youxiaozhongArray addObject:dict];
                        }
                        if ([dict[@"status"] intValue] == 1) {
                            [_yishiyongArray addObject:dict];
                        }
                        if ([dict[@"status"] intValue] == 2) {
                            [_yiguoqiArray addObject:dict];
                        }
                    }
                    
                    
                    
                    [_tableView reloadData];
                    
                    [_headerView endRefreshing];
                    [_footerView endRefreshing];
                    
                    
                } fail:^(NSError *error, NSString *errorString) {
                    
                    [_headerView endRefreshing];
                    [_footerView endRefreshing];
                    
                    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:errorString preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                        
                        
                        
                    }];
                    [alertController addAction:otherAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                    
                }];

            }
            
        }
    }];


}
//添加优惠券
- (void)add {
    
    ZengJiaYouHuiQuanViewController *zengjiayouhuiquanVC = [[ZengJiaYouHuiQuanViewController alloc] init];
    [self.navigationController pushViewController:zengjiayouhuiquanVC animated:YES];

}

- (void)createUI {

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height - 64 - 100 * scaleHeight)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = BaseColor(233, 233, 233, 1);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];

    
    //添加优惠券
    _tianjia = [[UIButton alloc] initWithFrame:CGRectMake(0, Screen_Height - 64 - 100 * scaleHeight, Screen_Width, 100 * scaleHeight)];
    [_tianjia setBackgroundImage:[UIImage imageNamed:@"zjhh_btn_queding _down.png"] forState:UIControlStateNormal];
    [_tianjia setTitle:NSLocalizedString(@"Increase the coupon", @"") forState:UIControlStateNormal];
    [_tianjia addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 100 * scaleHeight)];
    bottomView.backgroundColor = BaseColor(233, 233, 233, 1);
    _tableView.tableHeaderView = bottomView;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 72 * scaleHeight)];
    view.backgroundColor = [UIColor whiteColor];
    [bottomView addSubview:view];
    
    
    NSArray *titleArray = @[NSLocalizedString(@"In the effective", @""),
                            NSLocalizedString(@"Has been used", @""),
                            NSLocalizedString(@"Expired", @"")];
    
    float width = 646 * scaleWidth / titleArray.count;
    float height = 72 * scaleHeight;
    for (int i = 0; i < titleArray.count ; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(45 * scaleWidth + width * i, 0, width - 60 * scaleWidth, height);
        
        
        
        UIButton *lineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        lineBtn.frame = CGRectMake(45 * scaleWidth + width * i, 72 * scaleHeight - 2, width - 60 * scaleWidth, 2);
        lineBtn.tag = 2000 + i;
        [view addSubview:lineBtn];
        
        
        
        // 给一个tag值，来区分点击的是哪个
        button.tag = 1000 + i;
        button.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:BaseColor(181, 181, 181, 1) forState:UIControlStateNormal];
        [button setTitleColor:BaseColor(13, 185, 58, 1) forState:UIControlStateSelected];
        // 添加事件
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        // 设置button的选中状态
        // 默认第0个是选中状态
        button.selected = i == 0;
        _lastSelectTag = 1000;
        if (button.selected) {
            [self.view addSubview:_tianjia];
            lineBtn.backgroundColor = BaseColor(13, 185, 58, 1);
        }
        [view addSubview:button];
    }
}

- (void)buttonAction:(UIButton *)button {
    
    // 1、判断是不是把这个按钮点了两次，如果是就return
    if (button.tag == _lastSelectTag) {
        return;
    }
    
    if (button.tag == 1000) {
        
        [self.view addSubview:_tianjia];
        
    }
    else {
    
        [_tianjia removeFromSuperview];
    }
    
    // 2、把当前选中的按钮点亮
    button.selected = YES;
    // 3、把上次选中的按钮还原
    UIButton *lastButton = (UIButton *)[self.view viewWithTag:_lastSelectTag];
    lastButton.selected = NO;
    
    UIButton *lastLineBtn = (UIButton *)[self.view viewWithTag:_lastSelectTag + 1000];
    lastLineBtn.backgroundColor = [UIColor whiteColor];

    
    // 记录当前选中按钮的tag值
    _lastSelectTag = button.tag;
    
    if (button.selected) {
        UIButton *lineBtn = (UIButton *)[self.view viewWithTag:_lastSelectTag + 1000];
        lineBtn.backgroundColor = BaseColor(13, 185, 58, 1);
    }

    [_tableView reloadData];
    
    
}

#pragma mark -UITableView的代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 300 * scaleHeight;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_lastSelectTag == 1000) {
       
        return _youxiaozhongArray.count;
    }
    else if (_lastSelectTag == 1001) {
        
        return _yishiyongArray.count;
    }
    else {
        
        return _yiguoqiArray.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    if (_lastSelectTag == 1000) {
        YouHuiQuanYouXiaoZhongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YouHuiQuanYouXiaoZhongTableViewCell"];
        if (!cell) {
            cell = [[YouHuiQuanYouXiaoZhongTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YouHuiQuanYouXiaoZhongTableViewCell"];
        }
        cell.viewController = self;
        if (_youxiaozhongArray.count) {
            
            NSDictionary *dict = _youxiaozhongArray[indexPath.row];
            [cell configWithDictionary:dict];
        }
        return cell;
    }
    else if (_lastSelectTag == 1001) {
    
        YouHuiQuanYiShiYongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YouHuiQuanYiShiYongTableViewCell"];
        if (!cell) {
            cell = [[YouHuiQuanYiShiYongTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YouHuiQuanYiShiYongTableViewCell"];
        }
        cell.viewController = self;
        if (_yishiyongArray.count) {
            
            NSDictionary *dict = _yishiyongArray[indexPath.row];
            [cell configWithDictionary:dict];
        }
        return cell;
    }
    else {
    
        YouHuiQuanYiGuoQiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YouHuiQuanYiGuoQiTableViewCell"];
        if (!cell) {
            cell = [[YouHuiQuanYiGuoQiTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YouHuiQuanYiGuoQiTableViewCell"];
        }
        cell.viewController = self;
        if (_yiguoqiArray.count) {
            
            NSDictionary *dict = _yiguoqiArray[indexPath.row];
            [cell configWithDictionary:dict];
        }
        return cell;
        
    }
}
    
//删除cell
//编辑按钮的点击事件
//- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
//    
//    // 重写编辑按钮的点击事件，因此先要调用父类方法
//    [super setEditing:editing animated:animated];
//    // 打开表格的编辑模式
//    [_tableView setEditing:editing animated:YES];
//}
//- (UITableViewCellEditingStyle )tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return UITableViewCellEditingStyleNone;
//    
//}
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    //从数据源中删除
//    [_dataArray removeObjectAtIndex:indexPath.row];
//   
//    //刷新UI
//    [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//    
//    
//}
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return @"已还款";
//    
//}

    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}


- (void)leftBackButtonClick {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
