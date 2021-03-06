//
//  HongBaoShiYongTableViewCell.h
//  农家帮
//
//  Created by Mac on 16/4/5.
//  Copyright © 2016年 jingqi. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^myBlock) (UIButton *btn);
@interface HongBaoShiYongTableViewCell : UITableViewCell
@property (nonatomic, copy)myBlock block;


@property(nonatomic,copy)NSString * Amount;

@property(nonatomic,copy)NSString * Message;

@property(nonatomic,copy)NSString * Time;
- (void)senderButtonClick:(myBlock)block;

@property (nonatomic, copy)myBlock deleteBlock;
- (void)deleteBlockClick:(myBlock)deleteBlock;
@end
