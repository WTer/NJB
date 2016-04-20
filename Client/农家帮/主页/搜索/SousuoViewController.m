//
//  SousuoViewController.m
//  农帮乐
//
//  Created by hpz on 15/12/2.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "SousuoViewController.h"
#import "TabBarViewController.h"
#import "SouSuoResultViewController.h"

@interface SousuoViewController ()<UISearchBarDelegate>

@end

@implementation SousuoViewController
{
    UISearchBar *_searchBar;
    JQBaseRequest *_JQResquest;
    NSString *_userId;
    NSMutableArray *_dataArray;
    NSInteger _sum;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    _JQResquest = [[JQBaseRequest alloc] init];
    _dataArray = [[NSMutableArray alloc] init];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 12 * scaleHeight, 520 * scaleWidth, 72 * scaleHeight)];
    _searchBar.placeholder = NSLocalizedString(@"Search for goods", @"");
    _searchBar.delegate = self;
    self.navigationItem.titleView = _searchBar;
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"SEARCH", @"") style:UIBarButtonItemStylePlain target:self action:@selector(search)];
    
    [self requestData];
    
}
//点击键盘的搜索按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    if (_searchBar.text.length) {
        
        [_searchBar resignFirstResponder];
        SouSuoResultViewController *sousuoResultVC = [[SouSuoResultViewController alloc] init];
        sousuoResultVC.btnTitleStr = _searchBar.text;
        [self.navigationController pushViewController:sousuoResultVC animated:YES];
        
    }
    else {
        
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"Please input search content", @"") preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
            
            
            
        }];
        [alertController addAction:otherAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
   
}
- (void)requestData {
    
    //首先请求数据
    [_JQResquest getSouSuoReBangComplete:^(NSDictionary *responseObject) {
        
        _dataArray = responseObject[@"List"];
        NSLog(@"%@",_dataArray);
        [self createUI];
        
    } fail:^(NSError *error, NSString *errorString) {
        
    }];
}
//返回主页按钮
- (void)back {
   
    NSNotification *noti = [[NSNotification alloc] initWithName:@"fanhui" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter]postNotification:noti];

}
- (void)search {

    if (_searchBar.text.length) {
        
        [_searchBar resignFirstResponder];
        SouSuoResultViewController *sousuoResultVC = [[SouSuoResultViewController alloc] init];
        sousuoResultVC.btnTitleStr = _searchBar.text;
        [self.navigationController pushViewController:sousuoResultVC animated:YES];

    }
    else {
        
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"Please input search content", @"") preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
            
            
            
        }];
        [alertController addAction:otherAction];
        [self presentViewController:alertController animated:YES completion:nil];

    }
}
- (void)createUI {
    
    //热门搜索榜
    UILabel *title = [[UILabel alloc] init];
    title.text = NSLocalizedString(@"List of top search", @"");
    title.textAlignment = NSTextAlignmentCenter;
    CGSize size = [title.text sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(999, 100)];
    title.textColor = BaseColor(52, 52, 52, 1);
    title.frame = CGRectMake(0, 40 * scaleHeight, 672 * scaleWidth, size.height);
    [self.view addSubview:title];
    
    
    _sum = 0;
    
    for (NSInteger i = 0; i < _dataArray.count; i++) {
        [self labelAndButtonWithNSInteger:i];
    }
}

- (void)labelAndButtonWithNSInteger:(NSInteger)count {
    
    //例如count=1
    CGSize size = [NSLocalizedString(@"List of top search", @"") sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(999, 100)];
    NSDictionary *rootDict = _dataArray[count];
    NSDictionary *dict = rootDict[@"HotSearchWord"];
    
    CGFloat labelY = 0;
    
    //label
    UILabel *label = [[UILabel alloc] init];
    label.text = dict[@"type"];
    CGSize labelSize = [label.text sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(999, 100)];
    label.textColor = BaseColor(52, 52, 52, 1);
        [self.view addSubview:label];
    
    //按钮
    NSArray *array = dict[@"KeyWords"];
    
    _sum = _sum + array.count;
    
    for (NSInteger i = 0; i < array.count; i++) {
        
        //某个button自身的大小
        NSDictionary *btnSelfDict = array[i];
        CGSize btnSelfSize = [[NSString stringWithFormat:@"%@", btnSelfDict[@"name"]] sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(999, 100)];
        
        //某个button离左边的距离btnX，某个button离上面边的距离btnY，
        CGFloat btnX = 54 * scaleWidth + labelSize.width;
        CGFloat btnY = 80 * scaleHeight + size.height;
        
        for (NSInteger j = 0; j < i; j++) {
            NSDictionary *btnDict = array[j];
            CGSize btnSize = [[NSString stringWithFormat:@"%@", btnDict[@"name"]] sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(999, 100)];
            btnX = btnX + btnSize.width + 20 * scaleWidth;
            
        }
        if (btnX < Screen_Width) {
            
            btnY = btnY + btnSelfSize.height * count + 40 * scaleHeight * count;
            
        }
        CGFloat x = btnX;
        int num = 0;
        if (x > Screen_Width) {
            for (NSInteger i = 0; x - Screen_Width < Screen_Width; i++) {
                num++;
                x -= Screen_Width;
            }
            btnY = btnY + btnSelfSize.height * count + 40 * scaleHeight * (count + num);
        }
        
        //某个button的frame
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(btnX                                                                                                                                                                                                                                                 , btnY, btnSelfSize.width, btnSelfSize.height)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [button addGestureRecognizer:tap];
        [button setBackgroundImage:[UIImage imageWithData:UIImagePNGRepresentation([UIImage imageNamed:@"zy_icon_shuiguo.jpg"])] forState:UIControlStateNormal];
        [button setTitle:btnSelfDict[@"name"] forState:UIControlStateNormal];
        [button setTitleColor:BaseColor(14, 184, 58, 1) forState:UIControlStateNormal];
        [self.view addSubview:button];
        if (i == array.count - 1) {
            labelY = button.frame.origin.y;
        }
    }
    label.frame = CGRectMake(24 * scaleWidth, labelY, labelSize.width, labelSize.height);
}
- (void)tap:(UITapGestureRecognizer *)tap {
   
    [_searchBar resignFirstResponder];
    UIButton *button = (UIButton *)tap.view;
    
    NSLog(@"%@",button.titleLabel.text);
    
    SouSuoResultViewController *sousuoResultVC = [[SouSuoResultViewController alloc] init];
    sousuoResultVC.btnTitleStr = button.titleLabel.text;
    [self.navigationController pushViewController:sousuoResultVC animated:YES];
    
}
//点击屏幕触发的事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
