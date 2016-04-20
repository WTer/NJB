//
//  AddressBookViewController.m
//  农帮乐
//
//  Created by 王朝源 on 15/12/8.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "AddressBookViewController.h"
#import "TongxunVIew.h"
#import "OrderButton.h"
#import "contactModel.h"
@interface AddressBookViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation AddressBookViewController
{
    UITableView *_tableView;
    NSMutableArray *_dataArry;// 总的数据源
    NSMutableArray *_resultArry;// 保存数据的展开状态(因为分组很多，所以不能设置一个bool类型记录)
    NSMutableArray * _orderMessageArray;
    NSMutableArray * _orderSectionNum;//用于放每个分组的订单个数
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"通讯录", @"");
    
    [self createData];
    [self createUI];
    [self requestData];
    [self setExtraCellLineHidden:_tableView];
}

#pragma mark  ---请求数据
- (void)requestData
{
    JQBaseRequest * jq = [[JQBaseRequest alloc]init];
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    NSString * str = [ud objectForKey:UserCategory];
    [[JudgeNetState shareInstance]monitorNetworkType:self.view complete:^(NSInteger state) {
        if (state == 1 || state == 2) {
            if ([str isEqualToString:@"消费者"] == YES) {
                [jq ConsumerContactPeopleSelectedWithConsumerId:[ud objectForKey:@"UserId"] complete:^(NSDictionary *responseObject) {
                    [responseObject writeToFile:HuanCunOfAddressBook atomically:YES];
                    NSArray * array = responseObject[@"List"];
                    for (NSDictionary * dict in array) {
                        NSDictionary * dict2 = dict[@"ContactInfo"];
                        contactModel * model = [[contactModel alloc]initWithInfo:dict2];
                        [_dataArry addObject:model];
                        [_resultArry addObject:@(NO)];
                        [_orderMessageArray addObject:dict[@"OrderInfo"]];
                        NSArray  * ar = dict[@"OrderInfo"];
                        [_orderSectionNum addObject:[NSString stringWithFormat:@"%ld", ar.count]];
                    }
                    [_tableView reloadData];
                } fail:^(NSError *error, NSString *errorString) {
                    
                }];
            }else{
                [jq  selectedFarmerOwnerContactListWithProducerId:[ud objectForKey:@"UserId"] complete:^(NSDictionary *responseObject) {
                    [responseObject writeToFile:HuanCunOfAddressBook atomically:YES];
                    NSArray * array = responseObject[@"List"];
                    for (NSDictionary * dict in array) {
                        NSDictionary * dict2 = dict[@"ContactInfo"];
                        contactModel * model = [[contactModel alloc]initWithInfo:dict2];
                        [_dataArry addObject:model];
                        [_resultArry addObject:@(NO)];
                        [_orderMessageArray addObject:dict[@"OrderInfo"]];
                        NSArray  * ar = dict[@"OrderInfo"];
                        [_orderSectionNum addObject:[NSString stringWithFormat:@"%ld", ar.count]];
                    }
                    [_tableView reloadData];
                } fail:^(NSError *error, NSString *errorString) {
                    
                }];
            }
        }else{
            NSDictionary * responseobject = [NSDictionary dictionaryWithContentsOfFile:HuanCunOfAddressBook];
            if (responseobject) {
                NSArray * array = responseobject[@"List"];
                for (NSDictionary * dict in array) {
                    NSDictionary * dict2 = dict[@"ContactInfo"];
                    contactModel * model = [[contactModel alloc]initWithInfo:dict2];
                    [_dataArry addObject:model];
                    [_resultArry addObject:@(NO)];
                    [_orderMessageArray addObject:dict[@"OrderInfo"]];
                    NSArray  * ar = dict[@"OrderInfo"];
                    [_orderSectionNum addObject:[NSString stringWithFormat:@"%ld", ar.count]];
                }
                [_tableView reloadData];
            }
        }
    }];

}

- (void)createData
{
    _dataArry = [[NSMutableArray alloc]init];
    _resultArry = [[NSMutableArray alloc]init];
    _orderMessageArray = [[NSMutableArray alloc]init];
    _orderSectionNum = [[NSMutableArray alloc]init];
}

- (void)createUI
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 50 * scaleHeight;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

#pragma mark - tabviewDelegate
// 设置头标的view
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    TongxunVIew *bu = [[TongxunVIew alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 226)];
    bu.orderNumber = _orderSectionNum[section];
    bu.model = _dataArry[section];
    BOOL bo = [[_resultArry objectAtIndex:section] boolValue];
    if (bo) {
        bu.OrderButton.selected = YES;
    }else{
        bu.OrderButton.selected = NO;
    }
    bu.tag = section + 1;
    [bu addTarget:self action:@selector(headClick:) forControlEvents:UIControlEventTouchUpInside];
    return bu;
}

- (void)headClick:(TongxunVIew *)sender
{
    // 通过点击的段数，来获取数组里的bool（对应的展开状态）
    BOOL bo = [[_resultArry objectAtIndex:sender.tag-1] boolValue];
    
    // 把点击段数的状态转换为相反的状态
    [_resultArry replaceObjectAtIndex:sender.tag-1 withObject:[NSNumber numberWithBool:!bo]];
    // 刷新某个分段（只有这一个刷新分组的方法，所以刷新一组，或者刷新全组都是这样写，NSIndexSet为一个集合）
//    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag-1] withRowAnimation:UITableViewRowAnimationAutomatic];
    [_tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArry.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{// 分组里有几行，这个是动态的，因为要判断分组的状态
    if (_resultArry.count > 0) {
        if (![[_resultArry objectAtIndex:section] boolValue]) {
            // 折叠状态，就返回0行
            return 0;
        }
        NSArray * array = _orderMessageArray[section];
         return array.count * 2 + 1;
    }
    return 0;
    // 否则返回对应分组的数量
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.row % 2 == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"asd"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"asd"];
        }
        cell.backgroundColor = BaseColor(245, 245, 245, 1);
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"asd1"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"asd1"];
        }
         NSArray * array = _orderMessageArray[indexPath.section];
        NSDictionary * dict = array[(indexPath.row - 1) / 2];
//        cell.textLabel.text = [NSString stringWithFormat:@"%@ 订单号：%@", dict[@"ordertime"], dict[@"orderid"]];
        NSDictionary* style1 = @{@"body":[UIFont systemFontOfSize:21.0],
                                 @"bold":[UIFont boldSystemFontOfSize:21.0],
                                 @"green": BaseColor(37, 129, 255, 1),
                                 @"gray":BaseColor(178, 178, 178, 1)};
        cell.textLabel.attributedText = [[NSString stringWithFormat:@"<gray>%@ %@：</gray><green>%@</green>", dict[@"ordertime"], NSLocalizedString(@"订单号", @""),dict[@"orderid"]] attributedStringWithStyleBook:style1];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *lable = [[UIView alloc]init];
    lable.backgroundColor = BaseColor(245, 245, 245, 1);
    return lable;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20 * scaleHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 266 * scaleHeight;
}
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


@end
