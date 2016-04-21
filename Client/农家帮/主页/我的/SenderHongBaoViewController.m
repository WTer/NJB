//
//  SenderHongBaoViewController.m
//  农家帮
//
//  Created by Mac on 16/4/6.
//  Copyright © 2016年 jingqi. All rights reserved.
//

#import "SenderHongBaoViewController.h"
#import "FaSongHongBaoCell.h"

@interface SenderHongBaoViewController ()<UITableViewDataSource,UITableViewDelegate, UISearchBarDelegate>

@end

@implementation SenderHongBaoViewController
{
    UISearchBar * _seachBar;
    UITableView * _tableView;
    NSMutableArray * _dataArrayOfconsumer;
    NSMutableArray * _dataArrayOfProducer;
    NSMutableArray * _dataArray;
    NSMutableArray * _dataArrayOfCell;
    NSInteger _JLDijige;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _JLDijige = 10000000;
    self.view.backgroundColor = BaseColor(245, 245, 245, 1);
    
    [self createUI];
    [self setExtraCellLineHidden:_tableView];
    [self requestList];
    
    // Do any additional setup after loading the view.
}

//请求关注的买家卖家列表
- (void)requestList
{
    
    _dataArray  =[[ NSMutableArray alloc]init];
    _dataArrayOfconsumer = [[NSMutableArray alloc]init];
    _dataArrayOfProducer = [[NSMutableArray alloc]init];
    _dataArrayOfCell = [[NSMutableArray alloc]init];
    
    
    [[JudgeNetState shareInstance] monitorNetworkType:self.view complete:^(NSInteger state) {
        
        if (state == 1 || state == 2) {
            
            JQBaseRequest * jq = [[JQBaseRequest alloc]init];
            NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
            [jq chaXun68ProducerId:[ud objectForKey:@"ProducerId"] complete:^(NSDictionary *responseObject) {
                for (NSDictionary * dict in responseObject[@"List"]) {
                    [_dataArray addObject:dict];
                    [_dataArrayOfconsumer addObject:dict];
                    [_tableView reloadData];
                }
            } fail:^(NSError *error, NSString *errorString) {
                
            }];
            
            
        }
    }];
}

#pragma mark  --隐藏多余的cell
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    _tableView.backgroundColor =BaseColor(245, 245, 245, 1);
}

- (void)createUI
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height - 93 * scaleHeight - 64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[FaSongHongBaoCell class] forCellReuseIdentifier:@"cell"];
    
    
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 44)];
    view.backgroundColor =  BaseColor(245, 245, 245, 1);
    view.tag = 666;
    
    
    _seachBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 44)];
    _seachBar.barStyle = UIBarStyleDefault;
    _seachBar.placeholder = @"搜索全部关注";
    _seachBar.delegate = self;
    [view addSubview:_seachBar];
    _tableView.tableHeaderView = view;
    [self createSenderButton];
    
}
- (void)createSenderButton
{
    UIButton * senderButton = [[UIButton alloc]initWithFrame:CGRectMake(0, Screen_Height - 88 * scaleHeight - 64, Screen_Width, 88 * scaleHeight)];
    [senderButton setBackgroundImage:[UIImage imageNamed:@"zjhh_btn_queding _down.png"] forState:UIControlStateNormal];
    [senderButton setTitleColor:BaseColor(255, 255, 255, 1) forState:UIControlStateNormal];
    [senderButton setTitle:@"发送" forState:UIControlStateNormal];
    [self.view addSubview:senderButton];
    [senderButton addTarget:self action:@selector(senderButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)senderButtonClick
{
    [[JudgeNetState shareInstance] monitorNetworkType:self.view complete:^(NSInteger state) {
        
        if (state == 1 || state == 2) {
            if (_JLDijige == 10000000) {
                UIAlertController*alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:@"请选择对象" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                    
                }];
                
                [alertController addAction:otherAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }else{
                JQBaseRequest * jq = [[JQBaseRequest alloc]init];
                [ jq FaFangPuTongDanGeHongBaoGeiMaiJia3POSTWithRedEnvelopeId:_hongbaoID ConsumerId:_dataArray[_JLDijige][@"Id"] complete:^(NSDictionary *responseObject) {
                    UIAlertController*alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:@"发送红包成功" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                        
                        [self.navigationController popViewControllerAnimated:YES];
                        
                    }];
                    
                    [alertController addAction:otherAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                    
                } fail:^(NSError *error, NSString *errorString) {
                    UIAlertController*alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:@"发送红包失败" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                        
                        [self.navigationController popViewControllerAnimated:YES];
                        
                    }];
                    
                    [alertController addAction:otherAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                }];

            }
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}


#pragma mark   ---代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FaSongHongBaoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [_dataArrayOfCell addObject:cell];
    cell.IsSelectedButton.selected = NO;
    [cell.headerImageView sd_setImageWithURL:_dataArray[indexPath.row][@"PortraitUrl"] placeholderImage:[UIImage imageNamed:@"1080X1800.png"]];
    cell.nameLable.text = _dataArray[indexPath.row][@"Name"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell senderButtonClick:^(UIButton *btn) {
        _JLDijige = indexPath.row;
    }];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70 * scaleHeight;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) searchByString:(NSString*)searchText{
    //    if (searchText.length<=0) {
    //
    //        return;
    //    }
    
    //搜索所有以searchText开头的字符串
    NSString * condition = [NSString stringWithFormat:@"%@*",searchText];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"self like[c] %@",condition];
    NSArray * result = [_dataArray filteredArrayUsingPredicate:predicate];
    
    //清空原来的搜索结果
    [_dataArray removeAllObjects];
    [_dataArray addObjectsFromArray:result];
    
}
#pragma mark ---seachBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"当点击键盘上search按钮时调用");
    
    [self searchByString:searchBar.text];
    [_tableView reloadData];
    [searchBar resignFirstResponder];
    if (_dataArray.count == 0) {
        UIAlertController*alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:@"无此关注" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }];
        
        [alertController addAction:otherAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
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
