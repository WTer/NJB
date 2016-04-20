//
//  wodeButton.h
//  农帮乐
//
//  Created by 王朝源 on 15/12/5.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ButtonBlock)(UIButton * button);
@interface wodeButton : UIView

@property(nonatomic, copy)ButtonBlock action;
@property (nonatomic, copy)NSString * numberText;
-(instancetype)init;
- (void)setNumber:(NSString *)number Name:(NSString *)name Frame:(CGRect)frame Action:(ButtonBlock)actionblock;

@end
