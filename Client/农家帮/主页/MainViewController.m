//
//  MainViewController.m
//  农帮乐
//
//  Created by hpz on 15/12/1.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "MainViewController.h"
#import "SousuoViewController.h"
#import "FabuViewController.h"
#import "WodeViewController.h"
#import "MyTabBarView.h"
#import "TabBarViewController.h"
#import "MainTableViewCell.h"
#import "AppDelegate.h"
#import "DetailViewController.h"

@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate, MJRefreshBaseViewDelegate>

@end

@implementation MainViewController
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
    
    self.navigationController.navigationBar.translucent = NO;
    self.title = NSLocalizedString(@"Farm help", @"");
    
   
    _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height - 113)];
    _mainTableView.backgroundColor = BaseColor(242, 242, 242, 1);
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    [self.view addSubview:_mainTableView];
    
    
    _dataArray = [[NSMutableArray alloc] init];
    _JQResquest = [[JQBaseRequest alloc] init];
    
    if (self.isRegister) {
        
        _mainTableView.alpha = 0.6;
        _mainTableView.userInteractionEnabled = NO;
        ((TabBarViewController *)self.parentViewController).myTabBarView.alpha = 0.6;
        ((TabBarViewController *)self.parentViewController).myTabBarView.userInteractionEnabled = NO;
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(90 * scaleWidth, 160 * scaleHeight + 20, 540 * scaleWidth, 850 *scaleHeight)];
        _imageView.image = [UIImage imageNamed:@"zccg_pop_btn_bg.png"];
        _imageView.userInteractionEnabled = YES;
        [self.view addSubview:_imageView];
        [self.view bringSubviewToFront:_imageView];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _imageView.frame.size.width, 620 * scaleHeight)];
        imageView.image = [UIImage imageNamed:@"zccg_pop_bg.png"];
        [_imageView addSubview:imageView];
        
        CGSize size = [NSLocalizedString(@"Open green trip", @"") sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(999, 100)];
        
        UIButton *start = [[UIButton alloc] initWithFrame:CGRectMake(_imageView.frame.size.width * 0.5 - size.width / 2, 690 * scaleHeight, size.width, size.height)];
        [start setBackgroundImage:[UIImage imageNamed:@"zccg_pop_btn.png"] forState:UIControlStateNormal];
        [start setTitle:NSLocalizedString(@"Open green trip", @"") forState:UIControlStateNormal];
        //36px是27的字体
        start.titleLabel.font = [UIFont systemFontOfSize:21];
        [start setTitleColor:BaseColor(14, 184, 58, 1) forState:UIControlStateNormal];
        [start addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
        [_imageView addSubview:start];

    }
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(fabu) name:@"fabu" object:nil];
    
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
    _headerView.scrollView = _mainTableView;
    
    
    _footerView = [MJRefreshFooterView footer];
    _footerView.delegate  = self;
    _footerView.scrollView = _mainTableView;
    
    
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



- (void)fabu {
    
    [self requestDataWithOffSet:@"0" DataLimit:@"10"];
}

- (void)start {
    
    _mainTableView.alpha = 1;
    _mainTableView.userInteractionEnabled = YES;
    [_imageView removeFromSuperview];
    ((TabBarViewController *)self.parentViewController).myTabBarView.alpha = 1;
    ((TabBarViewController *)self.parentViewController).myTabBarView.userInteractionEnabled = YES;
    
}
- (void)createUI {
    
    //_mainTableView的头视图
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 296 * scaleHeight)];
    _mainTableView.tableHeaderView = topView;
    //顶端图片 jpg要改成png
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 216 * scaleHeight)];
    topImageView.image = [UIImage imageWithData:UIImagePNGRepresentation([UIImage imageNamed:@"zy_banner.jpg"])];
    [topView addSubview:topImageView];
    //农场直讲图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 216 * scaleHeight, Screen_Width, 80 * scaleHeight)];
    imageView.image = [UIImage imageWithData:UIImagePNGRepresentation([UIImage imageNamed:@"zy_bg（农场直供-带线）.jpg"])];
    [topView addSubview:imageView];
    UIImageView *nongChangLive = [[UIImageView alloc] initWithFrame:CGRectMake(24 * scaleWidth, 216 * scaleHeight, 161 * scaleWidth, 80 * scaleHeight)];
    nongChangLive.image = [UIImage imageWithData:UIImagePNGRepresentation([UIImage imageNamed:@"zy_nczg.jpg"])];
    [topView addSubview:nongChangLive];
    
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
                NSLog(@"ConsumerId:%@",_userId);
               
            }
            else {
                _userId = [NSString stringWithFormat:@"%@",[ud objectForKey:@"ProducerId"]];
                NSLog(@"ProducerId:%@",_userId);
            }
            
            _mainTableView.alpha = 0.6;
            _mainTableView.userInteractionEnabled = NO;
            UIActivityIndicatorView *indication = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            indication.frame = CGRectMake(Screen_Width / 2 - 40, Screen_Height / 2 - 104, 80, 80);
            indication.backgroundColor = [UIColor blackColor];
            indication.hidesWhenStopped = NO;
            [indication startAnimating];
            [self.view addSubview:indication];
            
            
            
            
            [_JQResquest GoodsListSelectedBaseMessageWithUserID:_userId IsFarmer:[ud boolForKey:@"IsConsumer"] OffSet:OffSet limit:limit complete:^(NSDictionary *responseObject) {
                
                
                NSString *path = [NSString stringWithFormat:@"%@/Documents/cache.plist",NSHomeDirectory()];
                [responseObject writeToFile:path atomically:YES];
               
                NSLog(@"商品列表%@",responseObject);
               
                
                [_dataArray addObjectsFromArray:responseObject[@"List"]];
                [_mainTableView reloadData];
                
                [_headerView endRefreshing];
                [_footerView endRefreshing];
                
                _mainTableView.alpha = 1;
                _mainTableView.userInteractionEnabled = YES;
                [indication removeFromSuperview];
                
            } fail:^(NSError *error, NSString *errorString) {
                [_headerView endRefreshing];
                [_footerView endRefreshing];
                
                _mainTableView.alpha = 1;
                _mainTableView.userInteractionEnabled = YES;
                [indication removeFromSuperview];
                
        
                
            }];
        }
        if (state == 3) {
            
            NSString *path = [NSString stringWithFormat:@"%@/Documents/cache.plist",NSHomeDirectory()];
            NSDictionary *responseObject = [[NSDictionary alloc]initWithContentsOfFile:path];
            _dataArray = responseObject[@"List"];
            [_mainTableView reloadData];
            
            [_headerView endRefreshing];
            [_footerView endRefreshing];
        }
    }];
}
#pragma mark -UITableView的代理方法

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_dataArray.count) {
        
        NSDictionary *dict = _dataArray[indexPath.row];
        NSDictionary *ProductInfoDict = dict[@"ProductInfo"];
        NSString *description = [NSString stringWithFormat:@"%@",ProductInfoDict[@"description"]];
        NSString *price = [NSString stringWithFormat:@"%@",ProductInfoDict[@"price"]];
        NSString *name = [NSString stringWithFormat:@"%@",ProductInfoDict[@"name"]];
        
       
        CGSize sizePrice = [price sizeWithFont:[UIFont systemFontOfSize:27.0] maxSize:CGSizeMake(990, 100)];
        
        CGSize sizeName = [name sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(990, 100)];
        if (sizeName.width >= 990) {
            sizeName.height = sizeName.height * 0.5;
        }
        NSInteger count = 1;
        CGFloat width = sizeName.width;
        for (NSInteger i = 0; width >= 632 * scaleWidth; i++) {
            count++;
            width -= 632 * scaleWidth;
        }
        
        CGSize size = [description sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(990, 100)];
        NSInteger detailCount = 1;
        for (NSInteger i = 0; size.width >= 632 * scaleWidth; i++) {
            detailCount++;
            size.width -= 632 * scaleWidth;
        }
        
        return size.height * detailCount + sizePrice.height * 2 + sizeName.height * count + 470 * scaleHeight;
        
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MainTableViewCell *cell = [[MainTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mainTableViewCell"];
    if (_dataArray.count) {
        NSDictionary *dict = _dataArray[indexPath.row];
        cell.viewController = self;
        [cell configWithDictionary:dict];
    }
    return cell;

}
//tableView的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    DetailViewController *detailVC = [[DetailViewController alloc] init];
    NSDictionary *dict = _dataArray[indexPath.row];
    detailVC.ProductImages = dict[@"ProductImages"];
    detailVC.ProductInfo = dict[@"ProductInfo"];
    detailVC.ProducerInfo = dict[@"ProducerInfo"];
    [self.navigationController pushViewController:detailVC animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
