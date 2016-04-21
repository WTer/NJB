//
//  QianZaiXiaoFeiZheViewController.m
//  农家帮
//
//  Created by 赵波 on 16/3/6.
//  Copyright © 2016年 jingqi. All rights reserved.
//

#import "QianZaiXiaoFeiZheViewController.h"
#import "XiaoFeiZheCellTableViewCell.h"
#import "YaoQingMessageViewController.h"

@interface QianZaiXiaoFeiZheViewController () <UITableViewDataSource, UITableViewDelegate, YaoQingDelegate>

@property (nonatomic, strong) NSMutableArray *models;
@property (nonatomic, strong) UITableView *tabelView;

@end

@implementation QianZaiXiaoFeiZheViewController

- (instancetype)init {
    
    self = [super init];
    if (self) {
        self.title = @"潜在消费者";
        _models = [NSMutableArray arrayWithCapacity:8];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self createSubViews];
    [self requstList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    YaoQingMessageViewController *yvc = [[YaoQingMessageViewController alloc] init];
    
    [self.navigationController pushViewController:yvc animated:YES];
    
}

- (void)requstList {
    
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    JQBaseRequest * jq = [[JQBaseRequest alloc]init];
    
    [jq qianZaiXiaoFeiZheLieBiaoWithWithProducerId:[ud objectForKey:UserID]
                                complete:^(NSDictionary *responseObject) {
                                    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_models count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = NSStringFromClass([self class]);
    XiaoFeiZheCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[XiaoFeiZheCellTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 63, Screen_Width, 1)];
    line.backgroundColor = BaseColor(233, 233, 233, 1);
    [cell addSubview:line];
    cell.delegate = self;
    cell.model = _models[indexPath.row];
                
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 64;
}

- (void)yaoQingXiaoFeiZheCell:(XiaoFeiZheCellTableViewCell *)cell {
    
    YaoQingMessageViewController *yvc = [[YaoQingMessageViewController alloc] init];
    yvc.consumerId = cell.model.identifier;
    [self.navigationController pushViewController:yvc animated:YES];
    
}

@end
