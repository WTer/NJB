//
//  JudgeNetState.m
//  农帮乐
//
//  Created by hpz on 15/12/8.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "JudgeNetState.h"

static JudgeNetState *_netState;

@implementation JudgeNetState
{
    UILabel *_label;
   
}
+ (instancetype) shareInstance {
    
    static dispatch_once_t token = 0;

    dispatch_once(&token, ^{
        
        _netState = [[JudgeNetState alloc] init];
        
    });
    return _netState;
}


- (void)removeLabel:(UILabel *)object {
    
    [_label removeFromSuperview];
    
}

- (void)monitorNetworkType:(UIView *)view complete:(PdBlock)block{
    //iphone网络状态(WAN, Wi-Fi, 不可达)
    //基本原理: 通过一个域名去判断
    _myblock = block;
    CGFloat labelX = (720 - 300) / 2 * scaleWidth;
    _label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, 1200 * scaleHeight - 64, 300 * scaleWidth, 80 * scaleHeight)];
    _label.backgroundColor = [UIColor blackColor];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.textColor = [UIColor whiteColor];
   
    
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:BaseURL]];
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        __block NSInteger state = 0;
        //获取网络状态
        if(status == AFNetworkReachabilityStatusReachableViaWWAN) {
            NSLog(@"正在使用GPRS/3G/2G");
            
            state = 1;
        }
        if(status == AFNetworkReachabilityStatusReachableViaWiFi) {
            NSLog(@"正在使用wifi");
           
            
            state = 2;
            
        }
        if(status == AFNetworkReachabilityStatusNotReachable) {
            NSLog(@"请先连接网络");
            _label.text = NSLocalizedString(@"Please connect to the Internet", @"");
            [view addSubview:_label];
            [self performSelector:@selector(removeLabel:) withObject:_label afterDelay:1];
            state = 3;
        }
        _myblock(state);
    }];
    
    //开启网络状态监视
    [manager.reachabilityManager startMonitoring];
    
}

@end
