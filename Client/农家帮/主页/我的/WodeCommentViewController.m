//
//  WodeCommentViewController.m
//  农帮乐
//
//  Created by 王朝源 on 15/12/8.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "WodeCommentViewController.h"
#import "MyCommentTableViewCell.h"
#import "myCommentModel.h"
#import "MJRefresh.h"
@interface WodeCommentViewController ()<UITableViewDataSource, UITableViewDelegate, MJRefreshBaseViewDelegate>

@end

@implementation WodeCommentViewController
{
    UITableView * _tableView;
    NSMutableArray * _dataArray;
    MJRefreshHeaderView * _header;
    MJRefreshFooterView * _footer;
    UIImageView * _view;//当没有相应的收藏的时候显示的空的界面
    UILabel * lb;
    NSInteger _pag;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _pag = 0;
    self.navigationItem.title = NSLocalizedString(@"我的评论", @"");
    self.view.backgroundColor = BaseColor(249, 249, 249, 1);
    _dataArray = [[NSMutableArray alloc]init];
    [self createBackLeftButton];
    [self createTableView];
    [self createRefresh];
    [self requestdata];
    [self setExtraCellLineHidden:_tableView];
    // Do any additional setup after loading the view.
}
//创建刷新
- (void)createRefresh
{
    _header = [MJRefreshHeaderView header];
    _footer = [MJRefreshFooterView footer];
    _header.delegate = self;
    _footer.delegate = self;
    _footer.scrollView = _tableView;
    _header.scrollView = _tableView;
    
}
//创建tableView
- (void)requestdata
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    NSString * str = [ud objectForKey:UserCategory];
    if ([str isEqualToString:@"消费者"] == YES) {
        JQBaseRequest * jq = [[JQBaseRequest alloc]init];
        [jq SelectedSomeBodyAllGoodsCommentsWithConsumerId:[ud objectForKey:@"UserId"] Offset:@"0" Limit:@"15" complete:^(NSDictionary *responseObject) {
            [_dataArray removeAllObjects];
            NSArray * array = responseObject[@"List"];
            for (NSDictionary * dict in array) {
                myCommentModel * model = [[myCommentModel alloc]initWithInfo:dict];
                [_dataArray addObject:model];
            }
            [_header endRefreshing];
            [_footer endRefreshing];
            [_tableView reloadData];
            if (_dataArray.count < 1) {
                [self kong];
            }
        } fail:^(NSError *error, NSString *errorString) {
            [_header endRefreshing];
            [_footer endRefreshing];
            [self kong];
        }];
    }else{
        JQBaseRequest * jq = [[JQBaseRequest alloc]init];
        [jq SelectedSomeBodyAllGoodsCommentsWithConsumerId:@"" Offset:@"0" Limit:@"15" complete:^(NSDictionary *responseObject) {
            [_header endRefreshing];
            [_footer endRefreshing];
            [_tableView reloadData];
            if (_dataArray.count < 1) {
                [self kong];
            }
        } fail:^(NSError *error, NSString *errorString) {
            [_header endRefreshing];
            [_footer endRefreshing];
            [self kong];
        }];

        
    }
}
//上提加载
- (void)refreshRequest
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    NSString * str = [ud objectForKey:UserCategory];
    if ([str isEqualToString:@"消费者"] == YES) {
        JQBaseRequest * jq = [[JQBaseRequest alloc]init];
        [jq SelectedSomeBodyAllGoodsCommentsWithConsumerId:[ud objectForKey:@"UserId"] Offset:[NSString stringWithFormat:@"%ld", _pag] Limit:@"15" complete:^(NSDictionary *responseObject) {
            NSArray * array = responseObject[@"List"];
            for (NSDictionary * dict in array) {
                myCommentModel * model = [[myCommentModel alloc]initWithInfo:dict];
                [_dataArray addObject:model];
            }
            [_tableView reloadData];
            [_header endRefreshing];
            [_footer endRefreshing];
            if (_dataArray.count < 1) {
                [self kong];
            }
        } fail:^(NSError *error, NSString *errorString) {
            [_header endRefreshing];
            [_footer endRefreshing];
            if (_dataArray.count < 1) {
                [self kong];
            }
        }];
    }else {
        JQBaseRequest * jq = [[JQBaseRequest alloc]init];
        [jq SelectedSomeBodyAllGoodsCommentsWithConsumerId:@"" Offset:@"0" Limit:@"15" complete:^(NSDictionary *responseObject) {
            [_header endRefreshing];
            [_footer endRefreshing];
            [_tableView reloadData];
            if (_dataArray.count < 1) {
                [self kong];
            }
        } fail:^(NSError *error, NSString *errorString) {
            [_header endRefreshing];
            [_footer endRefreshing];
            [self kong];
        }];

    }
}

-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView == _header) {
        [self requestdata];
    }
    if (refreshView == _footer) {
        _pag = [_dataArray count];
        [self refreshRequest];
    }
}

#pragma mark --隐藏多余的cell
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    
    view.backgroundColor = BaseColor(249, 249, 249, 1);
    
    [tableView setTableFooterView:view];
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
    lb.text = NSLocalizedString(@"亲，您暂时没有任何评论！", @"");
    lb.textAlignment = NSTextAlignmentCenter;
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_view.mas_bottom).offset(60 * scaleHeight);
        make.centerX.mas_equalTo(_tableView.mas_centerX);
        make.height.mas_equalTo(60);
    }];
    BaseLableSet(lb, 52, 52, 52, 28);
}

- (void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[MyCommentTableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableView.rowHeight = 430 * scaleHeight;
    _tableView.backgroundColor = BaseColor(249, 249, 249, 1);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCommentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.backgroundColor = BaseColor(249, 249, 249, 1);
    cell.model = _dataArray[indexPath.row];
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//创建返回按钮
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
- (void)dealloc
{
    [_header free];
    [_footer free];
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
