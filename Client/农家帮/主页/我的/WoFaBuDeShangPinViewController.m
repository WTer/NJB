//
//  WoFaBuDeShangPinViewController.m
//  农家帮
//
//  Created by Mac on 16/3/14.
//  Copyright © 2016年 jingqi. All rights reserved.
//

#import "WoFaBuDeShangPinViewController.h"
#import "YiXiaJiaTableViewCell.h"

@interface WoFaBuDeShangPinViewController ()<UITableViewDataSource, UITableViewDelegate, MJRefreshBaseViewDelegate>

@end

@implementation WoFaBuDeShangPinViewController
{
    UIImageView *_imageView;
    UITableView *_mainTableView;
    JQBaseRequest *_JQResquest;
    NSMutableArray *_dataArray;
    
    NSString *_userId;
    
    //上提刷新
    MJRefreshHeaderView *_headerView;
    //下拉刷新
    MJRefreshFooterView *_footerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BaseColor(245, 245, 245, 1);
    self.title = NSLocalizedString(@"我发布的商品", @"");
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [button setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(leftBackButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height - 64)];
    _mainTableView.backgroundColor = BaseColor(242, 242, 242, 1);
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    [self.view addSubview:_mainTableView];
    
    
    _dataArray = [[NSMutableArray alloc] init];
    _JQResquest = [[JQBaseRequest alloc] init];
    
    
    
    [self createUI];
    
    [self requestDataWithOffSet:@"0" DataLimit:@"10"];
    
    //[self RefreshUI];

    
}

- (void)leftBackButtonClick {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    
    [_headerView free];
    [_footerView free];
}

//刷新
- (void)RefreshUI {
    
    _headerView = [MJRefreshHeaderView header];
    _headerView.delegate  = self;
    _headerView.scrollView = _mainTableView;
    
    
    _footerView = [MJRefreshFooterView footer];
    _footerView.delegate  = self;
    _footerView.scrollView = _mainTableView;
    
    
}

// 开始进入刷新状态就会调用
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView {
    
    if (refreshView == _headerView) {
        
        [_dataArray removeAllObjects];
        
        //[self requestDataWithOffSet:@"0" DataLimit:@"10"];
        
        
    }
    
    if (refreshView == _footerView) {
        
        //[self requestDataWithOffSet:[NSString stringWithFormat:@"%ld",(long)_dataArray.count] DataLimit:@"10"];
        
        
    }
}

- (void)createUI {
    
    //返回顶部的按钮
    UIButton *zhidingBtn = [[UIButton alloc] initWithFrame:CGRectMake(626 * scaleWidth, 1029 * scaleHeight - 64, 70 * scaleWidth , 70 * scaleHeight)];
    [zhidingBtn setBackgroundImage:[UIImage imageNamed:@"zy_btn_huidaodingbu.png"] forState:UIControlStateNormal];
    [zhidingBtn addTarget:self action:@selector(huidaoDingBu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zhidingBtn];
    
}

- (void)huidaoDingBu {
    
    [_mainTableView setContentOffset:CGPointMake(0, 0) animated:YES];
    
}

- (void)requestDataWithOffSet:(NSString *)OffSet DataLimit:(NSString *)limit {
    
    //先判断网络状态,没网络时可以先从缓存的内容里面读取
    [[JudgeNetState shareInstance]monitorNetworkType:self.view complete:^(NSInteger state) {
        if (state == 1 || state == 2) {
            
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            if ([ud boolForKey:@"IsConsumer"]) {
                _userId = [NSString stringWithFormat:@"%@",[ud objectForKey:@"ConsumerId"]];
                
            }
            else {
                _userId = [NSString stringWithFormat:@"%@",[ud objectForKey:@"ProducerId"]];
                
            }
            
            
            [_JQResquest HuoQuProducerYiFaBuShangPinListWithProducerId:_userId complete:^(NSDictionary *responseObject) {
                
                NSLog(@"%@",responseObject);
                
                [_dataArray addObjectsFromArray:responseObject[@"List"]];
                [_mainTableView reloadData];
                
                
                
            } fail:^(NSError *error, NSString *errorString) {
                
                
                UIAlertController*alertController = [UIAlertController alertControllerWithTitle:@"提示" message:errorString preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                    
                }];
                
                [alertController addAction:otherAction];
                [self presentViewController:alertController animated:YES completion:nil];
                
            }];
        }
        if (state == 3) {
            
            
        }
    }];
}

#pragma mark -UITableView的代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_dataArray.count) {
        
        NSDictionary *dict = _dataArray[indexPath.row];
        NSString *description = [NSString stringWithFormat:@"%@",dict[@"description"]];
        NSString *price = [NSString stringWithFormat:@"%@",dict[@"price"]];
        NSString *name = [NSString stringWithFormat:@"%@",dict[@"name"]];
        
        
        CGSize sizePrice = [price sizeWithFont:[UIFont systemFontOfSize:27.0] maxSize:CGSizeMake(990, 100)];
        CGSize sizeName = [name sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(990, 100)];
        NSInteger count = 1;
        if (sizeName.width >= 990) {
            sizeName.height = sizeName.height * 0.5;
        }
        for (NSInteger i = 0; sizeName.width >= 632 * scaleWidth; i++) {
            count++;
            sizeName.width -= 632 * scaleWidth;
        }

        
        
        CGSize size = [description sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(990, 100)];
        NSInteger detailCount = 1;
        if (size.width >= 990) {
            size.height = size.height * 0.5;
        }
        for (NSInteger i = 0; size.width >= 632 * scaleWidth; i++) {
            detailCount++;
            size.width -= 632 * scaleWidth;
        }
        
        return size.height * detailCount + sizePrice.height + sizeName.height * count + 220 * scaleHeight;
        
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YiXiaJiaTableViewCell *cell = [[YiXiaJiaTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mainTableViewCell"];
    if (_dataArray.count) {
        NSDictionary *dict = _dataArray[indexPath.row];
        [cell configWithDictionary:dict withAll:YES];
    }
    return cell;
    
}
//tableView的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    DetailViewController *detailVC = [[DetailViewController alloc] init];
    //    NSDictionary *dict = _dataArray[indexPath.row];
    //    detailVC.ProductImages = dict[@"ProductImages"];
    //    detailVC.ProductInfo = dict[@"ProductInfo"];
    //    detailVC.ProducerInfo = dict[@"ProducerInfo"];
    //    [self.navigationController pushViewController:detailVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
