//
//  AppDelegate.m
//  农帮乐
//
//  Created by hpz on 15/11/30.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "AppDelegate.h"
#import "ShouYeViewController.h"
#import "MyNavigationController.h"
#import "TabBarViewController.h"

//shareSDK微信和微博分享
#import "WXApi.h"
//#import "WeiboApi.h"
#import "WeiboSDK.h"
#import <ShareSDK/ShareSDK.h>
//#import <QZoneConnection/QZoneConnection.h>
//#import <TencentOpenAPI/QQApi.h>
//#import <TencentOpenAPI/QQApiInterface.h>
//#import <TencentOpenAPI/TencentOAuth.h>

//友盟分享
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"


@interface AppDelegate ()

@end

@implementation AppDelegate
{
    UILabel *_label;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *consumerId = [ud objectForKey:@"ConsumerId"];
    NSString *producerId = [ud objectForKey:@"ProducerId"];
    
    if (consumerId.length) {
        
        TabBarViewController *mainVC = [[TabBarViewController alloc] init];
        MyNavigationController * mvc = [[MyNavigationController alloc]initWithRootViewController:mainVC];
        self.window.rootViewController = mvc;
        
    }
    else if (producerId.length) {
        
        TabBarViewController *mainVC = [[TabBarViewController alloc] init];
        MyNavigationController * mvc = [[MyNavigationController alloc]initWithRootViewController:mainVC];
        self.window.rootViewController = mvc;

    
    }
    else {
        
        ShouYeViewController *shouye = [[ShouYeViewController alloc] init];
        MyNavigationController *shouyeNav = [[MyNavigationController alloc] initWithRootViewController:shouye];
        self.window.rootViewController = shouyeNav;
        
        CGFloat labelX = (720 - 300) / 2 * scaleWidth;
        _label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, 1200 * scaleHeight, 300 * scaleWidth, 80 * scaleHeight)];
        _label.backgroundColor = [UIColor blackColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor whiteColor];
        [self.window addSubview:_label];
        [self performSelector:@selector(removeLabel:) withObject:_label afterDelay:1];
        [self monitorNetworkType];
        
    }
    
    [self.window makeKeyAndVisible];
    
    
    //友盟分享
    [UMSocialData setAppKey:@"568b233667e58e19b3001c71"];
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];
    
    
    
    //注册ShareSDK的appkey
//    [ShareSDK registerApp:@"7e4b6816d820"];
//    [self initializePlat];
    
    
    [self requestCityList];
    
    return YES;
}

- (void)requestCityList {
    
    NSDictionary * dict = [NSDictionary dictionaryWithContentsOfFile:CityList];
    JQBaseRequest * jq = [[JQBaseRequest alloc]init];
    if (!dict.count) {
        [jq GETrequestWitUrlString:@"http://182.92.224.165/Common/ProvinceCityList" para:nil complete:^(NSDictionary *responseObject) {
            [responseObject writeToFile:CityList atomically:YES];
        } fail:^(NSError *error, NSString *errorString) {
            
        }];
    }
}

-(void)initializePlat {
    
    //添加微信应用 注册网址 http://open.weixin.qq.com
    [ShareSDK connectWeChatWithAppId:@"wx21110b8c85dd0a63"
                           appSecret:@"1df4cc90999912f7b2f723ddabb0cd20"
                           wechatCls:[WXApi class]];
    //添加新浪微博应用 注册网址 http://open.weibo.com
    [ShareSDK connectSinaWeiboWithAppKey:@"568898243"
                               appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                             redirectUri:@"http://www.sharesdk.cn"];
    
    
    
}

- (void)removeLabel:(UILabel *)object {
    
    [object removeFromSuperview];

}
-(void)monitorNetworkType {
    //iphone网络状态(WAN, Wi-Fi, 不可达)
    //基本原理: 通过一个域名去判断
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:BaseURL]];
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        //获取网络状态
        if(status == AFNetworkReachabilityStatusReachableViaWWAN) {
            NSLog(@"正在使用GPRS/3G/2G");
            _label.text = NSLocalizedString(@"Are using GPRS/3G/2G", @"");
            
        }
        if(status == AFNetworkReachabilityStatusReachableViaWiFi) {
            NSLog(@"正在使用wifi");
            _label.text = NSLocalizedString(@"Are using wifi", @"");
            
        }
        if(status == AFNetworkReachabilityStatusNotReachable) {
            NSLog(@"请先连接网络");
            _label.text = NSLocalizedString(@"Please connect to the Internet", @"");
           
        }
        
    }];
    
    //开启网络状态监视
    [manager.reachabilityManager startMonitoring];
}


-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    return [ShareSDK handleOpenURL:url wxDelegate:self];
    
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    return [ShareSDK handleOpenURL:url sourceApplication:sourceApplication annotation:annotation wxDelegate:self];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}
 - (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
