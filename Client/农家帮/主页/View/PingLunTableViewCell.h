//
//  PingLunTableViewCell.h
//  农帮乐
//
//  Created by hpz on 15/12/11.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PingLunTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *niChengLabel;

@property (nonatomic, strong) UIImageView *timeImage;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *commentLabel;

- (void)configWithDictionary:(NSDictionary *)dict;


@end
