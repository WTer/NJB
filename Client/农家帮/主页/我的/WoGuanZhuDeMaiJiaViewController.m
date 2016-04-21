//
//  WoGuanZhuDeMaiJiaViewController.m
//  农家帮
//
//  Created by Mac on 16/3/18.
//  Copyright © 2016年 jingqi. All rights reserved.
//

#import "WoGuanZhuDeMaiJiaViewController.h"
#import "WoGuanZhuDeMaiJiaTableViewCell.h"
#import "LiaoTianJieMianViewController.h"



@interface WoGuanZhuDeMaiJiaViewController () <UITableViewDataSource, UITableViewDelegate, YaoQingDelegate>

@property (nonatomic, strong) NSMutableArray *models;


@end

@implementation WoGuanZhuDeMaiJiaViewController
{
    NSMutableArray *_dataArray;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        self.title = NSLocalizedString(@"我关注的卖家", @"");
        _models = [NSMutableArray arrayWithCapacity:8];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _dataArray = [[NSMutableArray alloc] init];
    
    [self createSubViews];
    [self requstList];
}



- (void)createSubViews {
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"邀请", @"") style:UIBarButtonItemStylePlain target:self action:@selector(yaoQing)];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height - 40) style:UITableViewStylePlain];
    
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor =BaseColor(245, 245, 245, 1);
    tableView.rowHeight = scaleHeight * 106;
    [tableView setTableFooterView:[UIView new]];
    //    解决tableView分割线左边不到边的情况
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    [self.view addSubview:tableView];
    self.tabelView = tableView;
}

- (void)yaoQing {
    
    LiaoTianJieMianViewController *liaotianjiemianVC = [[LiaoTianJieMianViewController alloc] init];
    
    [self.navigationController pushViewController:liaotianjiemianVC animated:YES];
    
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
                                                        
                                                        [_tabelView reloadData];
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
                                                        
                                                        [_tabelView reloadData];
                                                    }
                                                        fail:^(NSError *error, NSString *errorString) {
                                                            [self requstList];
                                                        }];
        }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_models count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = NSStringFromClass([self class]);
    WoGuanZhuDeMaiJiaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[WoGuanZhuDeMaiJiaTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.viewController = self;
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 63, Screen_Width, 1)];
    line.backgroundColor = BaseColor(233, 233, 233, 1);
    [cell addSubview:line];
    cell.delegate = self;
    //cell.model = _models[indexPath.row];
    
    if (_dataArray.count) {
        NSDictionary *dict = _dataArray[indexPath.row];
        [cell configWithDictionary:dict];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 64;
}

- (void)yaoQingXiaoFeiZheCell:(WoGuanZhuDeMaiJiaTableViewCell *)cell {
    
    LiaoTianJieMianViewController *liaotianjiemianVC = [[LiaoTianJieMianViewController alloc] init];
    liaotianjiemianVC.producerId = cell.producerId;
    liaotianjiemianVC.name = cell.nameString;
    liaotianjiemianVC.touxiang = cell.touxiangString;
    [self.navigationController pushViewController:liaotianjiemianVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
