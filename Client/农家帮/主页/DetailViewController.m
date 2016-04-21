//
//  DetailViewController.m
//  农帮乐
//
//  Created by hpz on 15/12/9.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "DetailViewController.h"
#import "PingLunTableViewCell.h"
#import "PriceTableViewCell.h"
#import "ChanPinTableViewCell.h"
#import "ShuLiangTableViewCell.h"
#import "DiZhiTableViewCell.h"
#import "FuWuTableViewCell.h"
#import "ShouhuoDizhiViewController.h"

@interface DetailViewController ()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, MJRefreshBaseViewDelegate>

@end

@implementation DetailViewController
{
    UIScrollView *_picScrollView;
    UIPageControl *_pc;
    //UITableView *_tableView;
    NSMutableArray *_dataArray;
    UIImageView *_huaDongImageView;
    NSString *_dizhi;
    
    NSMutableArray *_ConsigneeArray;
    JQBaseRequest *_JQRequest;
    NSString *_morenDizhi;
    BOOL _selectDiZhi;
    
    BOOL _IsFavorite;
    NSString *_FavoriteId;
    
    UIView *_bottomView;
    UIImageView *_bottomImageView;
    UITextField *_pinglunTF;
    
    MJRefreshHeaderView *_headerView;
    MJRefreshFooterView *_footerView;
    
    UIActivityIndicatorView *_indication;
    
    ShuLiangTableViewCell *_shuLiangCell;
    NSDictionary *_ConsigneeDict;
    
    BOOL _isPingLun;
    
    BOOL _isQuDiaoMoRen;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _IsFavorite = NO;
    _dataArray = [[NSMutableArray alloc] init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    
    self.title = self.ProductInfo[@"name"];
    
    //是否有默认地址
    _ConsigneeArray = [[NSMutableArray alloc] init];
    _JQRequest = [[JQBaseRequest alloc] init];
    
    [self createUI];
    [self RefreshUI];
    
    //把收货地址界面的详细地址传过来
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(chuanDiZhi:) name:@"tongzhi" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(qudiao) name:@"qudiaomorendizhi" object:nil];
    
    
}
- (void)qudiao {
    
    _isQuDiaoMoRen = YES;
    
}
- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    
    [self.view endEditing:YES];
    
    _tableView.alpha = 0.6;
    _tableView.userInteractionEnabled = NO;
    _indication = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _indication.frame = CGRectMake(Screen_Width / 2 - 40, Screen_Height / 2 - 104, 80, 80);
    _indication.backgroundColor = [UIColor blackColor];
    _indication.hidesWhenStopped = NO;
    [_indication startAnimating];
    [self.view addSubview:_indication];
    
    [[JudgeNetState shareInstance] monitorNetworkType:self.view complete:^(NSInteger state) {
        
        if (state == 1 || state == 2) {

            //如果有默认地址，就显示默认地址
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            [_JQRequest getShouHuoDiZhiListConsumerId:[NSString stringWithFormat:@"%@",[ud objectForKey:@"ConsumerId"]] Complete:^(NSDictionary *responseObject) {
                
                _ConsigneeArray = responseObject[@"List"];
                
                
                for (NSInteger i = 0; i < _ConsigneeArray.count; i++) {
                    NSDictionary *dict = _ConsigneeArray[i];
                    NSDictionary *ConsigneeDict = dict[@"Consignee"];
                    if ([ConsigneeDict[@"isdefault"] isEqualToString:@"true"] == YES) {
                        _morenDizhi = [NSString stringWithFormat:@"%@%@%@%@",ConsigneeDict[@"province"], ConsigneeDict[@"city"], ConsigneeDict[@"district"], ConsigneeDict[@"address"]];
                        _ConsigneeDict = ConsigneeDict;
                        _selectDiZhi = YES;
                       
                    }
                    
                }
                
                //从服务器上查询哪些商品是农场主或者消费者收藏的
                [self productByShoucang];
                
            } fail:^(NSError *error, NSString *errorString) {
                
                
                //从服务器上查询哪些商品是农场主或者消费者收藏的
                [self productByShoucang];
                
            }];
        }
    }];
    
}
- (void)dealloc {
    
    [_headerView free];
    [_footerView free];
    
}
//刷新
- (void)RefreshUI {
    
    [_headerView free];
    [_footerView free];
    _headerView = [MJRefreshHeaderView header];
    _headerView.scrollView = _tableView;
    _headerView.delegate  = self;
    
    _footerView = [MJRefreshFooterView footer];
    _footerView.scrollView = _tableView;
    _footerView.delegate  = self;
    
}
// 开始进入刷新状态就会调用
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView {
    
    if (refreshView == _headerView) {
        //回到最初的状态
        [self getCommentWithOffSet:@"0" Limit:@"5"];
    }
    if (refreshView == _footerView) {
        
        NSLog(@"qweqeqweq%@",[NSString stringWithFormat:@"%ld",(long)_dataArray.count]);
        if (_dataArray.count <= 5) {
            [self getCommentWithOffSet:@"0" Limit:@"5"];
        }
        else {
            [self getCommentWithOffSet:[NSString stringWithFormat:@"%ld",(long)_dataArray.count] Limit:@"5"];
        }
    }
}


- (void)productByShoucang {

    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    [[JudgeNetState shareInstance] monitorNetworkType:self.view complete:^(NSInteger state) {
        
        if (state == 1 || state == 2) {
            
            
            if ([ud boolForKey:@"IsConsumer"]) {
                
                //查询消费者商品收藏列表
                [_JQRequest ConsumerShouCangTotalProductWithConsumerId:[NSString stringWithFormat:@"%@",[ud objectForKey:@"ConsumerId"]] complete:^
                 (NSDictionary *responseObject) {
                     
                     //消费者收藏的商品
                     [_JQRequest GetConsumerShouCangProductWithConsumerId:[NSString stringWithFormat:@"%@",[ud objectForKey:@"ConsumerId"]] OffSet:@"0" limit:responseObject[@"totalCount"] complete:^(NSDictionary *responseObject) {
                         
                         NSLog(@"%@",responseObject);
                         
                         NSArray *shoucangListArray = responseObject[@"List"];
                         for (NSInteger i = 0; i < shoucangListArray.count; i++) {
                             NSDictionary *dict = shoucangListArray[i];
                             NSDictionary *FavoriteProductInfoDict = dict[@"FavoriteProductInfo"];
                             _FavoriteId = FavoriteProductInfoDict[@"id"];
                             NSLog(@"%@  %@",self.ProductInfo[@"id"], FavoriteProductInfoDict[@"productid"]);
                             if ([self.ProductInfo[@"id"] integerValue] == [FavoriteProductInfoDict[@"productid"] integerValue]) {
                                 
                                 _IsFavorite = YES;
                             }
                         }
                         //部分cell  reload
                         NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
                         [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                         NSIndexPath *indexPath=[NSIndexPath indexPathForRow:3 inSection:0];
                         [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                         
                         //收藏按钮
                         UIButton *shoucangBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 180 * scaleWidth, 97 * scaleHeight)];
                         [shoucangBtn setBackgroundImage:[UIImage imageNamed:@"cpxq_btn_shoucan_nor.png"] forState:UIControlStateNormal];
                         [shoucangBtn setBackgroundImage:[UIImage imageNamed:@"cpxq_btn_shoucang_sel.png"] forState:UIControlStateSelected];
                         [shoucangBtn addTarget:self action:@selector(shoucang:) forControlEvents:UIControlEventTouchUpInside];
                         shoucangBtn.selected = _IsFavorite;
                         [_bottomView addSubview:shoucangBtn];

                         //获得这个商品的所有评论
                         //最初得到5条评论
                         [self getCommentWithOffSet:@"0" Limit:@"5"];
                         
                     } fail:^(NSError *error, NSString *errorString) {
                         
                         NSLog(@"%@",errorString);
                     }];                    
                    
                } fail:^(NSError *error, NSString *errorString) {
                    NSLog(@"%@",errorString);
                }];
            }
            else {
                //农场主商品收藏总数查询
                
                [_JQRequest ProducerShouCangTotalProductWithProducerId:[NSString stringWithFormat:@"%@",[ud objectForKey:@"ProducerId"]] complete:^
                 (NSDictionary *responseObject) {
                     
                     //农场主收藏的商品
                     [_JQRequest GetProducerShouCangProductWithProducerId:[NSString stringWithFormat:@"%@",[ud objectForKey:@"ProducerId"]] OffSet:@"0" limit:responseObject[@"totalCount"] complete:^(NSDictionary *responseObject) {
                         
                         NSLog(@"%@",responseObject);
                         
                         NSArray *shoucangListArray = responseObject[@"List"];
                         for (NSInteger i = 0; i < shoucangListArray.count; i++) {
                             NSDictionary *dict = shoucangListArray[i];
                             NSDictionary *FavoriteProductInfoDict = dict[@"FavoriteProductInfo"];
                             _FavoriteId = FavoriteProductInfoDict[@"id"];
                             NSLog(@"%@  %@",self.ProductInfo[@"id"], FavoriteProductInfoDict[@"productid"]);
                             if ([self.ProductInfo[@"id"] integerValue] == [FavoriteProductInfoDict[@"productid"] integerValue]) {
                                 NSLog(@"dasdasdasdasda");
                                 _IsFavorite = YES;
                             }
                         }
                         
                         [_tableView reloadData];
                         
                         //收藏按钮
                         UIButton *shoucangBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 180 * scaleWidth, 97 * scaleHeight)];
                         [shoucangBtn setBackgroundImage:[UIImage imageNamed:@"cpxq_btn_shoucan_nor.png"] forState:UIControlStateNormal];
                         [shoucangBtn setBackgroundImage:[UIImage imageNamed:@"cpxq_btn_shoucang_sel.png"] forState:UIControlStateSelected];
                         [shoucangBtn addTarget:self action:@selector(shoucang:) forControlEvents:UIControlEventTouchUpInside];
                         shoucangBtn.selected = _IsFavorite;
                         [_bottomView addSubview:shoucangBtn];

                         //获得这个商品的所有评论
                         //最初得到5条评论
                         [self getCommentWithOffSet:@"0" Limit:@"5"];
                         
                     } fail:^(NSError *error, NSString *errorString) {
                         
                         _tableView.alpha = 1;
                         _tableView.userInteractionEnabled = YES;
                         [_indication removeFromSuperview];
                         
                     }];
                    
                } fail:^(NSError *error, NSString *errorString) {
                    NSLog(@"%@",errorString);
                }];
            }
            
        }
    }];
}



- (void)chuanDiZhi:(NSNotification *)noti {

   _ConsigneeDict = noti.object;
    _dizhi = [NSString stringWithFormat:@"%@%@%@%@",_ConsigneeDict[@"province"], _ConsigneeDict[@"city"], _ConsigneeDict[@"district"], _ConsigneeDict[@"address"]];
    NSLog(@"地址%@",_dizhi);
    _selectDiZhi = YES;
    
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:3 inSection:0];
    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    
}

- (void)getCommentWithOffSet:(NSString *)OffSet Limit:(NSString *)limit {

    [[JudgeNetState shareInstance] monitorNetworkType:self.view complete:^(NSInteger state) {
        
        if (state == 1 || state == 2) {
            
            //每次请求出不多于5条评论
            [_JQRequest GetProductCommentWithProductId:self.ProductInfo[@"id"] OffSet:OffSet limit:limit complete:^(NSDictionary *responseObject) {
                
                [_dataArray removeAllObjects];
                
                [_dataArray addObjectsFromArray:responseObject[@"List"]];
                
                
                NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
                [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                NSIndexPath *indexPath=[NSIndexPath indexPathForRow:3 inSection:0];
                [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                
                
                [_headerView endRefreshing];
                [_footerView endRefreshing];
                
                _tableView.alpha = 1;
                _tableView.userInteractionEnabled = YES;
                [_indication removeFromSuperview];
                
            } fail:^(NSError *error, NSString *errorString) {
                
                [_headerView endRefreshing];
                [_footerView endRefreshing];
                
                _tableView.alpha = 1;
                _tableView.userInteractionEnabled = YES;
                [_indication removeFromSuperview];
                
            }];

        }
        if (state == 3) {
            
            [_headerView endRefreshing];
            [_footerView endRefreshing];
            
        }
    }];
}

- (void)createUI {

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height - 64 - 97 * scaleHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 620 * scaleHeight)];
    _tableView.tableHeaderView = view;
    
    _picScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 620 * scaleHeight)];
    _picScrollView.contentSize = CGSizeMake(Screen_Width * (self.ProductImages.count + 2), 620 * scaleHeight);
    _picScrollView.pagingEnabled = YES;
    _picScrollView.bounces = NO;
    _picScrollView.delegate = self;
    _picScrollView.contentOffset = CGPointMake(Screen_Width, 0);
    _picScrollView.showsHorizontalScrollIndicator = NO;
    [view addSubview:_picScrollView];
    
    if (self.ProductImages.count) {
        
        NSDictionary *dict1 = self.ProductImages[self.ProductImages.count - 1];
        UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 620 * scaleHeight)];
        [imageView1 sd_setImageWithURL:dict1[@"bigportraiturl"] placeholderImage:[UIImage imageNamed:@""]];
        [_picScrollView addSubview:imageView1];
        for (NSInteger i = 1; i < self.ProductImages.count + 1; i++) {
            NSDictionary *imageDict = self.ProductImages[i - 1];
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(Screen_Width * i, 0, Screen_Width, 620 * scaleHeight)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageDict[@"bigportraiturl"]] placeholderImage:[UIImage imageNamed:@""]];
            [_picScrollView addSubview:imageView];
        }
        NSDictionary *dict2 = self.ProductImages[0];
        UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(Screen_Width * (self.ProductImages.count + 1), 0, Screen_Width, 620 * scaleHeight)];
        [imageView2 sd_setImageWithURL:dict2[@"bigportraiturl"] placeholderImage:[UIImage imageNamed:@""]]; ;
        [_picScrollView addSubview:imageView2];
        _pc = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 576 * scaleHeight, Screen_Width, 16 * scaleHeight)];
        _pc.currentPageIndicatorTintColor = [UIColor blackColor];
        _pc.pageIndicatorTintColor = [UIColor grayColor];
        _pc.numberOfPages = self.ProductImages.count;
        [view addSubview:_pc];

    }
    
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, Screen_Height - 64 - 97 * scaleHeight, Screen_Width, 97 * scaleHeight)];
    [self.view addSubview:_bottomView];
    
    //评论按钮
    UIButton *pinglunBtn = [[UIButton alloc] initWithFrame:CGRectMake(180 * scaleWidth, 0, 180 * scaleWidth, 97 * scaleHeight)];
    [pinglunBtn setBackgroundImage:[UIImage imageNamed:@"cpxq_btn_pinglun.png"] forState:UIControlStateNormal];
    [pinglunBtn addTarget:self action:@selector(pinglun) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:pinglunBtn];

    //对于消费者购买按钮，对于农场主商品下架
    UIButton *goumaiBtn = [[UIButton alloc] initWithFrame:CGRectMake(360 * scaleWidth, 0, 360 * scaleWidth, 97 * scaleHeight)];
    [goumaiBtn setBackgroundImage:[UIImage imageNamed:@"cpxq_btn_goumai_down.png"] forState:UIControlStateNormal];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([ud boolForKey:@"IsConsumer"]) {
        goumaiBtn.titleLabel.font = [UIFont systemFontOfSize:27.0];
        [goumaiBtn setTitle:NSLocalizedString(@"BUY", @"") forState:UIControlStateNormal];
    }
    else {
        goumaiBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
        [goumaiBtn setTitle:NSLocalizedString(@"Goods from the shelves", @"") forState:UIControlStateNormal];
    }
    
    [goumaiBtn addTarget:self action:@selector(goumai) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:goumaiBtn];
    
    //水果价格
    UILabel *shuiguoPriceLabel = [[UILabel alloc]init];
    NSDictionary* priceStyle = @{@"fuhao" :@[[UIFont fontWithName:@"HelveticaNeue" size:27.0],BaseColor(255, 104, 104, 1)],
                                 @"price" :@[[UIFont fontWithName:@"HelveticaNeue-Bold" size:27.0],BaseColor(255, 104, 104, 1)],
                                 @"type" :@[[UIFont fontWithName:@"HelveticaNeue" size:18.0],BaseColor(255, 104, 104, 1)]};
    shuiguoPriceLabel.attributedText = [[NSString stringWithFormat:@"<fuhao>¥</fuhao><price>%@</price><type>/%@</type>",self.ProductInfo[@"price"], self.ProductInfo[@"unit"]] attributedStringWithStyleBook:priceStyle];
    CGSize sizePrice = [shuiguoPriceLabel.text sizeWithFont:[UIFont systemFontOfSize:27.0] maxSize:CGSizeMake(999, 100)];
    shuiguoPriceLabel.frame = CGRectMake(24 * scaleWidth, 660 * scaleHeight, sizePrice.width, sizePrice.height);
    
    //滑动标志
    _huaDongImageView = [[UIImageView alloc] initWithFrame:CGRectMake(Screen_Width * 0.5 - 10, Screen_Height - 94 - 97 * scaleHeight, 20, 20)];
    _huaDongImageView.image = [UIImage imageNamed:@"cpxq_icon_hudong.png"];
    [self.view addSubview:_huaDongImageView];
    
    
    
}
#pragma mark -UITableView的代理方法
//2个组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
//每组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 5;
    }
    else {
        return _dataArray.count;
    }
}
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        //价格
        if (indexPath.row == 0) {
            NSString *price = self.ProductInfo[@"price"];
            CGSize priceSize = [price sizeWithFont:[UIFont systemFontOfSize:33.0] maxSize:CGSizeMake(990, 100)];
            NSString *shouchuNum = [NSString stringWithFormat:@"已售出  %@ | 运费：￥%@",self.ProductInfo[@"type"],self.ProductInfo[@"freight"]];
            CGSize shouchuNumSize = [shouchuNum sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(990, 100)];
            return 104 * scaleHeight + priceSize.height + shouchuNumSize.height;
        }
        
        //产品名称
        if (indexPath.row == 1) {
            NSString *name = self.ProductInfo[@"name"];
            CGSize nameSize = [name sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(990, 100)];
            if (nameSize.width >= 990) {
                nameSize.height = nameSize.height * 0.5;
            }
            NSInteger count = 1;
            for (NSInteger i = 0; nameSize.width >= 632 * scaleWidth; i++) {
                count++;
                nameSize.width -= 632 * scaleWidth;
            }
            NSString *description = self.ProductInfo[@"description"];
            CGSize descriptionSize = [description sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(990, 100)];
            if (descriptionSize.width >= 990) {
                descriptionSize.height = descriptionSize.height * 0.5;
            }
            NSInteger detailCount = 1;
            for (NSInteger i = 0; descriptionSize.width >= 632 * scaleWidth; i++) {
                detailCount++;
                descriptionSize.width -= 632 * scaleWidth;
            }
            return 90 * scaleHeight + nameSize.height  * count + descriptionSize.height * detailCount;
        }
        //产品数量
        if (indexPath.row == 2) {
            
            return 160 * scaleHeight;
        }
        //产品送至地址
        if (indexPath.row == 3) {
            
            if (_morenDizhi.length && !_selectDiZhi) {
                
                CGSize dizhiSize = [_morenDizhi sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(999, 100)];
                if (dizhiSize.width >= 990) {
                    dizhiSize.height = dizhiSize.height * 0.5;
                }
                CGFloat width = dizhiSize.width;
                NSInteger count = 1;
                for (NSInteger i = 0; width >= 540 * scaleWidth; i++) {
                    count++;
                    width -= 540 * scaleWidth;
                }
                return 50 * scaleHeight + dizhiSize.height * count;
            }
            else if (_dizhi.length && _selectDiZhi) {
                
                CGSize dizhiSize = [_dizhi sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(999, 100)];
                if (dizhiSize.width >= 990) {
                    dizhiSize.height = dizhiSize.height * 0.5;
                }
                CGFloat width = dizhiSize.width;
                NSInteger count = 1;
                for (NSInteger i = 0; width >= 540 * scaleWidth; i++) {
                    count++;
                    width -= 540 * scaleWidth;
                }
                return 50 * scaleHeight + dizhiSize.height * count;
            }
            else {
                //没有默认地址又不是新增加的收货地址
                
                return 160 * scaleHeight;
            }
        }
        //产品服务
        if (indexPath.row == 4) {
            
            CGSize size = [NSLocalizedString(@"SERVE", @"") sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(990, 100)];
            return 80 * scaleHeight + size.height * 2;
        }
        return 0;
    }
    if (indexPath.section == 1) {
        //根据评论内容自适应
        
        NSDictionary *dict = _dataArray[indexPath.row];
        
        CGSize size = [dict[@"displayname"] sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(999, 100)];
        if (size.width >= 990) {
            size.height = size.height * 0.5;
        }
        NSInteger num = 1;
        CGFloat widthNum = size.width;
        for (NSInteger i = 0; widthNum >= 632 * scaleWidth; i++) {
            num++;
            widthNum -= 632 * scaleWidth;
        }
       
        CGSize commentSize = [dict[@"comment"] sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(999, 100)];
        if (commentSize.width >= 990) {
            commentSize.height = commentSize.height * 0.5;
        }
        CGFloat width = commentSize.width;
        NSInteger count = 1;
        for (NSInteger i = 0; width >= 540 * scaleWidth; i++) {
            count++;
            width -= 540 * scaleWidth;
        }
        return 60 * scaleHeight + size.height * num + commentSize.height * count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        //价格
        if (indexPath.row == 0) {
            PriceTableViewCell *priceCell = [[PriceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"priceCell"];
            priceCell.viewController = self;
            [priceCell configWithDictionary:@[self.ProducerInfo,self.ProductInfo]];
            return priceCell;
        }
        //产品名称
        if (indexPath.row == 1) {
            ChanPinTableViewCell *chanPinCell = [[ChanPinTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"chanPinCell"];
            [chanPinCell configWithDictionary:self.ProductInfo];

            return chanPinCell;
        }
        //产品数量
        if (indexPath.row == 2) {
            _shuLiangCell = [tableView dequeueReusableCellWithIdentifier:@"shuLiangCell"];
            if (!_shuLiangCell) {
                _shuLiangCell = [[ShuLiangTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"shuLiangCell"];
            }
            _shuLiangCell.viewController = self;
            _shuLiangCell.textLabel.text = NSLocalizedString(@"NUMBER", @"");
            return _shuLiangCell;
        }
        //收货地址(是否是默认地址)
        if (indexPath.row == 3) {
            
            DiZhiTableViewCell *diZhiCell = [[DiZhiTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"diZhiCell"];
            diZhiCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            if (!_isQuDiaoMoRen) {
                
                if (_morenDizhi.length && _selectDiZhi) {
                    [diZhiCell configWithDiZhi:_morenDizhi];
                }
                else if (_dizhi.length && _selectDiZhi) {
                    [diZhiCell configWithDiZhi:_dizhi];
                }
                else {
                    
                    [diZhiCell configWithDiZhi:nil];
                }
                
            }
            else {
                
                [diZhiCell configWithDiZhi:nil];
            }
            return diZhiCell;
        }
        //服务
        if (indexPath.row == 4) {
            FuWuTableViewCell *fuWuCell = [[FuWuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"fuWuCell"];
            [fuWuCell configWithDictionary:self.ProducerInfo];
            return fuWuCell;
        }
        return nil;
    }
    else {
        
        PingLunTableViewCell *pinglunCell = [[PingLunTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"pinglunCell"];
        NSDictionary *dict = _dataArray[indexPath.row];
        [pinglunCell configWithDictionary:dict];
        return pinglunCell;
    }
}

//cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if (indexPath.section == 0) {
        //价格
        if (indexPath.row == 0) {
           
        }
        
        //产品名称
        if (indexPath.row == 1) {
           
        }
        //产品数量
        if (indexPath.row == 2) {
            
            
        }
        //产品送至地址
        if (indexPath.row == 3) {
    
            
            if ([ud boolForKey:@"IsConsumer"]) {
                
                ShouhuoDizhiViewController *shouhuoDizhiVC = [[ShouhuoDizhiViewController alloc] init];
                [self.navigationController pushViewController:shouhuoDizhiVC animated:YES];
                
            }
            else {
            
                CGSize size = [NSLocalizedString(@"Only consumers can add a shipping address", @"") sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(999, 100)];
                CGFloat labelX = (720 * scaleWidth - size.width) / 2 ;
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, 1200 * scaleHeight - 64, size.width, size.height)];
                label.backgroundColor = [UIColor blackColor];
                label.textAlignment = NSTextAlignmentCenter;
                label.textColor = [UIColor whiteColor];
                label.text = NSLocalizedString(@"Only consumers can add a shipping address", @"");
                [self.view addSubview:label];
                [self performSelector:@selector(removeLabel:) withObject:label afterDelay:1];
            }
        }
        //产品服务
        if (indexPath.row == 4) {
            

        }
    }


}

- (void)removeLabel:(UILabel *)label {
    
    [label removeFromSuperview];
    
}

// 设置头标高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 30;
    
}

// 设置头标的view
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {
        NSLog(@"%ld",(long)_dataArray.count);
        UILabel *lable = [[UILabel alloc]init];
        lable.text = [NSString stringWithFormat:@"%@(%ld)",NSLocalizedString(@"COMMENT", @""), (long)_dataArray.count];
        lable.backgroundColor = BaseColor(242, 242, 242, 1);
        return lable;
    }
    else {
        return nil;
    }
}

//购买或商品下架
- (void)goumai {
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [[JudgeNetState shareInstance] monitorNetworkType:self.view complete:^(NSInteger state) {
        
        if (state == 1 || state == 2) {
            //消费者
            if ([ud boolForKey:@"IsConsumer"]) {
                
                
                if ([_shuLiangCell.numTF.text integerValue] && _selectDiZhi) {
                    
                    [_JQRequest PostProductOrderWithConsumerId:[NSString stringWithFormat:@"%@",[ud objectForKey:@"ConsumerId"]] ProductId:self.ProductInfo[@"id"] Count:_shuLiangCell.numTF.text Unit:self.ProductInfo[@"unit"] Description:self.ProductInfo[@"description"] ConsigneeId:_ConsigneeDict[@"id"] complete:^(NSDictionary *responseObject) {
                       
                        CGSize size = [NSLocalizedString(@"Under the order has been good, you can go to see my order", @"") sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(999, 100)];
                        CGFloat labelX = (720 * scaleWidth - size.width) / 2 ;
                        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, 1200 * scaleHeight - 64, size.width, size.height)];
                        label.backgroundColor = [UIColor blackColor];
                        label.textAlignment = NSTextAlignmentCenter;
                        label.textColor = [UIColor whiteColor];
                        label.text = NSLocalizedString(@"Under the order has been good, you can go to see my order", @"");
                        [self.view addSubview:label];
                        [self.view bringSubviewToFront:label];
                        [self performSelector:@selector(removeLabel:) withObject:label afterDelay:1];
                    } fail:^(NSError *error, NSString *errorString) {
                       
                    }];
                    
                }
                else if (!_selectDiZhi) {
                    
                    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"Please select a shipping address", @"") preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                        
                        
                        
                    }];
                    [alertController addAction:otherAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                    
                }
                else {
                    
                    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"Please select the quantity ordered", @"") preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                        
                        
                        
                    }];
                    [alertController addAction:otherAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                    
                }
            }
            else {
                
                //农场主商品下架（自己的商品）
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                [_JQRequest deleteProducerShangPinXiaJiaWithProducerId:[NSString stringWithFormat:@"%@",[ud objectForKey:@"ProducerId"]] ProductId:[NSString stringWithFormat:@"%@",self.ProductInfo[@"id"]] Complete:^(NSDictionary *responseObject) {
                    
                    NSLog(@"农场主商品下架%@",responseObject);
                    
                    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"Your goods has been released from the shelves", @"") preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                        
                        [self.navigationController popViewControllerAnimated:YES];
                        
                    }];
                    [alertController addAction:otherAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                    
                } fail:^(NSError *error, NSString *errorString) {
                    
                    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:errorString preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                        
                        
                        
                    }];
                    [alertController addAction:otherAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                    
                }];
                
            }
        }
    }];

//    if ([ud boolForKey:@"IsConsumer"]) {
//        
//        
//        
//    }
//    else {
    
//        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"Farmers can't order goods", @"") preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
//            
//        }];
//        [alertController addAction:otherAction];
//        [self presentViewController:alertController animated:YES completion:nil];
    
//    }
}
//评论
- (void)pinglun {
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([ud boolForKey:@"IsConsumer"]) {
        
        [_bottomView removeFromSuperview];
        _bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, Screen_Height - 64 - 97 * scaleHeight, Screen_Width, 97 * scaleHeight)];
        _bottomImageView.image = [UIImage imageNamed:@"cppl_bg.png"];
        _bottomImageView.userInteractionEnabled = YES;
        [self.view addSubview:_bottomImageView];
        _pinglunTF = [[UITextField alloc] initWithFrame:CGRectMake(24 * scaleWidth, 10 * scaleHeight, 452 * scaleWidth, 80 * scaleHeight)];
        _pinglunTF.background = [UIImage imageNamed:@"cppl_input.png"];
        _pinglunTF.delegate = self;
        [_pinglunTF becomeFirstResponder];
        _pinglunTF.placeholder = NSLocalizedString(@"Say two words...", @"");
        [_bottomImageView addSubview:_pinglunTF];
        _isPingLun = YES;
        
        
     
        UIButton *fabiaoBtn = [[UIButton alloc] initWithFrame:CGRectMake(576 * scaleWidth, 10 * scaleHeight, 120 * scaleWidth, 80 * scaleHeight)];
        [fabiaoBtn setTitle:NSLocalizedString(@"Published", @"") forState:UIControlStateNormal];
        [fabiaoBtn setBackgroundImage:[UIImage imageNamed:@"cppl_btn_fabiao_down.png"] forState:UIControlStateNormal];
        [fabiaoBtn addTarget:self action:@selector(fabiao) forControlEvents:UIControlEventTouchUpInside];
        [_bottomImageView addSubview:fabiaoBtn];
        
    }
    else {
    
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"Only customers can comment", @"") preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
            
        
        }];
        [alertController addAction:otherAction];
        [self presentViewController:alertController animated:YES completion:nil];
    
    }

}
//发表评论
- (void)fabiao {
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [_JQRequest PostProductCommentWithConsumerId:[NSString stringWithFormat:@"%@",[ud objectForKey:@"ConsumerId"]] ProductId:self.ProductInfo[@"id"] Comment:_pinglunTF.text complete:^(NSDictionary *responseObject) {
        NSLog(@"评论%@",responseObject);
        
        [_pinglunTF resignFirstResponder];
        [_bottomImageView removeFromSuperview];
        [self.view addSubview:_bottomView];
        
        CGSize size = [NSLocalizedString(@"Comments to success", @"") sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(999, 100)];
        CGFloat labelX = (720 * scaleWidth - size.width) / 2 ;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, 1200 * scaleHeight - 64, size.width, size.height)];
        label.backgroundColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.text = NSLocalizedString(@"Comments to success", @"");
        [self.view addSubview:label];
        [self performSelector:@selector(removeLabel:) withObject:label afterDelay:1];
        
        //只从服务器上得到5条评论
        [_dataArray removeAllObjects];
        [self getCommentWithOffSet:@"0" Limit:@"5"];
        
        
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame = CGRectMake(0, 64, Screen_Width, Screen_Height - 64);
            self.view.frame = frame;
        }];
        
    } fail:^(NSError *error, NSString *errorString) {
        NSLog(@"%@",errorString);
    }];
}

//UITextField的代理方法
//弹出键盘后view向上升起了216
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = CGRectMake(0, - 216, Screen_Width, Screen_Height + 216);
        self.view.frame = frame;
    }];
    
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = CGRectMake(0, 64, Screen_Width, Screen_Height - 64);
        self.view.frame = frame;
    }];
    
    [_bottomImageView removeFromSuperview];
    [self.view addSubview:_bottomView];
    return YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

//收藏
- (void)shoucang:(UIButton *)sender {

    NSLog(@"%@",_FavoriteId);
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    if (!sender.selected) {
        
        if ([ud boolForKey:@"IsConsumer"]) {
            //消费者收藏商品到服务器
            [_JQRequest ConsumerShouCangProductWithConsumerId:[NSString stringWithFormat:@"%@",[ud objectForKey:@"ConsumerId"]] ProductId:self.ProductInfo[@"id"] complete:^(NSDictionary *responseObject) {
                NSLog(@"%@",responseObject);
                
                CGSize size = [NSLocalizedString(@"Collection is successful, please check in my collection", @"") sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(999, 100)];
                CGFloat labelX = (720 * scaleWidth - size.width) / 2 ;
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, 1200 * scaleHeight - 64, size.width, size.height)];
                label.backgroundColor = [UIColor blackColor];
                label.textAlignment = NSTextAlignmentCenter;
                label.textColor = [UIColor whiteColor];
                label.text = NSLocalizedString(@"Collection is successful, please check in my collection", @"");
                [self.view addSubview:label];
                [self.view bringSubviewToFront:label];
                [self performSelector:@selector(removeLabel:) withObject:label afterDelay:1];
                
                sender.selected = YES;
                _FavoriteId = responseObject[@"id"];
                
                
            } fail:^(NSError *error, NSString *errorString) {
                NSLog(@"%@",errorString);
                
                UIAlertController * alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"Can not repeat collection", @"") preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                    
                }];
                [alertController addAction:otherAction];
                [self presentViewController:alertController animated:YES completion:nil];
                
            }];
            
        }
        else {
            //农场主收藏商品到服务器
            [_JQRequest ProducerShouCangProductWithProducerId:[NSString stringWithFormat:@"%@",[ud objectForKey:@"ProducerId"]] ProductId:self.ProductInfo[@"id"] complete:^(NSDictionary *responseObject) {
                NSLog(@"%@",responseObject);
                
                CGSize size = [NSLocalizedString(@"Collection is successful, please check in my collection", @"") sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(999, 100)];
                CGFloat labelX = (720 * scaleWidth - size.width) / 2 ;
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, 1200 * scaleHeight - 64, size.width, size.height)];
                label.backgroundColor = [UIColor blackColor];
                label.textAlignment = NSTextAlignmentCenter;
                label.textColor = [UIColor whiteColor];
                label.text = NSLocalizedString(@"Collection is successful, please check in my collection", @"");
                [self.view addSubview:label];
                [self.view bringSubviewToFront:label];
                [self performSelector:@selector(removeLabel:) withObject:label afterDelay:1];
                
                sender.selected = YES;
                 _FavoriteId = responseObject[@"id"];
                
            } fail:^(NSError *error, NSString *errorString) {
                NSLog(@"错误%@",errorString);
                
                UIAlertController * alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"Can not repeat collection", @"") preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                    
                    
                    
                }];
                [alertController addAction:otherAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }];
        }
    }
    else {
    
        if ([ud boolForKey:@"IsConsumer"]) {
            //删消费者的商品收藏
            [_JQRequest deleteConsumerShouCangProductWithFavoriteId:_FavoriteId Complete:^(NSDictionary *responseObject) {
             
                NSLog(@"%@",responseObject);
                
                CGSize size = [NSLocalizedString(@"Collection has been cancelled", @"") sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(999, 100)];
                CGFloat labelX = (720 * scaleWidth - size.width) / 2 ;
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, 1200 * scaleHeight - 64, size.width, size.height)];
                label.backgroundColor = [UIColor blackColor];
                label.textAlignment = NSTextAlignmentCenter;
                label.textColor = [UIColor whiteColor];
                label.text = NSLocalizedString(@"Collection has been cancelled", @"");
                [self.view addSubview:label];
                [self.view bringSubviewToFront:label];
                [self performSelector:@selector(removeLabel:) withObject:label afterDelay:1];
                
                sender.selected = NO;
                
                
            } fail:^(NSError *error, NSString *errorString) {
                NSLog(@"%@",errorString);
                
                UIAlertController * alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:errorString preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                    
                    
                    
                }];
                [alertController addAction:otherAction];
                [self presentViewController:alertController animated:YES completion:nil];
                
            }];
            
        }
        else {
            //删除农场主的商品收藏
            [_JQRequest deleteProducerShouCangProductWithFavoriteId:_FavoriteId Complete:^(NSDictionary *responseObject) {
                NSLog(@"%@",responseObject);
                
                CGSize size = [NSLocalizedString(@"Collection has been cancelled", @"") sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(999, 100)];
                CGFloat labelX = (720 * scaleWidth - size.width) / 2 ;
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, 1200 * scaleHeight - 64, size.width, size.height)];
                label.backgroundColor = [UIColor blackColor];
                label.textAlignment = NSTextAlignmentCenter;
                label.textColor = [UIColor whiteColor];
                label.text = NSLocalizedString(@"Collection has been cancelled", @"");
                [self.view addSubview:label];
                [self.view bringSubviewToFront:label];
                [self performSelector:@selector(removeLabel:) withObject:label afterDelay:1];
                
                sender.selected = NO;
                
            } fail:^(NSError *error, NSString *errorString) {
                NSLog(@"错误%@",errorString);
                
                UIAlertController * alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:errorString preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                    
                }];
                [alertController addAction:otherAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }];
        }
    }
}

//UIScrollView的代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger x = _picScrollView.contentOffset.x / Screen_Width;
    
    if (x == 0) {
        [_picScrollView setContentOffset:CGPointMake(Screen_Width * self.ProductImages.count, 0) animated:NO];
        x = self.ProductImages.count;
    }
    if (x == self.ProductImages.count + 1) {
        [_picScrollView setContentOffset:CGPointMake(Screen_Width, 0) animated:NO];
        x = 1;
    }
    _pc.currentPage = x - 1;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (_isPingLun) {
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame = CGRectMake(0, 64, Screen_Width, Screen_Height - 97 * scaleHeight);
            self.view.frame = frame;
        }];
        [_bottomImageView removeFromSuperview];
        [self.view addSubview:_bottomView];
        
    }
    if (scrollView == _tableView) {
        [_huaDongImageView removeFromSuperview];
    }
}

//导航栏左边的返回按钮
- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
