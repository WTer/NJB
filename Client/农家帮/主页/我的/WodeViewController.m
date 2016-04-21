//
//  WodeViewController.m
//  农帮乐
//
//  Created by hpz on 15/12/2.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "WodeViewController.h"
#import "wodeButton.h"
#import "Masonry.h"
#import "WodeTableViewCell.h"
#import "MJRefresh.h"
#import "WodeSetViewController.h"
#import "WodeOrderViewController.h"
#import "WodeCollectionViewController.h"
#import "WodeCommentViewController.h"
#import "WodeMessageViewController.h"
#import "AlsoExpressMessageViewController.h"
#import "AddressBookViewController.h"
#import "MyConfirmBookViewController.h"
#import "QianZaiXiaoFeiZheViewController.h"
#import "ShiMingViewController.h"
#import "WuLiuXinXiViewController.h"
#import "PiPeiMaiJiaViewController.h"
#import "QiuGouViewController.h"
#import "YiXiaJiaShangPinViewController.h"
#import "WoFaChuDeYaoQingViewController.h"
#import "WoFaBuDeShangPinViewController.h"
#import "GuanLiYouHuiQuanViewController.h"
#import "WoGuanZhuDeMaiJiaViewController.h"
#import "HongBaoViewController.h"
#import "WoDeHongBaoViewController.h"
#import "YongHuRenZhengViewController.h"
#import "GuanZhuFenSiViewController.h"
#import "GuanZhuFenSiBtn.h"
#import "ConsumerZhengShuViewController.h"
#import "XiaoFeiZheHongBaoViewController.h"
@interface WodeViewController ()<UITableViewDataSource, UITableViewDelegate, MJRefreshBaseViewDelegate>

@end

@implementation WodeViewController
{
    UIView * _baseView;
    UILabel * _userNamelable;//用户名字的lable
    UIImageView * headerImageView;//用户的头像
    wodeButton * _wodeOrder;
    wodeButton * _wodecollect;
    wodeButton * _wodeComment;
    UITableView * _tableView;
    NSArray * _dataArray;
    NSArray * _imageNameArray;
    MJRefreshHeaderView * _refreshHeaderView;
    
    GuanZhuFenSiBtn *_guanzhufensi;
    
    
    NSString *_guanzhushu;
    NSString *_fensishu;
}

#pragma mark  显示三个button的数量
- (void)requestThreeButtonMessage
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    JQBaseRequest * jq = [[JQBaseRequest alloc]init];
    if ([[ud objectForKey:UserCategory] isEqualToString:@"消费者"] == NO) {
        [jq GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Favorite/Producer/%@/Count/", [ud objectForKey:UserID]] para:nil complete:^(NSDictionary *responseObject) {
            _wodecollect.numberText = responseObject[@"totalCount"];
            [jq GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Order/Producer/%@/Count/", [ud objectForKey:UserID]] para:nil complete:^(NSDictionary *responseObject) {
                _wodeOrder.numberText = responseObject[@"totalCount"];
                [_refreshHeaderView endRefreshing];
            } fail:^(NSError *error, NSString *errorString) {
                NSLog(@"%@" ,error);
            }];
        } fail:^(NSError *error, NSString *errorString) {
            NSLog(@"%@" ,error);
        }];
        
    }else{
        [jq GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Favorite/Consumer/%@/Count/", [ud objectForKey:UserID]] para:nil complete:^(NSDictionary *responseObject) {
            _wodecollect.numberText = responseObject[@"totalCount"];
            [jq GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/Order/Consumer/%@/Count/", [ud objectForKey:UserID]] para:nil complete:^(NSDictionary *responseObject) {
                _wodeOrder.numberText = responseObject[@"totalCount"];
                [_refreshHeaderView endRefreshing];
            } fail:^(NSError *error, NSString *errorString) {
                NSLog(@"%@" ,error);
            }];
        } fail:^(NSError *error, NSString *errorString) {
            NSLog(@"%@" ,error);
        }];
        
    }
    [jq GETrequestWitUrlString:[NSString stringWithFormat:@"http://182.92.224.165/ProductComment/%@/Count/", [ud objectForKey:UserID]] para:nil complete:^(NSDictionary *responseObject) {
        _wodeComment.numberText = responseObject[@"totalCount"];
        [_refreshHeaderView endRefreshing];
    } fail:^(NSError *error, NSString *errorString) {
        NSLog(@"%@" ,error);
    }];

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //将导航条设置为不透明的
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = BaseColor(245, 245, 245, 1);
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    NSString * str = [ud objectForKey:UserCategory];

    if ([str isEqualToString:@"消费者"] == YES) {
        _dataArray = @[NSLocalizedString(@"我的信息", @""),
                       NSLocalizedString(@"常用快递信息", @""),
                       NSLocalizedString(@"通讯录联系人", @""),
                       NSLocalizedString(@"我匹配的卖家", @""),
                       NSLocalizedString(@"我的求购信息", @""),
                       NSLocalizedString(@"我关注的卖家", @""),
                       @"我的证书",
                       NSLocalizedString(@"我的优惠券", @""),
                       NSLocalizedString(@"我的红包", @""),
                       NSLocalizedString(@"用户认证", @"")];
        _imageNameArray = @[@"grzx_icon_01",
                            @"grzx_icon_02",
                            @"grzx_icon_03",
                            @"grzx_icon_04",
                            @"grzx_icon_01",
                            @"grzx_icon_01",
                            @"grzx_icon_01",
                            @"grzx_icon_05",
                            @"grzx_icon_06",
                            @"grzx_icon_07"];
    }else{
        _dataArray = @[NSLocalizedString(@"我的信息", @""),
                       NSLocalizedString(@"常用快递信息", @""),
                       NSLocalizedString(@"通讯录联系人", @""),
                       NSLocalizedString(@"我的证书", @""),
                       NSLocalizedString(@"潜在消费者", @""),
                       NSLocalizedString(@"我发出的邀请", @""),
                       NSLocalizedString(@"我的物流信息", @""),
                       NSLocalizedString(@"已下架的商品", @""),
                       NSLocalizedString(@"我发布的商品", @""),
                       NSLocalizedString(@"我的优惠券", @""),
                       NSLocalizedString(@"我关注的卖家", @""),
                       NSLocalizedString(@"我的红包", @""),
                       NSLocalizedString(@"用户认证", @"")];
        _imageNameArray = @[@"grzx_icon_01",
                            @"grzx_icon_02",
                            @"grzx_icon_03",
                            @"grzx_icon_04",
                            @"grzx_icon_01",
                            @"grzx_icon_01",
                            @"grzx_icon_01",
                            @"grzx_icon_01",
                            @"grzx_icon_01",
                            @"grzx_icon_05",
                            @"grzx_icon_01",
                            @"grzx_icon_06",
                            @"grzx_icon_07"];
    }
    
    
//    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height - 113)];
//    view.backgroundColor = BaseColor(245, 245, 245, 1);
//    view.backgroundColor = [UIColor redColor];
//    [self.view addSubview:view];
    self.title = NSLocalizedString(@"Personal center", @"");
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"SETTING", @"") style:UIBarButtonItemStylePlain target:self action:@selector(setting)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"实名认证", @"") style:UIBarButtonItemStylePlain target:self action:@selector(shiMing)];

    [self getGuanZhuAndFenSi];
    [self createFirstSection];//创建tableView的头视图
    [self createWode];//创建我的三个按钮
    [self createTableVIew];//创建tableView
    [self getUserInfo];
    [self setExtraCellLineHidden:_tableView];//将多余的cell隐藏
    [self requestThreeButtonMessage];
    
}
- (void) getGuanZhuAndFenSi {

    JQBaseRequest * JQResquest = [[JQBaseRequest alloc]init];
    
    //先判断网络状态,没网络时可以先从缓存的内容里面读取
    [[JudgeNetState shareInstance]monitorNetworkType:self.view complete:^(NSInteger state) {
        if (state == 1 || state == 2) {
            
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            if ([ud boolForKey:@"IsConsumer"]) {
                
                [JQResquest ChaXunMaiJia3GuanZhuAndFenSiZongShuWithConsumerId:[NSString stringWithFormat:@"%@",[ud objectForKey:@"ConsumerId"]] complete:^(NSDictionary *responseObject) {
                    
                    _guanzhushu = [NSString stringWithFormat:@"%@",responseObject[@"FollowCount"]];
                    _fensishu = [NSString stringWithFormat:@"%@",responseObject[@"FansCount"]];
                
                    [_guanzhufensi setTitle:[NSString stringWithFormat:@"关注 %@  粉丝 %@",_guanzhushu,_fensishu] forState:UIControlStateNormal];
                    
                } fail:^(NSError *error, NSString *errorString) {
                    
                    UIAlertController*alertController = [UIAlertController alertControllerWithTitle:@"提示" message:errorString preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                        
                    }];
                    
                    [alertController addAction:otherAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                    
                }];
                
                
            }
            else {
                
                [JQResquest ChaXunMaiJia4GuanZhuAndFenSiZongShuWithProducerId:[NSString stringWithFormat:@"%@",[ud objectForKey:@"ProducerId"]] complete:^(NSDictionary *responseObject) {
                    
                    _guanzhushu = [NSString stringWithFormat:@"%@",responseObject[@"FollowCount"]];
                    _fensishu = [NSString stringWithFormat:@"%@",responseObject[@"FansCount"]];
                    
                    [_guanzhufensi setTitle:[NSString stringWithFormat:@"关注 %@  粉丝 %@",_guanzhushu,_fensishu] forState:UIControlStateNormal];
                    
                } fail:^(NSError *error, NSString *errorString) {
                    
                    UIAlertController*alertController = [UIAlertController alertControllerWithTitle:@"提示" message:errorString preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                        
                    }];
                    
                    [alertController addAction:otherAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                }];
                
            }
            
        }
        if (state == 3) {
            
            
        }
    }];


}
- (void)shiMing {
    
    ShiMingViewController *svc = [[ShiMingViewController alloc] init];
    
    [self.navigationController pushViewController:svc animated:YES];
}

#pragma mark  获取用户的登录的图片用户 名称
- (void)getUserInfo {
    
    NSDictionary * dict = [NSDictionary dictionaryWithContentsOfFile:UserMessageLocalAdress];
    if (!dict.count) {
        NSUserDefaults  * ud = [NSUserDefaults standardUserDefaults];
        JQBaseRequest * jq = [[JQBaseRequest alloc]init];
        if ([[ud objectForKey:UserCategory] isEqualToString:@"消费者"] == YES) {
            [jq ConsumerSelectedBaseMessageWithConsumerID:[ud objectForKey:UserID] complete:^(NSDictionary *responseObject) {
                
                [responseObject writeToFile:UserMessageLocalAdress atomically:YES];
                _userNamelable.text = responseObject[@"displayname"];
                [headerImageView sd_setImageWithURL:[NSURL URLWithString:responseObject[@"bigportraiturl"]] placeholderImage:[UIImage imageNamed:@"grzx_btn_touxiang.png"]];
                
                
                
                
                
            } fail:^(NSError *error, NSString *errorString) {
                
            }];
        }
        else{
            [jq FarmerOwnerSelectedBaseMessageWithProducerID:[ud objectForKey:UserID] complete:^(NSDictionary *responseObject) {
                
                [responseObject writeToFile:UserMessageLocalAdress atomically:YES];
                _userNamelable.text = responseObject[@"displayname"];
                [headerImageView sd_setImageWithURL:[NSURL URLWithString:responseObject[@"bigportraiturl"]] placeholderImage:[UIImage imageNamed:@"grzx_btn_touxiang.png"]];
                
                [ud setObject:[NSString stringWithFormat:@"%@",responseObject[@"bigportraiturl"]] forKey:@"ProducerURL"];
                [ud synchronize];
                
            } fail:^(NSError *error, NSString *errorString) {
                
            }];
        }
    }
    else{
        _userNamelable.text = dict[@"displayname"];
        [headerImageView sd_setImageWithURL:[NSURL URLWithString:dict[@"bigportraiturl"]] placeholderImage:[UIImage imageNamed:@"grzx_btn_touxiang.png"]];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self getUserInfo];
    [self requestThreeButtonMessage];
}

#pragma mark  --右边设置按钮
- (void)setting {
    
    WodeSetViewController * wvc = [[WodeSetViewController alloc]init];
    [self.navigationController pushViewController:wvc animated:YES];
}

//分两个部分创建，一个是tableView 的头试图  一个是tableView
//创建点击登录以及设置
- (void)createFirstSection {
    
    _baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 580 * scaleHeight)];
    _baseView.backgroundColor = [UIColor whiteColor];
    UIView * firstView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, scaleHeight * 400)];
    firstView.layer.contents = (id)[[UIImage imageNamed:@"grzx_bg.png"]CGImage];
    [_baseView addSubview:firstView];
    
    headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(50 * scaleWidth, 130 * scaleHeight, scaleWidth * 150, scaleWidth * 150)];
    headerImageView.layer.contents = (id)[[UIImage imageNamed:@"grzx_btn_touxiang.png"]CGImage];
    headerImageView.layer.cornerRadius = scaleWidth * 75;
    headerImageView.layer.masksToBounds = YES;
    [firstView addSubview:headerImageView];
    
    _userNamelable = [[UILabel alloc]initWithFrame:CGRectMake(230 * scaleWidth, 146 * scaleHeight, 300 * scaleWidth, 50 * scaleHeight)];
    _userNamelable.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    _userNamelable.text = NSLocalizedString(@"点击登录", @"");
    _userNamelable.font = [UIFont systemFontOfSize:27];
    _userNamelable.adjustsFontSizeToFitWidth = YES;
    [firstView addSubview:_userNamelable];
    
    UIImageView *renzhengImageView = [[UIImageView alloc]initWithFrame:CGRectMake(530 * scaleWidth, 146 * scaleHeight, scaleWidth * 50, 50 * scaleHeight)];
    renzhengImageView.image = [UIImage imageNamed:@"V标_icon.png"];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([ud boolForKey:@"IsRenZheng"]) {
        renzhengImageView.image = [UIImage imageNamed:@"V标_icon.png"];
    }
    [firstView addSubview:renzhengImageView];
    
    //关注和粉丝
    _guanzhufensi = [[GuanZhuFenSiBtn alloc]initWithFrame:CGRectMake(230 * scaleWidth, 206 * scaleHeight, 400 * scaleWidth, 50 * scaleHeight)];
    [_guanzhufensi setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _guanzhufensi.titleLabel.font = [UIFont systemFontOfSize:16.0];
    _guanzhufensi.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_guanzhufensi addTarget:self action:@selector(guanzhufensi) forControlEvents:UIControlEventTouchUpInside];
    [firstView addSubview:_guanzhufensi];
    
    
    UIView * vw = [[UIView alloc]initWithFrame:CGRectMake(0, 560 * scaleHeight, Screen_Width, 20 * scaleHeight)];
    vw.backgroundColor  =  BaseColor(245, 245, 245, 1);
    [_baseView addSubview:vw];
}
- (void)guanzhufensi {
    
    GuanZhuFenSiViewController *guanzhufensiVC = [[GuanZhuFenSiViewController alloc] init];
    [self.navigationController pushViewController:guanzhufensiVC animated:YES];


}
//创建我的按钮
- (void)createWode {
    
    _wodeOrder = [[wodeButton alloc]init];
    _wodecollect = [[wodeButton alloc]init];
    _wodeComment = [[wodeButton alloc]init];
    [_baseView addSubview:_wodeOrder];
    [_baseView addSubview:_wodecollect];
    [_baseView addSubview:_wodeComment];
    //这样做是为了避免block中的循环引用
    float p = [[UIScreen mainScreen] bounds].size.width / 3.0;
    __weak WodeViewController * weekSelf = self;
    [_wodeOrder setNumber:@"0" Name:NSLocalizedString(@"我的订单", @"") Frame:CGRectMake(0, scaleHeight * 400, p,scaleHeight * 160) Action:^(UIButton *button) {
        WodeOrderViewController * wvc = [[WodeOrderViewController alloc]init];
        [weekSelf.navigationController pushViewController:wvc animated:YES];
        
    }];
    [_wodecollect setNumber:@"0" Name:NSLocalizedString(@"我的收藏", @"") Frame:CGRectMake(p, scaleHeight * 400, p,scaleHeight * 160) Action:^(UIButton *button) {
        WodeCollectionViewController * wvc = [[WodeCollectionViewController alloc]init];
        [weekSelf.navigationController pushViewController:wvc animated:YES];
        
    }];
    [_wodeComment setNumber:@"0" Name:NSLocalizedString(@"我的评论", @"") Frame:CGRectMake(p * 2, scaleHeight * 400, p,scaleHeight * 160) Action:^(UIButton *button) {
        WodeCommentViewController * wvc = [[WodeCommentViewController alloc]init];
        [weekSelf.navigationController pushViewController:wvc animated:YES];
        
    }];
    
    //创建两个竖线
    UILabel * lable1 = [[UILabel alloc]init];
    lable1.backgroundColor = BaseColor(52, 52, 52, 0.1);
    [_baseView addSubview:lable1];
    [lable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(scaleHeight * 110);
        make.left.mas_equalTo(p);
        make.width.mas_equalTo(0.8);
        make.bottom.mas_equalTo(_wodeOrder.mas_bottom).offset(-scaleHeight * 40);
    }];
    
    UILabel * lable2 = [[UILabel alloc]init];
    lable2.backgroundColor = BaseColor(52, 52, 52, 0.1);
    [_baseView addSubview:lable2];
    [lable2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(scaleHeight * 110);
        make.left.mas_equalTo(2 * p);
        make.width.mas_equalTo(0.8);
        make.bottom.mas_equalTo(_wodeOrder.mas_bottom).offset(-scaleHeight * 40);
    }];
    
}

//创建tableview 同时需要关联头视图
-  (void)createTableVIew {
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height - 113) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource  =self;
    _tableView.delegate = self;
    [_tableView registerClass:[WodeTableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableView.tableHeaderView = _baseView;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.backgroundColor =BaseColor(245, 245, 245, 1);
    
    _tableView.rowHeight = scaleHeight * 86;
    
    
//    解决tableView分割线左边不到边的情况
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    //_refreshHeaderView = [MJRefreshHeaderView header];
    //_refreshHeaderView.delegate = self;
    //_refreshHeaderView.scrollView = _tableView;
}

#pragma mark ---刷新的代理方法
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView {
    
    [self requestThreeButtonMessage];
}

#pragma mark --隐藏多余的cell
-(void)setExtraCellLineHidden: (UITableView *)tableView {
    
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_dataArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WodeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.detail = _dataArray[indexPath.row];
    cell.imageName = _imageNameArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, scaleHeight * 86 - 1, Screen_Width, 1)];
    line.backgroundColor = BaseColor(233, 233, 233, 1);
    [cell addSubview:line];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        WodeMessageViewController * wvc = [[WodeMessageViewController alloc]init];
        [self.navigationController pushViewController:wvc animated:YES];
        
    }
    if (indexPath.row == 1) {
        
        AlsoExpressMessageViewController * avc = [[AlsoExpressMessageViewController alloc]init];
        [self.navigationController pushViewController:avc animated:YES];
        
    }
    if (indexPath.row == 2) {
        
        AddressBookViewController * avc = [[AddressBookViewController alloc]init];
        [self.navigationController pushViewController:avc animated:YES];
        
    }
    if (indexPath.row == 3) {
        NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
        NSString * str = [ud objectForKey:UserCategory];
       
        if ([str isEqualToString:@"消费者"] == YES) {
            PiPeiMaiJiaViewController *pvc = [[PiPeiMaiJiaViewController alloc] init];
            [self.navigationController pushViewController:pvc animated:YES];
        } else {
            MyConfirmBookViewController * mvc = [[MyConfirmBookViewController alloc]init];
            [self.navigationController pushViewController:mvc animated:YES];            
        }
    }
    if (indexPath.row == 4) {
        NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
        NSString * str = [ud objectForKey:UserCategory];
        
        if ([str isEqualToString:@"消费者"] == YES) {
            QiuGouViewController *qvc = [[QiuGouViewController alloc] init];
            [self.navigationController pushViewController:qvc animated:YES];
        } else {
            QianZaiXiaoFeiZheViewController *qvc = [[QianZaiXiaoFeiZheViewController alloc] init];
            [self.navigationController pushViewController:qvc animated:YES];
        }
    }
    if (indexPath.row == 5) {
        NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
        NSString * str = [ud objectForKey:UserCategory];
        
        if ([str isEqualToString:@"消费者"] == YES) {
            
            WoGuanZhuDeMaiJiaViewController *woguanzhudemaijiaVC = [[WoGuanZhuDeMaiJiaViewController alloc] init];
            [self.navigationController pushViewController:woguanzhudemaijiaVC animated:YES];
            
        } else {
            WoFaChuDeYaoQingViewController *yaoqingVC = [[WoFaChuDeYaoQingViewController alloc] init];
            [self.navigationController pushViewController:yaoqingVC animated:YES];
        }
    }

    if (indexPath.row == 6) {
        
        NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
        NSString * str = [ud objectForKey:UserCategory];
        
        if ([str isEqualToString:@"消费者"] == YES) {
            ConsumerZhengShuViewController *ConsumerZhengShuVC = [[ConsumerZhengShuViewController alloc] init];
            [self.navigationController pushViewController:ConsumerZhengShuVC animated:YES];
        }
        else {
            WuLiuXinXiViewController *wvc = [[WuLiuXinXiViewController alloc] init];
            [self.navigationController pushViewController:wvc animated:YES];
        }
    }
    if (indexPath.row == 7) {
        NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
        NSString * str = [ud objectForKey:UserCategory];
        
        if ([str isEqualToString:@"消费者"] == YES) {
            GuanLiYouHuiQuanViewController *guanliyouhuiquanVC = [[GuanLiYouHuiQuanViewController alloc] init];
            [self.navigationController pushViewController:guanliyouhuiquanVC animated:YES];

        }
        else {
            YiXiaJiaShangPinViewController *yixiajiashangpinVC = [[YiXiaJiaShangPinViewController alloc] init];
            [self.navigationController pushViewController:yixiajiashangpinVC animated:YES];
        }

    }
    if (indexPath.row == 8) {
        NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
        NSString * str = [ud objectForKey:UserCategory];
        
        if ([str isEqualToString:@"消费者"] == YES) {
            if ([[ud objectForKey:UserCategory] isEqualToString:@"消费者"] == NO) {
                HongBaoViewController *wodehonhbaoVC = [[HongBaoViewController alloc] init];
                [self.navigationController pushViewController:wodehonhbaoVC animated:YES];
            }else{
                XiaoFeiZheHongBaoViewController * xvc = [[XiaoFeiZheHongBaoViewController alloc]init];
                [self.navigationController pushViewController:xvc animated:YES];
            }
        }
        else {
            WoFaBuDeShangPinViewController *wofabushangpinVC = [[WoFaBuDeShangPinViewController alloc] init];
            [self.navigationController pushViewController:wofabushangpinVC animated:YES];
        }

    }
    if (indexPath.row == 9) {
        
        NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
        NSString * str = [ud objectForKey:UserCategory];
        if ([str isEqualToString:@"消费者"] == YES) {
            YongHuRenZhengViewController *yonghurenzhengVC = [[YongHuRenZhengViewController alloc] init];
            [self.navigationController pushViewController:yonghurenzhengVC animated:YES];
        }
        else {
        
            GuanLiYouHuiQuanViewController *guanliyouhuiquanVC = [[GuanLiYouHuiQuanViewController alloc] init];
            [self.navigationController pushViewController:guanliyouhuiquanVC animated:YES];
        }
    }
    if (indexPath.row == 10) {
        WoGuanZhuDeMaiJiaViewController *woguanzhudemaijiaVC = [[WoGuanZhuDeMaiJiaViewController alloc] init];
        [self.navigationController pushViewController:woguanzhudemaijiaVC animated:YES];
    }
    if (indexPath.row == 11) {
        NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
        if ([[ud objectForKey:UserCategory] isEqualToString:@"消费者"] == NO) {
            HongBaoViewController *wodehonhbaoVC = [[HongBaoViewController alloc] init];
            [self.navigationController pushViewController:wodehonhbaoVC animated:YES];
        }else{
            XiaoFeiZheHongBaoViewController * xvc = [[XiaoFeiZheHongBaoViewController alloc]init];
            [self.navigationController pushViewController:xvc animated:YES];
        }

    }
    if (indexPath.row == 12) {
        YongHuRenZhengViewController *yonghurenzhengVC = [[YongHuRenZhengViewController alloc] init];
        [self.navigationController pushViewController:yonghurenzhengVC animated:YES];
    }

}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    if (scrollView.contentOffset.y > 0) {
//        scrollView.contentOffset = CGPointMake(0, 0);
//    }
//}


//ios9 在使用刷新的时候切记释放
-(void)dealloc {
    
    [_refreshHeaderView free];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
