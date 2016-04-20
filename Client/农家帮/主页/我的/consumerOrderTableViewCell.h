//
//  consumerOrderTableViewCell.h
//  农帮乐
//
//  Created by 王朝源 on 15/12/16.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class myOrderModel;
typedef void (^myBlock) (UIButton *btn);
@interface consumerOrderTableViewCell : UITableViewCell
@property (nonatomic, strong)myOrderModel * model;
@property (nonatomic, copy)myBlock  mblock;
- (void)certainButtonClick:(myBlock)block;
@end
