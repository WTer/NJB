//
//  ShouhuoDizhiViewController.m
//  农帮乐
//
//  Created by hpz on 15/12/14.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "ShouhuoDizhiViewController.h"
#import "ZengjiaDizhiViewController.h"
#import "ShouhuoDizhiTableViewCell.h"
#import "AddDiZhiView.h"
@interface ShouhuoDizhiViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ShouhuoDizhiViewController
{
    JQBaseRequest *_JQRequest;
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    
    UIActivityIndicatorView *_indication;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Shipping address", @"");
    self.navigationController.navigationBar.translucent  = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    _dataArray = [[NSMutableArray alloc] init];
    _JQRequest = [[JQBaseRequest alloc] init];
    
    [self createUI];
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self requestData];
}
//从服务器上获得消费者的收货地址
- (void)requestData {
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[NSString stringWithFormat:@"%@",[ud objectForKey:@"ConsumerId"]]);
    
    [[JudgeNetState shareInstance] monitorNetworkType:self.view complete:^(NSInteger state) {
        
        if (state == 1 || state == 2) {
            
            _tableView.alpha = 0.6;
            _tableView.userInteractionEnabled = NO;
            _indication = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            _indication.frame = CGRectMake(Screen_Width / 2 - 40, Screen_Height / 2 - 104, 80, 80);
            _indication.backgroundColor = [UIColor blackColor];
            _indication.hidesWhenStopped = NO;
            [_indication startAnimating];
            [self.view addSubview:_indication];
            
            [_JQRequest getShouHuoDiZhiListConsumerId:[NSString stringWithFormat:@"%@",[ud objectForKey:@"ConsumerId"]] Complete:^(NSDictionary *responseObject) {
                NSLog(@"%@",responseObject);
                [_dataArray removeAllObjects];
                _dataArray = responseObject[@"List"];
                
                [_tableView reloadData];
                
                _tableView.alpha = 1;
                _tableView.userInteractionEnabled = YES;
                [_indication removeFromSuperview];
                
                
            } fail:^(NSError *error, NSString *errorString) {
                
                _tableView.alpha = 1;
                _tableView.userInteractionEnabled = YES;
                [_indication removeFromSuperview];
                
                NSLog(@"%@",errorString);
            }];
        }
    
    }];
}
- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)createUI {

    AddDiZhiView *addDizhi = [[AddDiZhiView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 100 * scaleHeight)];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [addDizhi addGestureRecognizer:tapGesture];
    [self.view addSubview:addDizhi];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100 * scaleHeight, Screen_Width, Screen_Height - 64 - 100 * scaleHeight)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = BaseColor(242, 242, 242, 1);
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSDictionary *dict = _dataArray[indexPath.row];
    NSDictionary *ConsigneeDict = dict[@"Consignee"];
    //收货人
    CGSize nameSize = [[NSString stringWithFormat:@"%@",ConsigneeDict[@"name"]] sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(999, 100)];
    //收货人地址
    CGSize dizhiSize = [[NSString stringWithFormat:@"%@%@%@%@",ConsigneeDict[@"province"], ConsigneeDict[@"city"], ConsigneeDict[@"district"], ConsigneeDict[@"address"]] sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(990, 100)];
    NSLog(@"dadsadasd%@",NSStringFromCGSize(dizhiSize));
    if (dizhiSize.width >= 990) {
        dizhiSize.height = dizhiSize.height * 0.5;
    }
    CGFloat width = dizhiSize.width;
    NSInteger count = 1;
    for (NSInteger i = 0; width >= 592 * scaleHeight; i++) {
        count++;
        width -= 592 * scaleHeight;
    }

    
    return 198 * scaleHeight + nameSize.height + dizhiSize.height * count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ShouhuoDizhiTableViewCell *shouhuoDizhiCell = [[ShouhuoDizhiTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"shouhuoDizhiCell"];
    NSDictionary *dict = _dataArray[indexPath.row];
    shouhuoDizhiCell.viewController = self;
    [shouhuoDizhiCell configWithDictiongary:dict];
    return shouhuoDizhiCell;
}
//cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
        
    NSDictionary *dict = _dataArray[indexPath.row];
    NSDictionary *ConsigneeDict = dict[@"Consignee"];
    NSNotification *noti = [[NSNotification alloc] initWithName:@"tongzhi" object:ConsigneeDict userInfo:nil];
    [[NSNotificationCenter defaultCenter]postNotification:noti];
    
    [self.navigationController popViewControllerAnimated:YES];

}
- (void)tap:(UITapGestureRecognizer *)tap {

    ZengjiaDizhiViewController *zengjiaDizhiVC = [[ZengjiaDizhiViewController alloc] init];
    zengjiaDizhiVC.isXiuGai = NO;
    [self.navigationController pushViewController:zengjiaDizhiVC animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
