//
//  MyCommentTableViewCell.h
//  农帮乐
//
//  Created by 王朝源 on 15/12/10.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class myCommentModel;
@interface MyCommentTableViewCell : UITableViewCell

@property (nonatomic ,strong)myCommentModel * model;
- (void)DTsetyueshu:(myCommentModel *)model;
@end
