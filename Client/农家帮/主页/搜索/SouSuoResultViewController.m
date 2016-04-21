//
//  SouSuoResultViewController.m
//  农帮乐
//
//  Created by hpz on 15/12/17.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "SouSuoResultViewController.h"
#import "SouSuoTableViewCell.h"
#import "DetailViewController.h"

@interface SouSuoResultViewController ()<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, MJRefreshBaseViewDelegate>

@end

@implementation SouSuoResultViewController
{
    UISearchBar *_searchBar;
    UITableView *_tableView;
    JQBaseRequest *_JQRequest;
    NSString *_userId;
    NSMutableArray *_dataArray;
    
    //上提刷新
    MJRefreshHeaderView *_headerView;
    //下拉刷新
    MJRefreshFooterView *_footerView;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 12 * scaleHeight, 520 * scaleWidth, 72 * scaleHeight)];
    _searchBar.placeholder = NSLocalizedString(@"Search for goods", @"");
    _searchBar.delegate = self;
    self.navigationItem.titleView = _searchBar;
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"SEARCH", @"") style:UIBarButtonItemStylePlain target:self action:@selector(search)];
    
    _dataArray = [[NSMutableArray alloc] init];
    _JQRequest = [[JQBaseRequest alloc] init];
    [self createUI];
    [self requestDataWithOffSet:@"0" Limit:@"15"];
    [self RefreshUI];
    

}

//刷新
- (void)RefreshUI {
    
    _headerView = [MJRefreshHeaderView header];
    _headerView.scrollView = _tableView;
    _headerView.delegate  = self;
    
    _footerView = [MJRefreshFooterView footer];
    _footerView.scrollView = _tableView;
    _footerView.delegate  = self;
    
}
// 开始进入刷新状态就会调用
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView {
    
    if (refreshView == _headerView) {
        //回到最初的状态
        [self requestDataWithOffSet:@"0" Limit:@"15"];
    }
    if (refreshView == _footerView) {
        
        [self requestDataWithOffSet:[NSString stringWithFormat:@"%ld",(long)_dataArray.count] Limit:@"15"];
        
    }
}

- (void)dealloc {
    
    [_headerView free];
    [_footerView free];
}


- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [_searchBar resignFirstResponder];
}

//点击键盘的搜索按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [_searchBar resignFirstResponder];
    [self clickSearch:_searchBar.text];
    
}
- (void)requestDataWithOffSet:(NSString *)OffSet Limit:(NSString *)limit {
    
    //首先请求数据
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([ud boolForKey:@"IsConsumer"]) {
        _userId = [NSString stringWithFormat:@"%@",[ud objectForKey:@"ConsumerId"]];
    }
    else {
        _userId = [NSString stringWithFormat:@"%@",[ud objectForKey:@"ProducerId"]];
        
    }

    [[JudgeNetState shareInstance] monitorNetworkType:self.view complete:^(NSInteger state) {
        
        if (state == 1 || state == 2) {
            
            [_JQRequest SearchGoodsListWithUserID:_userId IsFarmer:[ud boolForKey:@"IsConsumer"] ProductName:self.btnTitleStr ProductDesc:self.btnTitleStr OffSet:OffSet limit:limit complete:^(NSDictionary *responseObject) {
                
                [_dataArray removeAllObjects];
                NSLog(@"%@",responseObject);
                _dataArray = responseObject[@"List"];
                [_tableView reloadData];
                
                [_headerView endRefreshing];
                [_footerView endRefreshing];
                
            } fail:^(NSError *error, NSString *errorString) {
                NSLog(@"%@",errorString);
                
                CGSize size = [NSLocalizedString(@"The user does not exist or record", @"") sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(999, 100)];
                CGFloat labelX = (720 * scaleWidth - size.width) / 2 ;
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, 1200 * scaleHeight - 64, size.width, size.height)];
                label.backgroundColor = [UIColor blackColor];
                label.textAlignment = NSTextAlignmentCenter;
                label.textColor = [UIColor whiteColor];
                label.text = NSLocalizedString(@"The user does not exist or record", @"");
                [self.view addSubview:label];
                [self performSelector:@selector(removeLabel:) withObject:label afterDelay:1];
                
                [_headerView endRefreshing];
                [_footerView endRefreshing];
                
            }];
        }
        if (state == 3) {
            
            [_headerView endRefreshing];
            [_footerView endRefreshing];
            
        }
    }];
    
    }
- (void)removeLabel:(UILabel *)label {
    
    [label removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
    
}
//返回主页按钮
- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)search {
    
    [_searchBar resignFirstResponder];
    [self clickSearch:_searchBar.text];
    
}
- (void)clickSearch:(NSString *)searchStr {
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([ud boolForKey:@"IsConsumer"]) {
        _userId = [NSString stringWithFormat:@"%@",[ud objectForKey:@"ConsumerId"]];
    }
    else {
        _userId = [NSString stringWithFormat:@"%@",[ud objectForKey:@"ProducerId"]];
        
    }
    
    [_JQRequest SearchGoodsListWithUserID:_userId IsFarmer:[ud boolForKey:@"IsConsumer"] ProductName:_searchBar.text ProductDesc:_searchBar.text OffSet:@"0" limit:@"15" complete:^(NSDictionary *responseObject) {
        
        NSLog(@"%@",responseObject);
        _dataArray = responseObject[@"List"];
        [self createUI];
        
    } fail:^(NSError *error, NSString *errorString) {
        NSLog(@"%@",errorString);
        
        CGSize size = [NSLocalizedString(@"The user does not exist or record", @"") sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(999, 100)];
        CGFloat labelX = (720 * scaleWidth - size.width) / 2 ;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, 1200 * scaleHeight - 64, size.width, size.height)];
        label.backgroundColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.text = NSLocalizedString(@"The user does not exist or record", @"");
        [self.view addSubview:label];
        [self performSelector:@selector(removeLabel:) withObject:label afterDelay:1];
        
    }];

}
- (void)createUI {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height - 64)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}
//UITableView的代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dict = _dataArray[indexPath.row];
    NSDictionary *ProductInfoDict = dict[@"ProductInfo"];
    CGSize sizeLabel = [ProductInfoDict[@"name"] sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(999, 100)];
    CGSize sizePrice = [[NSString stringWithFormat:@"<fuhao>¥</fuhao><price>%@</price><type>/%@</type> <yunfei>| 运费:%@</yunfei>",ProductInfoDict[@"price"], ProductInfoDict[@"unit"], ProductInfoDict[@"freight"]] sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(999, 100)];
    return 100 * scaleHeight + sizePrice.height + sizeLabel.height;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SouSuoTableViewCell *sousuoCell = [tableView dequeueReusableCellWithIdentifier:@"sousuoCell"];
    if (!sousuoCell) {
        sousuoCell = [[SouSuoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sousuoCell"];
    }
    NSDictionary *dict = _dataArray[indexPath.row];
    [sousuoCell configWithDictionary:dict];
    return sousuoCell;
}
//cell的点击事件
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
