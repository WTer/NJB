//
//  FaSongHongBaoCell.h
//  农家帮
//
//  Created by Mac on 16/4/11.
//  Copyright © 2016年 jingqi. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^myBlock) (UIButton *btn);
@interface FaSongHongBaoCell : UITableViewCell

@property(nonatomic, copy)UIButton * IsSelectedButton;

@property(nonatomic, copy)UIImageView * headerImageView;

@property(nonatomic, copy)UILabel * nameLable;

@property (nonatomic, copy)myBlock block;

- (void)senderButtonClick:(myBlock)block;
@end
