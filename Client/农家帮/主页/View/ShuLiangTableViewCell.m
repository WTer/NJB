//
//  ShuLiangTableViewCell.m
//  农帮乐
//
//  Created by hpz on 15/12/11.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "ShuLiangTableViewCell.h"
#import "LiuYanBanViewController.h"

@implementation ShuLiangTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createUI];
    }
    return self;
}
- (void)createUI {
    
    CGSize size = [NSLocalizedString(@"NUMBER", @"") sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(999, 100)];
    UIButton *jianBtn = [[UIButton alloc] initWithFrame:CGRectMake(44 * scaleWidth + size.width, 40 * scaleHeight, 80 * scaleWidth, 80 * scaleHeight)];
    [jianBtn setBackgroundImage:[[UIImage imageNamed:@"cpxq2_btn_-.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [jianBtn addTarget:self action:@selector(jian) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:jianBtn];
    
    
    
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([ud boolForKey:@"IsConsumer"]) {
        
        UIButton *liuyanBtn = [[UIButton alloc] initWithFrame:CGRectMake(450 * scaleWidth + size.width, 40 * scaleHeight, 180 * scaleWidth, 60 * scaleHeight)];
        liuyanBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        liuyanBtn.layer.cornerRadius = 2;
        liuyanBtn.layer.borderColor = [UIColor purpleColor].CGColor;
        liuyanBtn.layer.borderWidth = 2;
        [liuyanBtn setTitle:@"给卖家留言" forState:UIControlStateNormal];
        [liuyanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [liuyanBtn addTarget:self action:@selector(liuyan) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:liuyanBtn];
    }
    
    
    _numTF = [[UITextField alloc] initWithFrame:CGRectMake(124 * scaleWidth + size.width, 40 * scaleHeight, 160 * scaleWidth, 80 * scaleHeight)];
    _numTF.background = [UIImage imageNamed:@"cpxq2_input.png"];
    _numTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _numTF.text = @"0";
    _numTF.delegate = self;
    _numTF.textColor = BaseColor(52, 52, 52, 1);
    _numTF.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_numTF];
    
    UIButton *jiaBtn = [[UIButton alloc] initWithFrame:CGRectMake(284 * scaleWidth + size.width, 40 * scaleHeight, 80 * scaleWidth, 80 * scaleHeight)];
    [jiaBtn setBackgroundImage:[UIImage imageNamed:@"cpxq2_btn_+.png"] forState:UIControlStateNormal];
    [jiaBtn addTarget:self action:@selector(jia) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:jiaBtn];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 160 * scaleHeight - 1, Screen_Width, 1)];
    label.backgroundColor = BaseColor(242, 242, 242, 1);
    [self.contentView addSubview:label];

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [_numTF resignFirstResponder];
    return YES;
}
- (void)liuyan {

    LiuYanBanViewController *liuyanbanVC = [[LiuYanBanViewController alloc] init];
    [self.viewController.navigationController pushViewController:liuyanbanVC animated:YES];
    
    
}
//减
- (void)jian {
   
    if ([_numTF.text integerValue] >=1) {
        _numTF.text = [NSString stringWithFormat:@"%ld", (long)[_numTF.text integerValue] - 1];
    }
    if ([_numTF.text integerValue] ==0) {
        _numTF.text = @"0";
    }    
}
//加
- (void)jia {

    _numTF.text = [NSString stringWithFormat:@"%ld", (long)[_numTF.text integerValue] + 1];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
