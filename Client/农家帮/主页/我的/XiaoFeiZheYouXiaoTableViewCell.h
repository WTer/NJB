//
//  XiaoFeiZheYouXiaoTableViewCell.h
//  农家帮
//
//  Created by Mac on 16/4/5.
//  Copyright © 2016年 jingqi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^myBlock) (UIButton *btn);
@interface XiaoFeiZheYouXiaoTableViewCell : UITableViewCell

@property (nonatomic, copy)myBlock block;

- (void)senderButtonClick:(myBlock)block;

@property(nonatomic,copy)NSString * Amount;

@property(nonatomic,copy)NSString * Message;

@property(nonatomic,copy)NSString * Time;

@property (nonatomic, copy)myBlock deleteBlock;
- (void)deleteBlockClick:(myBlock)deleteBlock;

@end
