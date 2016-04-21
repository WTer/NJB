//
//  MyCollectionTableViewCell.h
//  农帮乐
//
//  Created by 王朝源 on 15/12/9.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^blockOfCancle) (UIButton * button);
@class myCollectionModel;
@interface MyCollectionTableViewCell : UITableViewCell
@property (nonatomic, copy)blockOfCancle Myblock;
@property (nonatomic, strong)myCollectionModel * model;
- (void)cancleCollectionButtonClick:(blockOfCancle)block;
@end
