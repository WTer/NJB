//
//  HongBaoYouxiaoTableViewCell.h
//  农家帮
//
//  Created by Mac on 16/3/25.
//  Copyright © 2016年 jingqi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^myBlock) (UIButton *btn);
@interface HongBaoYouxiaoTableViewCell : UITableViewCell

@property (nonatomic, copy)myBlock block;

- (void)senderButtonClick:(myBlock)block;


@property (nonatomic, copy)myBlock deleteBlock;
- (void)deleteBlockClick:(myBlock)deleteBlock;

@property(nonatomic,copy)NSString * Amount;

@property(nonatomic,copy)NSString * Message;

@property(nonatomic,copy)NSString * Time;

@end
