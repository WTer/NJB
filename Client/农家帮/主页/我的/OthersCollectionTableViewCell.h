//
//  OthersCollectionTableViewCell.h
//  农家帮
//
//  Created by Mac on 16/3/31.
//  Copyright © 2016年 jingqi. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^blockOfCancle) (UIButton * button);
@class myCollectionModel;

@interface OthersCollectionTableViewCell : UITableViewCell
@property (nonatomic, copy)blockOfCancle Myblock;
@property (nonatomic, strong)myCollectionModel * model;
- (void)cancleCollectionButtonClick:(blockOfCancle)block;
@end
