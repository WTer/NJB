//
//  XiaoFeiZheCellTableViewCell.h
//  农家帮
//
//  Created by 赵波 on 16/3/6.
//  Copyright © 2016年 jingqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XiaoFeiZheModel.h"

@class XiaoFeiZheCellTableViewCell;
@protocol YaoQingDelegate <NSObject>

- (void)yaoQingXiaoFeiZheCell:(XiaoFeiZheCellTableViewCell *)cell;

@end

@interface XiaoFeiZheCellTableViewCell : UITableViewCell

@property (nonatomic, strong) XiaoFeiZheModel *model;
@property (nonatomic, strong) id<YaoQingDelegate> delegate;

@end
