//
//  YouHuiQuanYiGuoQiTableViewCell.h
//  农家帮
//
//  Created by Mac on 16/3/27.
//  Copyright © 2016年 jingqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GuanLiYouHuiQuanViewController;

@interface YouHuiQuanYiGuoQiTableViewCell : UITableViewCell

@property (nonatomic, strong) UIScrollView *youhuiquanView;
@property (nonatomic, strong) GuanLiYouHuiQuanViewController *viewController;

- (void)configWithDictionary:(NSDictionary *)dict;

@end
