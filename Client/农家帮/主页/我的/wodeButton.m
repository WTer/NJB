//
//  wodeButton.m
//  农帮乐
//
//  Created by 王朝源 on 15/12/5.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "wodeButton.h"
#import "Masonry.h"
@implementation wodeButton
{
    UILabel * lable1;
    UILabel * lable2;
    UIButton * button;
}
-(instancetype)init
{
    if (self = [super init]) {
        lable1 = [[UILabel alloc]init];
        lable2 = [[UILabel alloc]init];
        button = [[UIButton alloc]init];
        [self addSubview:lable1];
        [self addSubview:lable2];
         [self addSubview:button];
    }
    return self;
}
- (void)setNumber:(NSString *)number Name:(NSString *)name Frame:(CGRect)frame Action:(ButtonBlock)actionblock
{
    self.frame = frame;
    _action = actionblock;
    lable1.textAlignment = NSTextAlignmentCenter;
    lable1.textColor = BaseColor(52, 52, 52, 1);
    lable1.font = [UIFont systemFontOfSize:18];
    lable1.text = number;
    [lable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(21);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
//        make.bottom.mas_equalTo(lable2.mas_top).offset(scaleHeight * -26);
        make.top.mas_equalTo(26 * scaleHeight);
    }];
    lable1.adjustsFontSizeToFitWidth = YES;
    

    lable2.textAlignment = NSTextAlignmentCenter;
    lable2.textColor = BaseColor(52, 52, 52, 1);
    lable2.font = [UIFont systemFontOfSize:16.0];
    lable2.text = name;
    lable2.backgroundColor = [UIColor whiteColor];
    lable2.adjustsFontSizeToFitWidth = YES;
    [lable2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(21);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottom).offset(scaleHeight * -20);
    }];
    button.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
}

- (void)click
{
    _action(button);
}
-(void)setNumberText:(NSString *)numberText
{
    lable1.text = numberText;
}

@end
