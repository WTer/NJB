//
//  DiZhiTableViewCell.h
//  农帮乐
//
//  Created by hpz on 15/12/11.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiZhiTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *dizhi;

- (void)configWithDiZhi:(NSString *)dizhiString;

@end
