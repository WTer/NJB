//
//  GuanZhuFenSiViewController.m
//  农家帮
//
//  Created by Mac on 16/4/6.
//  Copyright © 2016年 jingqi. All rights reserved.
//

#import "GuanZhuFenSiViewController.h"
#import "LiaoTianJieMianViewController.h"
#import "GuanZhuFenSiTableViewCell.h"

@interface GuanZhuFenSiViewController ()<UITableViewDataSource,UITableViewDelegate,YaoQingDelegate>

@property (nonatomic, strong) NSMutableArray *models;

@end

@implementation GuanZhuFenSiViewController
{
    NSInteger _lastSelectTag;
    JQBaseRequest *_jqRequest;
    NSMutableArray *_dataArray;
    
    UISearchBar *_searchBar;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = BaseColor(233, 233, 233, 1);
    
    
    self.title = @"关注与粉丝";
    
    _dataArray = [[NSMutableArray alloc] init];
    _models = [[NSMutableArray alloc] init];
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [button setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(leftBackButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self createUI];
    
    [self requstList];
    
    
    
}
- (void)requstList {
    
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    JQBaseRequest * jq = [[JQBaseRequest alloc]init];
    
    if ([ud boolForKey:@"IsConsumer"]) {
        
        [jq ChaXunMaiJia3GuanZhuAllMaiJia4ListWithConsumerId:[NSString stringWithFormat:@"%@",[ud objectForKey:@"ConsumerId"]]
                                                    complete:^(NSDictionary *responseObject) {
                                                        
                                                        
                                                        NSLog(@"我关注的卖家:%@",responseObject);
                                                        
                                                        [_dataArray addObjectsFromArray:responseObject[@"List"]];
                                                        
                                                        NSArray *array = [responseObject valueForKey:@"List"];
                                                        
                                                        for (NSDictionary *dic in array) {
                                                            
                                                            [_models addObject:[[XiaoFeiZheModel alloc] initWithDictionary:dic]];
                                                            
                                                        }
                                                        
                                                        [_tableView reloadData];
                                                    }
                                                        fail:^(NSError *error, NSString *errorString) {
                                                            [self requstList];
                                                        }];
        
        
    }
    else {
        
        [jq ChaXunMaiJia4GuanZhuAllMaiJia4ListWithProducerId:[NSString stringWithFormat:@"%@",[ud objectForKey:@"ProducerId"]]
                                                    complete:^(NSDictionary *responseObject) {
                                                        
                                                        
                                                        NSLog(@"我关注的卖家:%@",responseObject);
                                                        
                                                        [_dataArray addObjectsFromArray:responseObject[@"List"]];
                                                        
                                                        NSArray *array = [responseObject valueForKey:@"List"];
                                                        
                                                        for (NSDictionary *dic in array) {
                                                            
                                                            [_models addObject:[[XiaoFeiZheModel alloc] initWithDictionary:dic]];
                                                            
                                                        }
                                                        
                                                        [_tableView reloadData];
                                                    }
                                                        fail:^(NSError *error, NSString *errorString) {
                                                            [self requstList];
                                                        }];
    }
    
}

- (void)createUI {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height - 64)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = BaseColor(233, 233, 233, 1);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 100 * scaleHeight + 44)];
    bottomView.backgroundColor = BaseColor(233, 233, 233, 1);
    _tableView.tableHeaderView = bottomView;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 72 * scaleHeight)];
    view.backgroundColor = [UIColor whiteColor];
    [bottomView addSubview:view];
    
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 100 * scaleHeight, Screen_Width, 44)];
    _searchBar.placeholder = @"搜索全部关注";
    [bottomView addSubview:_searchBar];
    
    
    NSArray *titleArray = @[@"关注",
                            @"粉丝"];
    
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

#pragma mark -TableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _models.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 150 * scaleHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GuanZhuFenSiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GuanZhuFenSiTableViewCell"];
    if (!cell) {
        cell = [[GuanZhuFenSiTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GuanZhuFenSiTableViewCell"];
    }
    cell.viewController = self;
    
    cell.delegate = self;
    
    
    if (_dataArray.count) {
        NSDictionary *dict = _dataArray[indexPath.row];
        [cell configWithDictionary:dict];
    }
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == _tableView) {
        [_searchBar resignFirstResponder];
    }
}

- (void)yaoQingXiaoFeiZheCell:(GuanZhuFenSiTableViewCell *)cell {
    
    LiaoTianJieMianViewController *liaotianjiemianVC = [[LiaoTianJieMianViewController alloc] init];
    liaotianjiemianVC.producerId = cell.producerId;
    liaotianjiemianVC.name = cell.nameString;
    liaotianjiemianVC.touxiang = cell.touxiangString;
    [self.navigationController pushViewController:liaotianjiemianVC animated:YES];
    
}

- (void)leftBackButtonClick {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
