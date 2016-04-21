//
//  YouHuiQuanYouXiaoZhongTableViewCell.m
//  农家帮
//
//  Created by Mac on 16/3/27.
//  Copyright © 2016年 jingqi. All rights reserved.
//

#import "YouHuiQuanYouXiaoZhongTableViewCell.h"

@implementation YouHuiQuanYouXiaoZhongTableViewCell
{
    UIView *_shanchuyouhuiquanView;
    
    JQBaseRequest *_jqRequest;
    
    UILabel *_youhuijia;
    UILabel *_shangpin;
    UILabel *_keyong;
    UILabel *_shijian;
    
    
    NSString *_CouponsId;
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _youhuiquanView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 280 * scaleHeight)];
        _youhuiquanView.contentSize = CGSizeMake(Screen_Width + 140 * scaleWidth, 280 * scaleHeight);
        _youhuiquanView.showsHorizontalScrollIndicator = NO;
        _youhuiquanView.bounces = NO;
        _youhuiquanView.pagingEnabled = YES;
        _youhuiquanView.backgroundColor = [UIColor whiteColor];
        _youhuiquanView.userInteractionEnabled = YES;
        [self.contentView addSubview:_youhuiquanView];
        
        _jqRequest = [[JQBaseRequest alloc] init];
        
        //删除 修改按钮
        UIButton *shanchu = [[UIButton alloc] initWithFrame:CGRectMake(Screen_Width, 20 * scaleHeight, 120 * scaleWidth, 102 * scaleHeight)];
        [shanchu setBackgroundImage:[UIImage imageNamed:@"zjhh_btn_shanchu_up.png"] forState:UIControlStateNormal];
        [shanchu setTitle:@"删除" forState:UIControlStateNormal];
        [shanchu addTarget:self action:@selector(shanchu) forControlEvents:UIControlEventTouchUpInside];
        [_youhuiquanView addSubview:shanchu];
        
        UIButton *xiugai = [[UIButton alloc] initWithFrame:CGRectMake(Screen_Width, 132 * scaleHeight, 120 * scaleWidth, 102 * scaleHeight)];
        [xiugai setBackgroundImage:[UIImage imageNamed:@"zjhh_btn_xiugai_up.png"] forState:UIControlStateNormal];
        [xiugai setTitle:@"修改" forState:UIControlStateNormal];
        [xiugai setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [xiugai addTarget:self action:@selector(xiugai) forControlEvents:UIControlEventTouchUpInside];
        [_youhuiquanView addSubview:xiugai];

        
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(49 * scaleWidth, 20 * scaleHeight, 623 * scaleWidth, 232 * scaleHeight)];
        imageView.image = [UIImage imageNamed:@"zjhb_ico_youhuijuan_youxiaozhong.jpg"];
        [_youhuiquanView addSubview:imageView];
        
        UIImageView *zhangImageView = [[UIImageView alloc] initWithFrame:CGRectMake(490 * scaleWidth, 20 * scaleHeight, 159 * scaleWidth, 176 * scaleHeight)];
        zhangImageView.image = [UIImage imageNamed:@"zjhh_ico_tuzhang_weishiyongHB.png"];
        [_youhuiquanView addSubview:zhangImageView];
        
        UIImageView *jiantouImageView = [[UIImageView alloc] initWithFrame:CGRectMake(680 * scaleWidth, 100 * scaleHeight, 25 * scaleWidth, 47 * scaleHeight)];
        jiantouImageView.image = [UIImage imageNamed:@"zjhb_btn_jiantou.jpg"];
        [_youhuiquanView addSubview:jiantouImageView];
        
        _youhuijia = [[UILabel alloc] initWithFrame:CGRectMake(84 * scaleWidth, 73 * scaleHeight, 250 * scaleWidth, 70 * scaleHeight)];
        _youhuijia.font = [UIFont boldSystemFontOfSize:27.0];
        //_youhuijia.adjustsFontSizeToFitWidth = YES;
        _youhuijia.textColor = BaseColor(71, 176, 218, 1);
        [imageView addSubview:_youhuijia];
        
        
        
        _shangpin = [[UILabel alloc] initWithFrame:CGRectMake(400 * scaleWidth, 35 * scaleHeight, 175 * scaleWidth, 70 * scaleHeight)];
        _shangpin.font = [UIFont systemFontOfSize:16.0];
        _shangpin.textColor = BaseColor(0, 0, 0, 1);
        
        _shangpin.textAlignment = NSTextAlignmentCenter;
        [imageView addSubview:_shangpin];
        
        _keyong = [[UILabel alloc] initWithFrame:CGRectMake(400 * scaleWidth, 107 * scaleHeight, 175 * scaleWidth, 70 * scaleHeight)];
        _keyong.font = [UIFont systemFontOfSize:16.0];
        _keyong.textColor = BaseColor(0, 0, 0, 1);
        _keyong.text = @"满200可用";
        _keyong.textAlignment = NSTextAlignmentCenter;
        [imageView addSubview:_keyong];
        
        
        
        
        UILabel *tishi = [[UILabel alloc] initWithFrame:CGRectMake(75 * scaleWidth, 217 * scaleHeight, 300 * scaleWidth, 25 * scaleHeight)];
        tishi.font = [UIFont systemFontOfSize:9.0];
        tishi.textColor = BaseColor(66, 66, 66, 1);
        tishi.text = NSLocalizedString(@"This coupon is only for this product before use", @"");
        [_youhuiquanView addSubview:tishi];
        
        _shijian = [[UILabel alloc] initWithFrame:CGRectMake(400 * scaleWidth, 217 * scaleHeight, 270 * scaleWidth, 25 * scaleHeight)];
        _shijian.font = [UIFont systemFontOfSize:9.0];
        _shijian.textColor = BaseColor(66, 66, 66, 1);
        _shijian.text = @"2016.03.18-2016.03.30";
        [_youhuiquanView addSubview:_shijian];
        
    }
    return self;
}

- (void)shanchu {

    self.viewController.tableView.alpha = 0.1;
    self.viewController.tableView.userInteractionEnabled = NO;
    
    _shanchuyouhuiquanView = [[UIView alloc] initWithFrame:CGRectMake(40 * scaleWidth, 350 * scaleHeight, 640 * scaleWidth, 320 * scaleHeight)];
    _shanchuyouhuiquanView.backgroundColor = [UIColor whiteColor];
    [self.viewController.view addSubview:_shanchuyouhuiquanView];
    
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 640 * scaleWidth, 1)];
    line1.backgroundColor = BaseColor(233, 233, 233, 1);
    [_shanchuyouhuiquanView addSubview:line1];
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 400 * scaleHeight - 1, 640 * scaleWidth, 1)];
    line2.backgroundColor = BaseColor(233, 233, 233, 1);
    [_shanchuyouhuiquanView addSubview:line2];
    
    
    
    UILabel *tishi = [[UILabel alloc] initWithFrame:CGRectMake(0, 60 * scaleHeight, 640 * scaleWidth, 80 * scaleHeight)];
    tishi.font = [UIFont systemFontOfSize:16.0];
    tishi.textColor = BaseColor(38, 38, 38, 1);
    tishi.text = NSLocalizedString(@"Confirm to delete this coupon?", @"");
    tishi.textAlignment = NSTextAlignmentCenter;
    [_shanchuyouhuiquanView addSubview:tishi];
    
    
    
    UIButton *queding = [[UIButton alloc] initWithFrame:CGRectMake(80 * scaleWidth, 200 * scaleHeight, 220 * scaleWidth, 80 * scaleHeight)];
    [queding setBackgroundImage:[UIImage imageNamed:@"chxq_btn_queding_down.png"] forState:UIControlStateNormal];
    [queding setTitle:NSLocalizedString(@"OK", "") forState:UIControlStateNormal];
    [queding addTarget:self action:@selector(queding) forControlEvents:UIControlEventTouchUpInside];
    [_shanchuyouhuiquanView addSubview:queding];
    
    
    UIButton *quxiao = [[UIButton alloc] initWithFrame:CGRectMake(340 * scaleWidth, 200 * scaleHeight, 220 * scaleWidth, 80 * scaleHeight)];
    [quxiao setBackgroundImage:[UIImage imageNamed:@"chxq_btn_quxiao_up.png"] forState:UIControlStateNormal];
    [quxiao setTitle:NSLocalizedString(@"CANCLE", "") forState:UIControlStateNormal];
    [quxiao setTitleColor:BaseColor(13, 185, 58, 1) forState:UIControlStateNormal];
    [quxiao addTarget:self action:@selector(quxiao) forControlEvents:UIControlEventTouchUpInside];
    [_shanchuyouhuiquanView addSubview:quxiao];
    
    
    
    
}

- (void)xiugai {


}
- (void)quxiao {
    
    self.viewController.tableView.alpha = 1;
    self.viewController.tableView.userInteractionEnabled = YES;
    [_shanchuyouhuiquanView removeFromSuperview];

}
- (void)queding {
    
    self.viewController.tableView.alpha = 1;
    self.viewController.tableView.userInteractionEnabled = YES;
    [_shanchuyouhuiquanView removeFromSuperview];
    
    
    [_jqRequest ShanChuYouHuiQuanWithCouponsId:_CouponsId complete:^(NSDictionary *responseObject) {
        
        CGSize size = [NSLocalizedString(@"Coupon was removed successfully", @"") sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(999, 100)];
        CGFloat labelX = (720 * scaleWidth - size.width) / 2 ;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, 1200 * scaleHeight - 64, size.width, size.height)];
        label.backgroundColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.text = NSLocalizedString(@"Coupon was removed successfully", @"");
        [self.viewController.view addSubview:label];
        [self.viewController.view bringSubviewToFront:label];
        [self performSelector:@selector(removeLabel:) withObject:label afterDelay:1];
        
        
        
        
    } fail:^(NSError *error, NSString *errorString) {
        
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:errorString preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
            
            
            
        }];
        [alertController addAction:otherAction];
        [self.viewController presentViewController:alertController animated:YES completion:nil];
        
    }];
    
    [self.viewController.tableView reloadData];
    
}
- (void) removeLabel:(UILabel *)label {

    [label removeFromSuperview];
}
- (void)configWithDictionary:(NSDictionary *)dict {

    _youhuijia.text = [NSString stringWithFormat:@"%@",dict[@"amount"]];
    _shangpin.text = [NSString stringWithFormat:@"%@",dict[@"name"]];
    
    _CouponsId = [NSString stringWithFormat:@"%@",dict[@"id"]];
    
    NSArray *startTimeArray = [[NSString stringWithFormat:@"%@",dict[@"starttime"]] componentsSeparatedByString:@" "];
    NSArray *expirationTimeArray = [[NSString stringWithFormat:@"%@",dict[@"expirationtime"]] componentsSeparatedByString:@" "];
    if (startTimeArray.count == 2 && expirationTimeArray.count == 2) {
        
        _shijian.text = [NSString stringWithFormat:@"%@-%@",startTimeArray[0],expirationTimeArray[0]];
        
    }
    
    
    
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
