//
//  WodeCollectionViewController.m
//  农帮乐
//
//  Created by 王朝源 on 15/12/8.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "WodeCollectionViewController.h"
#import "MyCollectionTableViewCell.h"
#import "myCollectionModel.h"
#import "MJRefresh.h"
#import "OthersCollectionTableViewCell.h"
#import "LiaoTianJieMianViewController.h"

@interface WodeCollectionViewController ()<UITableViewDataSource, UITableViewDelegate, MJRefreshBaseViewDelegate>

@end

@implementation WodeCollectionViewController
{
    UITableView * _tableView;
    NSMutableArray * _dataArray;
    MJRefreshFooterView * _footer;
    MJRefreshHeaderView * _header;
    UIImageView * _view;
    UILabel * lb;
    
    
    
    NSInteger _lastSelectTag;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"我的收藏", @"");
    _dataArray = [[NSMutableArray alloc]init];
    self.view.backgroundColor = BaseColor(249, 249, 249, 1);
    [self createBackLeftButton];
    [self createTableView];
    [self requestData:@"0" isRefresh:NO];
    
    [self createRefresh];
    [self setExtraCellLineHidden:_tableView];
    
}
#pragma mark  --隐藏多余的cell
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    _tableView.backgroundColor =BaseColor(245, 245, 245, 1);
}

#pragma mark ---刷新数据
- (void)createRefresh
{
    _header = [MJRefreshHeaderView header];
    _footer = [MJRefreshFooterView footer];
    _header.delegate = self;
    _footer.delegate = self;
    _footer.scrollView = _tableView;
    _header.scrollView = _tableView;
}
#pragma mark  --MjrefreshDelegate
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (_header == refreshView) {
        [self requestData:@"0" isRefresh:NO];
    }
    if (_footer == refreshView) {
        [self requestData:[NSString stringWithFormat:@"%ld", (unsigned long)_dataArray.count] isRefresh:YES];
    }
}

#pragma mark  --请求数据
- (void)requestData:(NSString *)str isRefresh:(BOOL) isRefresh
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    JQBaseRequest * jq = [[JQBaseRequest alloc]init];
    if ([[ud objectForKey:UserCategory] isEqualToString:@"消费者"] == YES) {
        [jq GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Favorite/Consumer/%@/Product/?offset=%@&limit=15&desc=false", [ud objectForKey:UserID], str] para:nil complete:^(NSDictionary *responseObject) {
            if (!isRefresh) {
                [_dataArray removeAllObjects];
            }
            NSArray * array = responseObject[@"List"];
            for (NSDictionary * dict in array) {
                myCollectionModel * model = [[myCollectionModel alloc]init];
                id dict2 = dict[@"FavoriteProductInfo"];
                if ([dict2 isKindOfClass:[NSDictionary class]] == YES){
                    if ([[dict2 allKeys] containsObject:@"name"]) {
                        model.name = dict2[@"name"];
                    }
                    if ([[dict2 allKeys] containsObject:@"price"]) {
                        model.price = dict2[@"price"];
                    }
                    if ([[dict2 allKeys] containsObject:@"type"]) {
                        model.type = dict2[@"type"];
                    }
                    if ([[dict2 allKeys] containsObject:@"unit"]) {
                        model.unit = dict2[@"unit"];
                    }
                    if ([[dict2 allKeys] containsObject:@"freight"]) {
                        model.freight = dict2[@"freight"];
                    }
                    if ([[dict2 allKeys] containsObject:@"productid"]) {
                        model.productid = dict2[@"productid"];
                    }
                    if ([[dict2 allKeys] containsObject:@"id"]) {
                        model.id = dict2[@"id"];
                    }
                }
                
                
                id dict3 = dict[@"FavoriteProductImages"];
                if ([dict3 isKindOfClass:[NSDictionary class]] == YES) {
                    model.smallportraiturl = dict3[@"smallportraiturl"];
                }else{
                    model.smallportraiturl = @"未知";
                }
                [model panduanQingqiuShuju];
                
                [_dataArray addObject:model];
            }
            [_tableView reloadData];
            [_header endRefreshing];
            [_footer endRefreshing];
        } fail:^(NSError *error, NSString *errorString) {
            [_header endRefreshing];
            [_footer endRefreshing];
        }];
    }else{
        [jq GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Favorite/Producer/%@/Product/?offset=%@&limit=15&desc=false", [ud objectForKey:UserID], str] para:nil complete:^(NSDictionary *responseObject) {
            if (!isRefresh) {
                [_dataArray removeAllObjects];
            }
            NSArray * array = responseObject[@"List"];
            for (NSDictionary * dict in array) {
                myCollectionModel * model = [[myCollectionModel alloc]init];
                id dict2 = dict[@"FavoriteProductInfo"];
                if ([dict2 isKindOfClass:[NSDictionary class]] == YES) {
                    if ([[dict2 allKeys] containsObject:@"name"]) {
                        model.name = dict2[@"name"];
                    }
                    if ([[dict2 allKeys] containsObject:@"price"]) {
                        model.price = dict2[@"price"];
                    }
                    if ([[dict2 allKeys] containsObject:@"type"]) {
                        model.type = dict2[@"type"];
                    }
                    if ([[dict2 allKeys] containsObject:@"unit"]) {
                        model.unit = dict2[@"unit"];
                    }
                    if ([[dict2 allKeys] containsObject:@"freight"]) {
                        model.freight = dict2[@"freight"];
                    }
                    if ([[dict2 allKeys] containsObject:@"productid"]) {
                        model.productid = dict2[@"productid"];
                    }
                    if ([[dict2 allKeys] containsObject:@"id"]) {
                        model.id = dict2[@"id"];
                    }
                }
                
                id dict3 = dict[@"FavoriteProductImages"];
                if ([dict3 isKindOfClass:[NSDictionary class]] == YES) {
                    model.smallportraiturl = dict3[@"smallportraiturl"];
                }else{
                    model.smallportraiturl = @"未知";
                }
                [model panduanQingqiuShuju];
                
                [_dataArray addObject:model];
            }
            [_tableView reloadData];
            [_header endRefreshing];
            [_footer endRefreshing];
        } fail:^(NSError *error, NSString *errorString) {
            [_header endRefreshing];
            [_footer endRefreshing];
        }];
    }
}
//空的时候显示的界面
- (void)kong
{
    _view = [[UIImageView alloc]initWithFrame:CGRectMake((Screen_Width - 194 * scaleWidth) / 2.0, 350 * scaleHeight, 194 * scaleWidth, 100 * scaleHeight)];
    _view.image = [UIImage imageNamed:@"icon_no.png"];
    _view.userInteractionEnabled = YES;
    [_tableView addSubview:_view];
    
    lb = [[UILabel alloc]init];
    [_tableView addSubview:lb];
    lb.text = NSLocalizedString(@"亲，您暂时没有任何收藏！", @"");
    lb.textAlignment = NSTextAlignmentCenter;
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_view.mas_bottom).offset(60 * scaleHeight);
        make.centerX.mas_equalTo(_tableView.mas_centerX);
        make.height.mas_equalTo(60);
    }];
    BaseLableSet(lb, 52, 52, 52, 28);
}
//创建tableview
- (void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height - 64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate  =self;
    [self.view addSubview:_tableView];
    _tableView.rowHeight = 260  *scaleHeight;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[MyCollectionTableViewCell class] forCellReuseIdentifier:@"cell"];
    [_tableView registerClass:[OthersCollectionTableViewCell class] forCellReuseIdentifier:@"OthersCollectionTableViewCell"];
     _tableView.backgroundColor =BaseColor(245, 245, 245, 1);
    
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 100 * scaleHeight)];
    bottomView.backgroundColor = BaseColor(233, 233, 233, 1);
    _tableView.tableHeaderView = bottomView;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 72 * scaleHeight)];
    view.backgroundColor = [UIColor whiteColor];
    [bottomView addSubview:view];
    
    NSArray *titleArray = @[NSLocalizedString(@"我的收藏", @""),
                            NSLocalizedString(@"他人收藏", @"")];
    
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
//创建返回按钮
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [_view removeFromSuperview];
    [lb removeFromSuperview];
    if ([_dataArray count] == 0) {
        [self kong];
    }
    return [_dataArray count];

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_lastSelectTag == 1000) {
        MyCollectionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.model = _dataArray[indexPath.row];
        [cell cancleCollectionButtonClick:^(UIButton *button) {
            [self ConsumercazuoOrder:indexPath.row];
        }];
        cell.backgroundColor =  BaseColor(245, 245, 245, 1);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }
    else {
    
        OthersCollectionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OthersCollectionTableViewCell"];
        cell.model = _dataArray[indexPath.row];
        [cell cancleCollectionButtonClick:^(UIButton *button) {
            
            
            LiaoTianJieMianViewController *liaotianjiemianVC = [[LiaoTianJieMianViewController alloc] init];
//            liaotianjiemianVC.producerId = [NSString stringWithFormat:@"%@",_ProductInfoDict[@"producerid"]];
//            liaotianjiemianVC.name = [NSString stringWithFormat:@"%@",_ProducerInfoDict[@"displayname"]];
//            liaotianjiemianVC.touxiang = [NSString stringWithFormat:@"%@",_ProducerInfoDict[@"smallportraiturl"]];
            [self.navigationController pushViewController:liaotianjiemianVC animated:YES];
            
            
            
            
        }];
        cell.backgroundColor =  BaseColor(245, 245, 245, 1);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
}

#pragma mark  -删除的提示框
- (void)ConsumercazuoOrder:(NSInteger)indexPathRow
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    myCollectionModel * model = _dataArray[indexPathRow];
    UIAlertController*alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    JQBaseRequest * jq = [[JQBaseRequest alloc]init];
    if ([[ud objectForKey:UserCategory] isEqualToString:@"消费者"] == YES) {
        UIAlertAction * otherAction2 = [UIAlertAction  actionWithTitle:NSLocalizedString(@"确定", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
            [jq DELETErequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Favorite/Consumer/Product/%@", model.id] para:nil complete:^(NSDictionary *responseObject) {
                [_dataArray removeObjectAtIndex:indexPathRow];
                [_tableView reloadData];
            } fail:^(NSError *error, NSString *errorString) {
            }];
            
        }];
        [alertController addAction:otherAction2];
    }else{
//        https://<endpoint>/Favorite/Producer/Product/[FavoriteId]
        UIAlertAction * otherAction2 = [UIAlertAction  actionWithTitle:NSLocalizedString(@"确定", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
            [jq DELETErequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Favorite/Producer/Product/%@", model.id] para:nil complete:^(NSDictionary *responseObject) {
                [_dataArray removeObjectAtIndex:indexPathRow];
                [_tableView reloadData];
            } fail:^(NSError *error, NSString *errorString) {
            }];
            
        }];
        [alertController addAction:otherAction2];
    }
    
    UIAlertAction * otherAction3 = [UIAlertAction  actionWithTitle:NSLocalizedString(@"取消", @"") style:UIAlertActionStyleCancel handler:^(UIAlertAction*action) {
        
        
    }];
    [alertController addAction:otherAction3];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)createBackLeftButton
{
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [button setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(leftBackButtonClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)leftBackButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    [_header free];
    [_footer free];
}


@end
