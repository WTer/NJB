//
//  WodeOrderViewController.m
//  农帮乐
//
//  Created by 王朝源 on 15/12/8.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "WodeOrderViewController.h"
#import "MyConfirmBaseButton.h"
#import "MyOrderTableViewCell.h"
#import "MyOrderCancleTableViewCell.h"
#import "MyOrderCertainTableViewCell.h"
#import "myOrderModel.h"
#import "MJRefresh.h"
#import "consumerOrderTableViewCell.h"
#import "YiXiaJiaTableViewCell.h"

@interface WodeOrderViewController ()<UITableViewDataSource, UITableViewDelegate ,MJRefreshBaseViewDelegate>

@end
//_imageView.image = [UIImage imageNamed:@"grzx_wddd_icon.png"];
@implementation WodeOrderViewController
{
    MyConfirmBaseButton * _waitConfirm;
    MyConfirmBaseButton * _hasBeenConfirm;
    MyConfirmBaseButton * _hasBeenCancle;
    MyConfirmBaseButton * _hasBeenPublish;
    
    
    UITableView * _tableView;
    NSArray * _dataArray;
    UIView * _lowLineView;
    
    NSMutableArray * _waitConfirmDataArray;//同时数组的数量也用于记录请求的数量
    NSMutableArray * _hasCertainDataArray;
    NSMutableArray * _cancleDataArray;
    
    
    NSMutableArray *_publishArray;
    
    //用于记录请求的状态（是第几个状态的请求）
    NSString * _JLstate;
    
    NSInteger _jlStateDateNumber;
    
    MJRefreshFooterView * _footer;
    MJRefreshHeaderView * _header;
    
    UIImageView * _view;
    UILabel * lb;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _JLstate = @"0";
    self.navigationItem.title = NSLocalizedString(@"我的订单", @"");
    self.view.backgroundColor = BaseColor(249, 249, 249, 1);
    _waitConfirmDataArray = [[NSMutableArray alloc]init];
    _hasCertainDataArray = [[NSMutableArray alloc]init];
    _cancleDataArray = [[NSMutableArray alloc]init];

    
    _publishArray = [[NSMutableArray alloc] init];
    
    [self createBackLeftButton];
    [self createButton];//创建确认的三个按钮
    [self createTableView];
    [self waitCertainOrderRequest];
    [self selectEveryOrderNumber];
    [self setExtraCellLineHidden:_tableView];
    
}

#pragma mark  --隐藏多余的cell
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
}
#pragma mark --创建刷新
- (void)createRefresh
{
    [_header free];
    [_footer free];
    _footer = [MJRefreshFooterView footer];
    _footer.delegate = self;
    _footer.scrollView = _tableView;
    
    _header = [MJRefreshHeaderView header];
    _header.delegate = self;
    _header.scrollView = _tableView;
}

-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView == _header) {
        _jlStateDateNumber = 0;
        [self waitCertainOrderRequest];
    }else{
        _jlStateDateNumber = [_waitConfirmDataArray count];
        [self requestMoreData];
    }
}

#pragma mark  --查询各个订单的数量
- (void)selectEveryOrderNumber
{
//    [NSString stringWithFormat:@"%@(%@)",NSLocalizedString(@"待确认", @""),responseObject[@"pending"]];
//    [NSString stringWithFormat:@"%@(%@)", NSLocalizedString(@"已确认", @""),responseObject[@"confirmed"]];
//    [NSString stringWithFormat:@"%@(%@)",NSLocalizedString(@"已取消", @""),responseObject[@"cancelled"]];
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    JQBaseRequest * jq = [[JQBaseRequest alloc]init];
    NSLog(@"%@",[ud  objectForKey:UserCategory]);
    if ([[ud  objectForKey:UserCategory] isEqualToString:@"消费者"] == YES) {
        [jq GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Order/Consumer/%@/Count/Detail/", [ud objectForKey:UserID]] para:nil complete:^(NSDictionary *responseObject) {
            if ([[responseObject allKeys] containsObject:@"pending"] == YES) {
                [_waitConfirm setTitle:[NSString stringWithFormat:@"%@(%@)",NSLocalizedString(@"待确认", @""),responseObject[@"pending"]] forState:UIControlStateNormal];
                [_waitConfirm setTitle:[NSString stringWithFormat:@"%@(%@)",NSLocalizedString(@"待确认", @""),responseObject[@"pending"]]  forState:UIControlStateSelected];
            }
            if ([[responseObject allKeys]containsObject:@"confirmed"] == YES) {
                [_hasBeenConfirm setTitle:[NSString stringWithFormat:@"%@(%@)", NSLocalizedString(@"已确认", @""),responseObject[@"confirmed"]]  forState:UIControlStateNormal];
                [_hasBeenConfirm setTitle:[NSString stringWithFormat:@"%@(%@)", NSLocalizedString(@"已确认", @""),responseObject[@"confirmed"]]  forState:UIControlStateSelected];
            }
            if ([[responseObject allKeys]containsObject:@"cancelled"] == YES) {
                [_hasBeenCancle setTitle:[NSString stringWithFormat:@"%@(%@)",NSLocalizedString(@"已取消", @""),responseObject[@"cancelled"]]  forState:UIControlStateNormal];
                [_hasBeenCancle setTitle:[NSString stringWithFormat:@"%@(%@)",NSLocalizedString(@"已取消", @""),responseObject[@"cancelled"]]  forState:UIControlStateSelected];
            }
            
        } fail:^(NSError *error, NSString *errorString) {
            
            NSLog(@"消费者  %@", errorString);
            
        }];
    }
    else {
        
        [jq GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Order/Producer/%@/Count/Detail/", [ud objectForKey:UserID]] para:nil complete:^(NSDictionary *responseObject) {
            if ([[responseObject allKeys] containsObject:@"pending"] == YES) {
                [_waitConfirm setTitle:[NSString stringWithFormat:@"%@(%@)",NSLocalizedString(@"待确认", @""),responseObject[@"pending"]] forState:UIControlStateNormal];
                [_waitConfirm setTitle:[NSString stringWithFormat:@"%@(%@)",NSLocalizedString(@"待确认", @""),responseObject[@"pending"]]  forState:UIControlStateSelected];
            }
            if ([[responseObject allKeys]containsObject:@"confirmed"] == YES) {
                [_hasBeenConfirm setTitle:[NSString stringWithFormat:@"%@(%@)", NSLocalizedString(@"已确认", @""),responseObject[@"confirmed"]]  forState:UIControlStateNormal];
                [_hasBeenConfirm setTitle:[NSString stringWithFormat:@"%@(%@)", NSLocalizedString(@"已确认", @""),responseObject[@"confirmed"]]  forState:UIControlStateSelected];
            }
            if ([[responseObject allKeys]containsObject:@"cancelled"] == YES) {
                [_hasBeenCancle setTitle:[NSString stringWithFormat:@"%@(%@)",NSLocalizedString(@"已取消", @""),responseObject[@"cancelled"]]  forState:UIControlStateNormal];
                [_hasBeenCancle setTitle:[NSString stringWithFormat:@"%@(%@)",NSLocalizedString(@"已取消", @""),responseObject[@"cancelled"]]  forState:UIControlStateSelected];
            }
           
           
            
            
        } fail:^(NSError *error, NSString *errorString) {
            
            NSLog(@"农场主  %@", errorString);
            
        }];
        
        
        
        [jq GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Producer/%@/ProductList", [NSString stringWithFormat:@"%@",[ud objectForKey:@"ProducerId"]]] para:nil complete:^(NSDictionary *responseObject) {
            
            [_hasBeenPublish setTitle:[NSString stringWithFormat:@"%@(%@)",NSLocalizedString(@"已发布", @""),responseObject[@"Count"]] forState:UIControlStateNormal];
            [_hasBeenPublish setTitle:[NSString stringWithFormat:@"%@(%@)",NSLocalizedString(@"已发布", @""),responseObject[@"Count"]]  forState:UIControlStateSelected];
            
            
            
            
        } fail:^(NSError *error, NSString *errorString) {
            
            
            
        }];

        
        
        
    }
}

#pragma mark  --加载更多数据的网络请求
- (void)requestMoreData
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    JQBaseRequest * jq = [[JQBaseRequest alloc]init];
    if ([[ud objectForKey:UserCategory] isEqualToString:@"消费者"] == YES) {
        [jq GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Order/Consumer/%@/?status=%@&offset=%ld&limit=15", [ud objectForKey:UserID], _JLstate, (long)_jlStateDateNumber] para:nil complete:^(NSDictionary *responseObject) {
            NSArray * array = responseObject[@"List"];
            for (NSDictionary * dict in array) {
                myOrderModel * model = [[myOrderModel alloc]initWithInfo:dict];
                [_waitConfirmDataArray addObject:model];
            }
            [_tableView reloadData];
            [_header endRefreshing];
            [_footer endRefreshing];
            if (_waitConfirmDataArray.count == 0) {
                [self kong];
            }else{
                [_view removeFromSuperview];
                [lb removeFromSuperview];
            }
        } fail:^(NSError *error, NSString *errorString) {
            [_header endRefreshing];
            [_footer endRefreshing];
            if (_waitConfirmDataArray.count == 0) {
                [self kong];
            }else{
                [_view removeFromSuperview];
                [lb removeFromSuperview];
            }
        }];
    }else{
        [jq GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Order/Producer/%@/?status=%@&offset=%ld&limit=15", [ud objectForKey:UserID], _JLstate, (long)_jlStateDateNumber] para:nil complete:^(NSDictionary *responseObject) {
            NSArray * array = responseObject[@"List"];
            for (NSDictionary * dict in array) {
                myOrderModel * model = [[myOrderModel alloc]initWithInfo:dict];
                [_waitConfirmDataArray addObject:model];
            }
            [_tableView reloadData];
            [_header endRefreshing];
            [_footer endRefreshing];
            if (_waitConfirmDataArray.count == 0) {
                [self kong];
            }else{
                [_view removeFromSuperview];
                [lb removeFromSuperview];
            }
        } fail:^(NSError *error, NSString *errorString) {
            [_header endRefreshing];
            [_footer endRefreshing];
            if (_waitConfirmDataArray.count == 0) {
                [self kong];
            }else{
                [_view removeFromSuperview];
                [lb removeFromSuperview];
            }
        }];
    }
}


#pragma mark  -- 待确认订单
- (void)waitCertainOrderRequest
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    JQBaseRequest * jq = [[JQBaseRequest alloc]init];
    
    if ([_JLstate isEqualToString:@"3"] == NO) {
        if ([[ud objectForKey:UserCategory]isEqualToString:@"消费者"] == YES) {
            [jq GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Order/Consumer/%@/?status=%@&offset=0&limit=15", [ud objectForKey:UserID], _JLstate] para:nil complete:^(NSDictionary *responseObject) {
                [_waitConfirmDataArray removeAllObjects];
                NSArray * array = responseObject[@"List"];
                for (NSDictionary * dict in array) {
                    myOrderModel * model = [[myOrderModel alloc]initWithInfo:dict];
                    [_waitConfirmDataArray addObject:model];
                }
                [_tableView reloadData];
                [_header endRefreshing];
                [_footer endRefreshing];
                if (_waitConfirmDataArray.count == 0) {
                    [self kong];
                }else{
                    [_view removeFromSuperview];
                    [lb removeFromSuperview];
                }
            } fail:^(NSError *error, NSString *errorString) {
                [_header endRefreshing];
                [_footer endRefreshing];
                if (_waitConfirmDataArray.count == 0) {
                    [self kong];
                }else{
                    [_view removeFromSuperview];
                    [lb removeFromSuperview];
                }
            }];
        }
        else{
            [jq GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Order/Producer/%@/?status=%@&offset=0&limit=15", [ud objectForKey:UserID], _JLstate] para:nil complete:^(NSDictionary *responseObject) {
                [_waitConfirmDataArray removeAllObjects];
                NSArray * array = responseObject[@"List"];
                for (NSDictionary * dict in array) {
                    myOrderModel * model = [[myOrderModel alloc]initWithInfo:dict];
                    [_waitConfirmDataArray addObject:model];
                }
                [_tableView reloadData];
                [_header endRefreshing];
                [_footer endRefreshing];
                if (_waitConfirmDataArray.count == 0) {
                    [self kong];
                }else{
                    [_view removeFromSuperview];
                    [lb removeFromSuperview];
                }
            } fail:^(NSError *error, NSString *errorString) {
                [_header endRefreshing];
                [_footer endRefreshing];
                if (_waitConfirmDataArray.count == 0) {
                    [self kong];
                }else{
                    [_view removeFromSuperview];
                    [lb removeFromSuperview];
                }
            }];
        }

    }
    else {
    
        [jq GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Producer/%@/ProductList", [NSString stringWithFormat:@"%@",[ud objectForKey:@"ProducerId"]]] para:nil complete:^(NSDictionary *responseObject) {
            
            NSLog(@"%@",responseObject);
            
            [_publishArray removeAllObjects];
            
            [_publishArray addObjectsFromArray:responseObject[@"List"]];
            
            [_tableView reloadData];
            [_header endRefreshing];
            [_footer endRefreshing];
            
            
        } fail:^(NSError *error, NSString *errorString) {
            
            [_header endRefreshing];
            [_footer endRefreshing];
            
        }];
        
    }
}

//创建tableView
- (void)createTableView {
    
    _jlStateDateNumber = 0;
    _tableView = nil;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 96 * scaleHeight, Screen_Width, Screen_Height - 64 - 116 * scaleHeight) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     _tableView.backgroundColor =BaseColor(245, 245, 245, 1);
    [self createRefresh];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if ([_JLstate isEqualToString:@"3"] == YES) {
        
        if (_publishArray.count) {
            
            NSDictionary *dict = _dataArray[indexPath.row];
            NSString *description = [NSString stringWithFormat:@"%@",dict[@"description"]];
            NSString *price = [NSString stringWithFormat:@"%@",dict[@"price"]];
            NSString *name = [NSString stringWithFormat:@"%@",dict[@"name"]];
            
            
            CGSize sizePrice = [price sizeWithFont:[UIFont systemFontOfSize:27.0] maxSize:CGSizeMake(990, 100)];
            CGSize sizeName = [name sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(990, 100)];
            NSInteger count = 1;
            if (sizeName.width >= 990) {
                sizeName.height = sizeName.height * 0.5;
            }
            for (NSInteger i = 0; sizeName.width >= 632 * scaleWidth; i++) {
                count++;
                sizeName.width -= 632 * scaleWidth;
            }
            
            
            
            CGSize size = [description sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(990, 100)];
            NSInteger detailCount = 1;
            if (size.width >= 990) {
                size.height = size.height * 0.5;
            }
            for (NSInteger i = 0; size.width >= 632 * scaleWidth; i++) {
                detailCount++;
                size.width -= 632 * scaleWidth;
            }
            
            return size.height * detailCount + sizePrice.height + sizeName.height * count + 220 * scaleHeight;
            
        }
        return 0;
        
    }
    else {
        
        return 580 * scaleHeight;
        
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([_JLstate isEqualToString:@"3"] == YES) {
        
        return [_publishArray count];
    }
    else {
        
        return [_waitConfirmDataArray count];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //待确认
    if (_waitConfirm.selected) {
        NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
        if ([[ud objectForKey:UserCategory]isEqualToString:@"消费者"] == YES) {
            consumerOrderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell4"];
            if (!cell) {
                cell = [[consumerOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell4"];
            }
            cell.model = _waitConfirmDataArray[indexPath.row];
            [cell certainButtonClick:^(UIButton *btn) {
                [self ConsumercazuoOrder:indexPath.row];
            }];
            cell.backgroundColor =  BaseColor(245, 245, 245, 1);
            //tableViewCell每点击一次之后取消其点击颜色
            cell.selectionStyle =  UITableViewCellSelectionStyleNone;//（一般最好设置一下）
            return cell;
            
        }else{
            MyOrderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell = [[MyOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
            cell.model = _waitConfirmDataArray[indexPath.row];
            [cell certainButtonClick:^(UIButton *btn) {
                [self caozuoOrder:indexPath.row];
            }];
            cell.backgroundColor =  BaseColor(245, 245, 245, 1);
            //tableViewCell每点击一次之后取消其点击颜色
            cell.selectionStyle =  UITableViewCellSelectionStyleNone;//（一般最好设置一下）
            return cell;
        }
    }
    //已确认
    if (_hasBeenConfirm.selected) {
        MyOrderCertainTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (!cell) {
            cell = [[MyOrderCertainTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
        }
        cell.model = _waitConfirmDataArray[indexPath.row];
//        [cell certainButtonClick:^(UIButton *btn) {
//            [self caozuoOrder:indexPath.row];
//        }];
        cell.backgroundColor =  BaseColor(245, 245, 245, 1);
        //tableViewCell每点击一次之后取消其点击颜色
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;//（一般最好设置一下）
        return cell;
    }
    //已取消
    if (_hasBeenCancle.selected) {
        MyOrderCancleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
        if (!cell) {
            cell = [[MyOrderCancleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell3"];
        }
        cell.model = _waitConfirmDataArray[indexPath.row];
//        [cell certainButtonClick:^(UIButton *btn) {
//            [self caozuoOrder:indexPath.row];
//        }];
        cell.backgroundColor =  BaseColor(245, 245, 245, 1);
        //tableViewCell每点击一次之后取消其点击颜色
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;//（一般最好设置一下）
        return cell;
    }
    
    
    //已发布  
    if (_hasBeenPublish.selected) {
        YiXiaJiaTableViewCell *cell = [[YiXiaJiaTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YiXiaJiaTableViewCell"];
        if (_publishArray.count) {
            NSDictionary *dict = _publishArray[indexPath.row];
            [cell configWithDictionary:dict withAll:YES];
        }
        cell.backgroundColor =  BaseColor(245, 245, 245, 1);
        //tableViewCell每点击一次之后取消其点击颜色
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;//（一般最好设置一下）
        return cell;
    }

    
    return nil;
}
#pragma mark  --消费者的操作订单被点击
- (void)ConsumercazuoOrder:(NSInteger)indexPathRow
{
    myOrderModel * model = _waitConfirmDataArray[indexPathRow];
    UIAlertController*alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    JQBaseRequest * jq = [[JQBaseRequest alloc]init];
    UIAlertAction * otherAction2 = [UIAlertAction  actionWithTitle:NSLocalizedString(@"确定取消订购", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
        NSDictionary * dict = @{@"OldStatus":model.status, @"NewStatus":@"2", @"ProducerId":model.producerid, @"ConsumerId":model.consumerid};
        [jq PUTrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Order/Status/%@", model.orderID] para:dict complete:^(NSDictionary *responseObject) {
            [_waitConfirmDataArray removeObjectAtIndex:indexPathRow];
            [_tableView reloadData];
            [self selectEveryOrderNumber];
        } fail:^(NSError *error, NSString *errorString) {
           
            NSLog(@"asdasdas%@", error);
            
        }];
        
    }];
    UIAlertAction * otherAction3 = [UIAlertAction  actionWithTitle:NSLocalizedString(@"取消" , @"") style:UIAlertActionStyleCancel handler:^(UIAlertAction*action) {
        
        
    }];
    [alertController addAction:otherAction2];
    [alertController addAction:otherAction3];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark  --操作订单被点击(农场主)
- (void)caozuoOrder:(NSInteger)indexPathRow
{
    myOrderModel * model = _waitConfirmDataArray[indexPathRow];
    UIAlertController*alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    JQBaseRequest * jq = [[JQBaseRequest alloc]init];
    UIAlertAction * otherAction1 = [UIAlertAction  actionWithTitle:NSLocalizedString(@"确定接收订单", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
        NSDictionary * dict = @{@"OldStatus":model.status, @"NewStatus":@"1", @"ProducerId":model.producerid, @"ConsumerId":model.consumerid};
        [jq PUTrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Order/Status/%@", model.orderID] para:dict complete:^(NSDictionary *responseObject) {
            [_waitConfirmDataArray removeObjectAtIndex:indexPathRow];
            [_tableView reloadData];
            [self selectEveryOrderNumber];
        } fail:^(NSError *error, NSString *errorString) {
            
            NSLog(@"qewqweqweqw%@", error);
            
        }];
    }];
    UIAlertAction * otherAction2 = [UIAlertAction  actionWithTitle:NSLocalizedString(@"确定取消订购", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
        NSDictionary * dict = @{@"OldStatus":model.status, @"NewStatus":@"2", @"ProducerId":model.producerid, @"ConsumerId":model.consumerid};
        [jq PUTrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Order/Status/%@", model.orderID] para:dict complete:^(NSDictionary *responseObject) {
            [_waitConfirmDataArray removeObjectAtIndex:indexPathRow];
            [_tableView reloadData];
            [self selectEveryOrderNumber];
        } fail:^(NSError *error, NSString *errorString) {
            
            NSLog(@"qweqweqw%@", error);
            
            
        }];
        
    }];
    UIAlertAction * otherAction3 = [UIAlertAction  actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction*action) {
        
        
    }];
    [alertController addAction:otherAction1];
    [alertController addAction:otherAction2];
    [alertController addAction:otherAction3];
    [self presentViewController:alertController animated:YES completion:nil];
}
//创建返回按钮
- (void)createBackLeftButton {
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [button setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(leftBackButtonClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)leftBackButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}
//创建三个button 无需自定义只需调节一下button中的imageEdgeInsets 以及title
- (void)createButton {
    _waitConfirm = [[MyConfirmBaseButton alloc]init];
    _hasBeenCancle = [[MyConfirmBaseButton alloc]init];
    _hasBeenConfirm = [[MyConfirmBaseButton alloc]init];
    _hasBeenPublish = [[MyConfirmBaseButton alloc]init];
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 96 * scaleHeight)];
    [self.view addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    [view addSubview:_waitConfirm];
    [view addSubview:_hasBeenCancle];
    [view addSubview:_hasBeenConfirm];
    [view addSubview:_hasBeenPublish];
    
    
    view.tag  = 666;
    _lowLineView = [[UIView alloc]init];
    _lowLineView.backgroundColor = BaseColor(9, 142, 43, 1);
    [view addSubview:_lowLineView];
    
    
    //待确认
    [_waitConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(32 * scaleWidth);
        make.right.mas_equalTo(_hasBeenConfirm.mas_left).offset(-32 * scaleWidth);
        make.width.mas_equalTo(140 * scaleWidth);
    }];
    
   //已确认
    [_hasBeenConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(_waitConfirm.mas_right).offset(32 * scaleWidth);
        make.right.mas_equalTo(_hasBeenCancle.mas_left).offset(-32 * scaleWidth);
        make.width.mas_equalTo(140 * scaleWidth);
    }];
    
    //已取消
    [_hasBeenCancle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(_hasBeenConfirm.mas_right).offset(32 * scaleWidth);
        make.right.mas_equalTo(_hasBeenPublish.mas_left).offset(-32 * scaleWidth);
        make.width.mas_equalTo(140 * scaleWidth);
    }];
    
    //已发布
    [_hasBeenPublish mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(_hasBeenCancle.mas_right).offset(32 * scaleWidth);
        make.right.mas_equalTo(-32 * scaleWidth);
        make.width.mas_equalTo(140 * scaleWidth);
    }];
    
    [_waitConfirm setTitle:[NSString stringWithFormat:@"%@(%@)",NSLocalizedString(@"待确认", @""),@"0"] forState:UIControlStateNormal];
    
    [_hasBeenConfirm setTitle:[NSString stringWithFormat:@"%@(%@)", NSLocalizedString(@"已确认", @""), @"0"] forState:UIControlStateNormal];
    
    [_hasBeenCancle setTitle:[NSString stringWithFormat:@"%@(%@)",NSLocalizedString(@"已取消", @""),@"0"] forState:UIControlStateNormal];
    
    [_hasBeenPublish setTitle:[NSString stringWithFormat:@"%@(%@)",NSLocalizedString(@"已发布", @""),@"0"] forState:UIControlStateNormal];
    
    [_waitConfirm setTitle:[NSString stringWithFormat:@"%@(%@)",NSLocalizedString(@"待确认", @""),@"0"] forState:UIControlStateSelected];
    
    [_hasBeenConfirm setTitle:[NSString stringWithFormat:@"%@(%@)", NSLocalizedString(@"已确认", @""), @"0"] forState:UIControlStateSelected];
    
    [_hasBeenCancle setTitle:[NSString stringWithFormat:@"%@(%@)",NSLocalizedString(@"已取消", @""),@"0"] forState:UIControlStateSelected];
    
    [_hasBeenPublish setTitle:[NSString stringWithFormat:@"%@(%@)",NSLocalizedString(@"已发布", @""),@"0"] forState:UIControlStateSelected];
    
    _waitConfirm.titleLabel.font = [UIFont systemFontOfSize:12];
    _hasBeenConfirm.titleLabel.font = [UIFont systemFontOfSize:12];
    _hasBeenCancle.titleLabel.font = [UIFont systemFontOfSize:12];
    _hasBeenPublish.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [_waitConfirm addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_hasBeenConfirm addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_hasBeenCancle addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_hasBeenPublish addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _waitConfirm.selected  =YES;
    if (_waitConfirm.selected) {
        [_lowLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_waitConfirm.mas_left);
            make.right.mas_equalTo(_waitConfirm.mas_right);
            make.bottom.mas_equalTo(_waitConfirm.mas_bottom);
            make.height.mas_equalTo(3 * scaleHeight);
        }];
    }
    
}

#pragma mark  button的点击事件
- (void)buttonClick:(MyConfirmBaseButton *)button {
    
    [_view removeFromSuperview];
    [lb removeFromSuperview];
    [self createTableView];
    if (button == _waitConfirm) {
        _waitConfirm.selected  =YES;
        _hasBeenCancle.selected  =NO;
        _hasBeenConfirm.selected = NO;
        _hasBeenPublish.selected = NO;
         _JLstate = @"0";
    }
    if (button == _hasBeenCancle) {
        _waitConfirm.selected  =NO;
        _hasBeenCancle.selected  =YES;
        _hasBeenConfirm.selected = NO;
        _hasBeenPublish.selected = NO;
         _JLstate = @"2";
    }
    if (button == _hasBeenConfirm) {
        _waitConfirm.selected  = NO;
        _hasBeenCancle.selected  = NO;
        _hasBeenConfirm.selected = YES;
        _hasBeenPublish.selected = NO;
         _JLstate = @"1";
    }
    if (button == _hasBeenPublish) {
        _waitConfirm.selected  = NO;
        _hasBeenCancle.selected  = NO;
        _hasBeenConfirm.selected = NO;
        _hasBeenPublish.selected = YES;
        _JLstate = @"3";
        
        
    }
    [self panduanDixian];
    [self waitCertainOrderRequest];
}

#pragma mark  --判断button的底线在哪一个位置
- (void)panduanDixian
{
    UIView * view = (id)[self.view viewWithTag:666];
    // 告诉self.view约束需要更新
    [view setNeedsUpdateConstraints];
    // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
    [view updateConstraintsIfNeeded];
    if (_waitConfirm.selected) {
        [_lowLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_waitConfirm.mas_left);
            make.right.mas_equalTo(_waitConfirm.mas_right);
            make.bottom.mas_equalTo(_waitConfirm.mas_bottom);
            make.height.mas_equalTo(3 * scaleHeight);
        }];
    }
    if (_hasBeenCancle.selected) {
        [_lowLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_hasBeenCancle.mas_left);
            make.right.mas_equalTo(_hasBeenCancle.mas_right);
            make.bottom.mas_equalTo(_hasBeenCancle.mas_bottom);
            make.height.mas_equalTo(3 * scaleHeight);
        }];
    }
    if (_hasBeenConfirm.selected) {
        [_lowLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_hasBeenConfirm.mas_left);
            make.right.mas_equalTo(_hasBeenConfirm.mas_right);
            make.bottom.mas_equalTo(_hasBeenConfirm.mas_bottom);
            make.height.mas_equalTo(3 * scaleHeight);
        }];
    }
    if (_hasBeenPublish.selected) {
        [_lowLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_hasBeenPublish.mas_left);
            make.right.mas_equalTo(_hasBeenPublish.mas_right);
            make.bottom.mas_equalTo(_hasBeenPublish.mas_bottom);
            make.height.mas_equalTo(3 * scaleHeight);
        }];
    }

}

- (void)dealloc {
    [_header free];
    [_footer free];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)kong{
    
    _view = [[UIImageView alloc]initWithFrame:CGRectMake((Screen_Width - 194 * scaleWidth) / 2.0, 350 * scaleHeight, 194 * scaleWidth, 100 * scaleHeight)];
    _view.image = [UIImage imageNamed:@"icon_no.png"];
    _view.userInteractionEnabled = YES;
    [_tableView addSubview:_view];
    
    lb = [[UILabel alloc]init];
    [_tableView addSubview:lb];
    lb.text = NSLocalizedString(@"亲，您暂时没有任何订单！", @"");
    lb.textAlignment = NSTextAlignmentCenter;
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_view.mas_bottom).offset(60 * scaleHeight);
        make.centerX.mas_equalTo(_tableView.mas_centerX);
        make.height.mas_equalTo(60);
    }];
    BaseLableSet(lb, 52, 52, 52, 28);
}

@end
