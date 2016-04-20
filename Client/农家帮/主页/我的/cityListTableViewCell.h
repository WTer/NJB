//
//  cityListTableViewCell.h
//  农帮乐
//
//  Created by 王朝源 on 15/12/18.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^myBlock) (UIButton *button);
@interface cityListTableViewCell : UITableViewCell
@property (nonatomic, strong)UIButton * selectedButton;
@property (nonatomic, strong)UILabel * cityLable;
@property (nonatomic, copy)myBlock block;
- (void)cellBeClick:(myBlock)block;
@end
