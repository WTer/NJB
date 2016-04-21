//
//  JudgeNetState.h
//  农帮乐
//
//  Created by hpz on 15/12/8.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PdBlock) (NSInteger state);

@interface JudgeNetState : UIView

@property(nonatomic, copy)PdBlock myblock;

+ (instancetype) shareInstance;

- (void)monitorNetworkType:(UIView *)view complete:(PdBlock)block;

@end
