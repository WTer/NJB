//
//  ShouhuoDizhiTableViewCell.h
//  农帮乐
//
//  Created by hpz on 15/12/14.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ShouhuoDizhiTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *telphone;
@property (nonatomic, strong) UILabel *dizhi;
@property (nonatomic, strong) UIButton *morenBtn;
@property (nonatomic, strong) UILabel *morenLabel;
@property (nonatomic, strong) UIButton *editBtn;
@property (nonatomic, strong) UIButton *deleteBtn;

@property (nonatomic, strong) UIViewController *viewController;

- (void)configWithDictiongary:(NSDictionary *)dict;

@end
