//
//  GuanZhuFenSiTableViewCell.m
//  农家帮
//
//  Created by Mac on 16/4/6.
//  Copyright © 2016年 jingqi. All rights reserved.
//

#import "GuanZhuFenSiTableViewCell.h"
#import "GuanZhuFenSiViewController.h"

@implementation GuanZhuFenSiTableViewCell
{
    UIView *_mainView;
    UIView *_guanzhuView;
    JQBaseRequest *_jqRequest;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _jqRequest = [[JQBaseRequest alloc] init];
        
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 150 * scaleHeight)];
        _mainView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_mainView];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 150 * scaleHeight - 1, Screen_Width, 1)];
        line.backgroundColor = BaseColor(233, 233, 233, 1);
        [_mainView addSubview:line];
        
        
        _image = [[UIImageView alloc] initWithFrame:CGRectMake(18 * scaleWidth, 16 * scaleHeight, 110 * scaleWidth, 110 * scaleWidth)];
        _image.layer.cornerRadius = 55 * scaleWidth;
        [_mainView addSubview:_image];
        
        
        
        
        _name = [[UILabel alloc] initWithFrame:CGRectMake(145 * scaleWidth, 50 * scaleHeight, 300 * scaleWidth, 50 * scaleHeight)];
        _name.font = [UIFont systemFontOfSize:16.0];
        _name.textColor = BaseColor(43, 43, 43, 1);
        [_mainView addSubview:_name];
        
        _renzhengbiaozhi = [[UIImageView alloc] initWithFrame:CGRectMake(455 * scaleWidth, 58 * scaleHeight, 30 * scaleWidth, 40 * scaleHeight)];
        [_mainView addSubview:_renzhengbiaozhi];
        
        
        //我关注的卖家的状态
        UIButton *guanzhuBtn = [[UIButton alloc]initWithFrame:CGRectMake(Screen_Width - 120 * scaleWidth, 40 * scaleHeight, 100 * scaleWidth, 70 * scaleHeight)];
        [guanzhuBtn setBackgroundImage:[UIImage imageNamed:@"fsgz_btn_yiguanzhu.png"] forState:UIControlStateNormal];
        [guanzhuBtn addTarget:self action:@selector(guanzhu) forControlEvents:UIControlEventTouchUpInside];
        [_mainView addSubview:guanzhuBtn];
        
    }
    return self;
}
- (void)guanzhu {
    
    self.viewController.tableView.alpha = 0.1;
    self.viewController.tableView.userInteractionEnabled = NO;
    
    
    _guanzhuView = [[UIView alloc] initWithFrame:CGRectMake(0, Screen_Height - 64 - 363 * scaleHeight, Screen_Width, 363 * scaleHeight)];
    _guanzhuView.backgroundColor = BaseColor(233, 233, 233, 1);
    [self.viewController.view addSubview:_guanzhuView];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 1)];
    line.backgroundColor = BaseColor(233, 233, 233, 1);
    [_guanzhuView addSubview:line];
    
    
    
    UIButton *siliao = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 110 * scaleHeight)];
    siliao.backgroundColor = [UIColor whiteColor];
    [siliao setTitle:NSLocalizedString(@"Private chat messages", @"") forState:UIControlStateNormal];
    [siliao setTitleColor:BaseColor(43, 43, 43, 1) forState:UIControlStateNormal];
    [siliao addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [_guanzhuView addSubview:siliao];
    UILabel *siliaoLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 110 * scaleHeight - 1, Screen_Width, 1)];
    siliaoLine.backgroundColor = BaseColor(233, 233, 233, 1);
    [siliao addSubview:siliaoLine];
    
    UIButton *quxiaoguanzhu = [[UIButton alloc] initWithFrame:CGRectMake(0, 110 * scaleHeight, Screen_Width, 110 * scaleHeight)];
    quxiaoguanzhu.backgroundColor = [UIColor whiteColor];
    [quxiaoguanzhu setTitleColor:BaseColor(43, 43, 43, 1) forState:UIControlStateNormal];
    [quxiaoguanzhu setTitle:NSLocalizedString(@"Cancel the attention", @"") forState:UIControlStateNormal];
    [quxiaoguanzhu addTarget:self action:@selector(quxiaoguanzhu) forControlEvents:UIControlEventTouchUpInside];
    [_guanzhuView addSubview:quxiaoguanzhu];
    
    
    
    UIButton *cancle = [[UIButton alloc] initWithFrame:CGRectMake(0, 253 * scaleHeight, Screen_Width, 110 * scaleHeight)];
    cancle.backgroundColor = [UIColor whiteColor];
    [cancle setTitleColor:BaseColor(43, 43, 43, 1) forState:UIControlStateNormal];
    [cancle setTitle:NSLocalizedString(@"CANCLE", @"") forState:UIControlStateNormal];
    [cancle addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [_guanzhuView addSubview:cancle];
    
    
    
}
- (void)setModel:(XiaoFeiZheModel *)model {
    _model = model;
    [self.image sd_setImageWithURL:[NSURL URLWithString:model.smallportraiturl]];
    _name.text = model.displayname;
}

- (void)action:(UIControl *)sender {
    if (_delegate) {
        [_delegate yaoQingXiaoFeiZheCell:self];
    }
}

- (void)cancle {
    
    self.viewController.tableView.alpha = 1;
    self.viewController.tableView.userInteractionEnabled = YES;
    [_guanzhuView removeFromSuperview];
    
}

- (void)quxiaoguanzhu {
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [_jqRequest MaiJia4QuXiaoGuanZhuMaiJia4WithProducerId:[NSString stringWithFormat:@"%@",[ud objectForKey:@"ProducerId"]] FollowProducerId:self.producerId complete:^(NSDictionary *responseObject) {
        
        CGSize size = [NSLocalizedString(@"Remove focus on success", @"") sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(999, 100)];
        CGFloat labelX = (720 * scaleWidth - size.width) / 2 ;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, 1200 * scaleHeight - 64, size.width, size.height)];
        label.backgroundColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.text = NSLocalizedString(@"Remove focus on success", @"");
        [self.viewController.view addSubview:label];
        [self.viewController.view bringSubviewToFront:label];
        [self performSelector:@selector(removeLabel:) withObject:label afterDelay:1];
        
        
        self.viewController.tableView.alpha = 1;
        self.viewController.tableView.userInteractionEnabled = YES;
        [_guanzhuView removeFromSuperview];
        
        
    } fail:^(NSError *error, NSString *errorString) {
        
        UIAlertController*alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:errorString preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
            
            
            self.viewController.tableView.alpha = 1;
            self.viewController.tableView.userInteractionEnabled = YES;
            [_guanzhuView removeFromSuperview];
            
        }];
        
        [alertController addAction:otherAction];
        [self.viewController presentViewController:alertController animated:YES completion:nil];
        
    }];
    
    
    
    
}
- (void)removeLabel:(UILabel *)label {
    
    [label removeFromSuperview];
}
- (void)configWithDictionary:(NSDictionary *)dict {
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:dict[@"PortraitUrl"]]];
    _name.text = [NSString stringWithFormat:@"%@",dict[@"Name"]];
    
    self.producerId = [NSString stringWithFormat:@"%@",dict[@"Id"]];
    self.nameString = [NSString stringWithFormat:@"%@",dict[@"Name"]];
    self.touxiangString = [NSString stringWithFormat:@"%@",dict[@"PortraitUrl"]];
    
    
    //我关注的卖家接口中没有认证标志
    
    _renzhengbiaozhi.image = [UIImage imageNamed:@"V标_icon.png"];
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
