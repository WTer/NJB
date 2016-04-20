//
//  XuanZeRiQiTableViewCell.h
//  农家帮
//
//  Created by Mac on 16/3/28.
//  Copyright © 2016年 jingqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XuanZeRiQiTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel *riqi;


- (void)configWithDictionary:(NSArray *)array;

@end
