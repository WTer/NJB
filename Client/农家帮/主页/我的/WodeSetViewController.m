//
//  WodeSetViewController.m
//  农帮乐
//
//  Created by 王朝源 on 15/12/7.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "WodeSetViewController.h"
#import "YiJianViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "MyNavigationController.h"
#import "ShouYeViewController.h"
#import "UMSocial.h"
#import <ShareSDK/ShareSDK.h>
@interface WodeSetViewController ()<UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>

@end

@implementation WodeSetViewController
{
    UITableView * _tableView;
    NSArray * _dataArray;
    UILabel * _huancunLable;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    _dataArray = @[NSLocalizedString(@"推送通知", @""),NSLocalizedString( @"清除缓存", @""), NSLocalizedString(@"邀请好友", @""),NSLocalizedString(@"用户反馈", @"")];
    self.view.backgroundColor = BaseColor(245, 245, 245, 1);
    self.navigationItem.title = NSLocalizedString(@"设置", @"");
    [self createBackLeftButton];//创建左边返回按钮
    [self createTableView];//创建tableView
    [self createLeaveLoginButton];
    
}
//创建返回按钮
- (void)createBackLeftButton
{
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [button setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(leftBackButtonClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)leftBackButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
//创建退出登录按钮
- (void)createLeaveLoginButton
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"shouye_btn_denglu_n.png"] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(LeaveLoginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:NSLocalizedString(@"退出登录", @"") forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_tableView.mas_bottom).offset(100 * scaleHeight);
        make.left.mas_equalTo(scaleWidth * 24);
        make.height.mas_equalTo(scaleHeight * 80);
        make.right.mas_equalTo(-scaleWidth * 24);
    }];
}

- (void)LeaveLoginButtonClick
{
    
    UIAlertController*alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction * otherAction1 = [UIAlertAction  actionWithTitle:NSLocalizedString(@"确定要退出登录?", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
        NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:@"" forKey:UserID];
        [ud setObject:@"" forKey:UserCategory];
        [ud setObject:@"" forKey:@"ConsumerId"];
        [ud setObject:@"" forKey:@"ProducerId"];
        [ud synchronize];
        NSDictionary * dict2 = @{};
        [dict2 writeToFile:UserMessageLocalAdress atomically:YES];
        [dict2 writeToFile:HuanCunOfAddressBook atomically:YES];
        [dict2 writeToFile:HuanCunOfAlsoExpress atomically:YES];
        //用户退出登录之后将用户的缓存信息清空
        ShouYeViewController * svc = [[ShouYeViewController alloc]init];
        MyNavigationController * mvc = [[MyNavigationController alloc]initWithRootViewController:svc];
        [self presentViewController:mvc animated:YES completion:^{
            
        }];
    }];
    UIAlertAction * otherAction2 = [UIAlertAction  actionWithTitle:NSLocalizedString(@"取消", @"") style:UIAlertActionStyleCancel handler:^(UIAlertAction*action) {
        
        
    }];
    [alertController addAction:otherAction1];
    [alertController addAction:otherAction2];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
//创建tableView
- (void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 424 * scaleHeight) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableView.rowHeight = 106 * scaleHeight;
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    _tableView.bounces = NO;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = _dataArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:21];
    cell.textLabel.textColor = BaseColor(105, 105, 105, 1);
    if (indexPath.row != 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        UIButton * button = [self createPutOnButton];
        [cell addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(cell.mas_right).offset(-40 * scaleWidth);
            make.width.mas_equalTo(100 * scaleWidth);
            make.height.mas_equalTo(50 * scaleHeight);
            make.centerY.mas_equalTo(cell.mas_centerY);
        }];
    }
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;//（一般最好设置一下）
    if (indexPath.row == 1) {
        _huancunLable = [[UILabel  alloc]init];
        _huancunLable.textColor = BaseColor(178, 178, 178, 1);
        _huancunLable.font = [UIFont systemFontOfSize:21];
        [cell addSubview:_huancunLable];
        [_huancunLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(84 + scaleHeight * 64);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(21);
            make.centerY.mas_equalTo(cell.mas_centerY);
        }];
        _huancunLable.text = [NSString stringWithFormat:@"%.1fMB", [self fileSize]];
    }
    return cell;
}
//tableView的点击的代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        [self createActionSheet];
    }
    if (indexPath.row == 2) {
        [self share];
#warning 邀请好友暂时未实现
    }
    if (indexPath.row == 3) {
        YiJianViewController * yvc = [[YiJianViewController alloc]init];
        [self.navigationController pushViewController:yvc animated:YES];
    }
}
#warning 分享的内容未设置
- (void)share {
    
    NSString *imagePath=[[NSBundle mainBundle]pathForResource:@"me4s" ofType:@"png"];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"IMBA刀塔助手"
                                       defaultContent:@"测试一下"
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"#IMBA刀塔助手#"
                                                  url:@"http://www.dota2.com.cn/"
                                          description:@"IMBA刀塔助手是一款你值得拥有的！ ~~"
                                            mediaType:SSPublishContentMediaTypeNews];
    NSArray *shareList = [ShareSDK customShareListWithType:
                          [NSNumber numberWithInteger:ShareTypeWeixiTimeline],
                          [NSNumber numberWithInteger:ShareTypeWeixiSession],
                          [NSNumber numberWithInteger:ShareTypeSinaWeibo],
                          [NSNumber numberWithInteger:ShareTypeQQ],
                          [NSNumber numberWithInteger:ShareTypeQQSpace],
                          [NSNumber numberWithInteger:ShareTypeDouBan],
                          [NSNumber numberWithInteger:ShareTypeInstagram],
                          [NSNumber numberWithInteger:ShareTypeEvernote],nil];
    //创建容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:self.view arrowDirect:UIPopoverArrowDirectionUp];
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleModal
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:shareList
                           content:publishContent
                     statusBarTips:YES
                       authOptions:authOptions
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                }
                            }];
    
}
#pragma mark  ---创建actionsheet(清理缓存)
- (void)createActionSheet {
    
    UIAlertController*alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction * otherAction1 = [UIAlertAction  actionWithTitle:NSLocalizedString(@"确定要清理缓存?", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
        
        [self removeFile];
        _huancunLable.text = [NSString stringWithFormat:@"%.1fMB", [self fileSize]];
    }];
    UIAlertAction * otherAction2 = [UIAlertAction  actionWithTitle:NSLocalizedString(@"取消", @"") style:UIAlertActionStyleCancel handler:^(UIAlertAction*action) {
        
        
    }];
    [alertController addAction:otherAction1];
    [alertController addAction:otherAction2];
    [self presentViewController:alertController animated:YES completion:nil];
}

//创建打开推送的按钮（默认打开）
- (UIButton *)createPutOnButton
{
    UIButton * button = [[UIButton alloc]init];
    [button setImage:[UIImage imageNamed:@"grzx_sz_btn_on.png"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"grzx_sz_btn_off.png"] forState:UIControlStateSelected];
    button.selected = YES;
    [button addTarget:self action:@selector(PutOnButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 6;
    button.layer.masksToBounds = YES;
    return button;
}
- (void)PutOnButtonClick:(UIButton *)button
{
    button.selected = !button.selected;
}

//计算缓存区文件的大小
-(float)fileSize//计算文件夹下文件的总大小（此时计算的是缓冲区的大小）
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    //    NSLog(@"%@", cachePath);
    // 获得缓存文件总大小
    // 获得所有的子路径
    NSArray *subArr = [mgr subpathsAtPath:cachePath];
    long long size = 0;
    for (NSString *subPath in subArr) {
        NSString *fullPath = [cachePath stringByAppendingPathComponent:subPath];
        BOOL dir = NO;
        [mgr fileExistsAtPath:fullPath isDirectory:&dir];
        if (dir == 0) {
            size += [[mgr attributesOfItemAtPath:fullPath error:nil][NSFileSize] longLongValue];
        }
    }
    CGFloat sizeMB = size/1024/1024.0;
    return sizeMB;
}
//清理缓冲区的缓冲
-(void)removeFile
{
    // 清除缓存
    NSFileManager *mgr = [NSFileManager defaultManager];
    // 主cache路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    NSArray *subArr = [mgr subpathsAtPath:cachePath];
    // 找到所有文件和文件夹
    for (NSString *subPath in subArr) {
        // 拼接全路径
        NSString *fullPath = [cachePath stringByAppendingPathComponent:subPath];
        [mgr removeItemAtPath:fullPath error:nil];
    }
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
