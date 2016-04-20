//
//  AlsoExpressMessageViewController.m
//  农帮乐
//
//  Created by 王朝源 on 15/12/8.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "AlsoExpressMessageViewController.h"
#import "KuaiDiMessageTableViewCell.h"
@interface AlsoExpressMessageViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation AlsoExpressMessageViewController
{
    UITableView * _tableView;
    NSArray * _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"常用快递信息", @"");
    [self requestData];
    [self createTableView];
    [self setExtraCellLineHidden:_tableView];
    // Do any additional setup after loading the view.
}

#pragma mark  -请求数据
-(void)requestData
{
    [[JudgeNetState shareInstance]monitorNetworkType:self.view complete:^(NSInteger state) {
    if (state == 1 || state == 2) {
        JQBaseRequest * jq = [[JQBaseRequest alloc]init];
        [jq selectedHotKuaiDiWithLimit:@"10" complete:^(NSDictionary *responseObject) {
            [responseObject writeToFile:HuanCunOfAlsoExpress atomically:YES];
            _dataArray = responseObject[@"List"];
            [_tableView reloadData];
        } fail:^(NSError *error, NSString *errorString) {
            
        }];
    }else{
        NSDictionary * responseObject = [NSDictionary dictionaryWithContentsOfFile:HuanCunOfAlsoExpress];
        _dataArray = responseObject[@"List"];
        [_tableView reloadData];
    }
    }];
  
}


- (void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height - 64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[KuaiDiMessageTableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableView.rowHeight = scaleHeight * 108;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KuaiDiMessageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if ([_dataArray[indexPath.row][@"HotExpress"] isKindOfClass:[NSDictionary class]] == YES) {
        if ([[_dataArray[indexPath.row][@"HotExpress"] allKeys] containsObject:@"Name"] == YES) {
            cell.headerImageUrl = _dataArray[indexPath.row][@"HotExpress"][@"Name"];
            cell.nameString =  _dataArray[indexPath.row][@"HotExpress"][@"Name"];
        }
        if ([[_dataArray[indexPath.row][@"HotExpress"] allKeys] containsObject:@"Website"] == YES) {
            cell.urlString =  _dataArray[indexPath.row][@"HotExpress"][@"Website"];
        }
        if ([[_dataArray[indexPath.row][@"HotExpress"] allKeys] containsObject:@"Telephone"] == YES) {
             cell.phoneNumberString = _dataArray[indexPath.row][@"HotExpress"][@"Telephone"];
        }
       
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    if (scrollView.contentOffset.y > 0) {
//        scrollView.contentOffset = CGPointMake(0, 0);
//    }
//}

#pragma mark --隐藏多余的cell
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
