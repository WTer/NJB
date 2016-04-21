//
//  ShuLiangTableViewCell.h
//  农帮乐
//
//  Created by hpz on 15/12/11.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShuLiangTableViewCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *numTF;
@property (nonatomic, strong) UIViewController *viewController;


@end
