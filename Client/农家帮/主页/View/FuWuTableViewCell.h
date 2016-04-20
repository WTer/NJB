//
//  FuWuTableViewCell.h
//  农帮乐
//
//  Created by hpz on 15/12/11.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FuWuTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *server;
@property (nonatomic, strong) UILabel *telLabel;

- (void)configWithDictionary:(NSDictionary *)dict;

@end
