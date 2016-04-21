//
//  ShouhuoDizhiTableViewCell.m
//  农帮乐
//
//  Created by hpz on 15/12/14.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "ShouhuoDizhiTableViewCell.h"
#import "ZengjiaDizhiViewController.h"
@implementation ShouhuoDizhiTableViewCell
{
    UIImageView *_bgIamgeView;
    NSString *_sheng;
    NSString *_shi;
    NSString *_qu;
    NSString *_jiedao;
    NSString *_ConsigneeId;
    
    JQBaseRequest *_JQRequest;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = BaseColor(236, 236, 236, 1);
        
        _bgIamgeView = [[UIImageView alloc]init];
        _bgIamgeView.image = [UIImage imageWithData:UIImagePNGRepresentation([UIImage imageNamed:@"zy_bg（农场直供-带线）.jpg"])];
        _bgIamgeView.userInteractionEnabled = YES;
        [self.contentView addSubview:_bgIamgeView];
        
        [self createUI];
    }
    return self;
}
- (void)createUI {
    
    
    _JQRequest = [[JQBaseRequest alloc] init];
    
    _name = [[UILabel alloc] init];
    _name.textColor = BaseColor(52, 52, 52, 1);
    _name.font = [UIFont systemFontOfSize:18.0];
    [_bgIamgeView addSubview:_name];
    
    _telphone = [[UILabel alloc] init];
    _telphone.textColor = BaseColor(52, 52, 52, 1);
    _telphone.font = [UIFont systemFontOfSize:18.0];
    [_bgIamgeView addSubview:_telphone];
    
    
    _dizhi = [[UILabel alloc] init];
    _dizhi.textColor = BaseColor(105, 105, 105, 1);
    _dizhi.font = [UIFont systemFontOfSize:18.0];
    [_bgIamgeView addSubview:_dizhi];
    
    _morenBtn = [[UIButton alloc] init];
    [_morenBtn setImage:[UIImage imageNamed:@"shdz_radio_nor.png"] forState:UIControlStateNormal];
    [_morenBtn setImage:[UIImage imageNamed:@"shdz_radio_sel.png"] forState:UIControlStateSelected];
    [_morenBtn setTitleColor:BaseColor(52, 52, 52, 52) forState:UIControlStateNormal];
    [_morenBtn addTarget:self action:@selector(setMoRen:) forControlEvents:UIControlEventTouchUpInside];
    [_bgIamgeView addSubview:_morenBtn];
    
    
    _morenLabel = [[UILabel alloc]init];
    _morenLabel.textColor = BaseColor(52, 52, 52, 1);
    _morenLabel.text = NSLocalizedString(@"The default address", @"");
    [_bgIamgeView addSubview:_morenLabel];
    
    _editBtn = [[UIButton alloc] init];
    [_editBtn setBackgroundImage:[UIImage imageNamed:@"shdz1-1_btn_bianji.png"] forState:UIControlStateNormal];
    [_editBtn addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    [_bgIamgeView addSubview:_editBtn];
    
    _deleteBtn = [[UIButton alloc] init];
    [_deleteBtn setBackgroundImage:[UIImage imageNamed:@"shdz1-1_btn_shanchu.png"] forState:UIControlStateNormal];
    [_deleteBtn addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
    [_bgIamgeView addSubview:_deleteBtn];


}
- (void)delete {
    
    [_JQRequest deleteShouHuoRenWithConsigneeId:_ConsigneeId Complete:^(NSDictionary *responseObject) {
        NSLog(@"删除成功%@",responseObject);
        
    } fail:^(NSError *error, NSString *errorString) {
        NSLog(@"%@",errorString);
        UILabel *label = [[UILabel alloc] init];
        CGSize size = [errorString sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(999, 100)];
        NSLog(@"%@",NSStringFromCGSize(size));
        if (size.width >= 990) {
            size.height = size.height * 0.5;
        }
        NSInteger count = 1;
        CGFloat width = size.width;
        for (NSInteger i = 0; width >= 632 * scaleWidth; i++) {
            count++;
            width -= 632 * scaleWidth;
        }
        if (count > 1) {
            label.frame = CGRectMake(20 * scaleWidth, 1200 * scaleHeight - 64, 680 * scaleWidth, size.height * count);
        }
        else {
            
            label.frame = CGRectMake(20 * scaleWidth, 1200 * scaleHeight - 64, size.width, size.height);
        }
        label.numberOfLines = 0;
        label.backgroundColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.text = errorString;
        [self.viewController.view addSubview:label];
        [self.viewController.view bringSubviewToFront:label];
        [self performSelector:@selector(removeLabel:) withObject:label afterDelay:2];
    }];

}
- (void)removeLabel:(UILabel *)label {
    [label removeFromSuperview];
}
- (void)edit:(UIButton *)sender {
    
    ZengjiaDizhiViewController *zengjiaDizhiVC = [[ZengjiaDizhiViewController alloc] init];
    
    zengjiaDizhiVC.nameStr = _name.text;
    zengjiaDizhiVC.telphoneStr = _telphone.text;
    zengjiaDizhiVC.shengStr = _sheng;
    zengjiaDizhiVC.shiStr = _shi;
    zengjiaDizhiVC.quStr = _qu;
    zengjiaDizhiVC.jiedaoStr = _jiedao;
    zengjiaDizhiVC.isXiuGai = YES;
    zengjiaDizhiVC.ConsigneeId = [NSString stringWithFormat:@"%ld", (long)sender.tag];
    zengjiaDizhiVC.isMoRenDiZhi = _morenBtn.selected;
    [self.viewController.navigationController pushViewController:zengjiaDizhiVC animated:YES];

}
- (void)setMoRen:(UIButton *)sender {
    
    //sender.selected = !sender.selected;

}
- (void)configWithDictiongary:(NSDictionary *)dict {
    
    NSDictionary *ConsigneeDict = dict[@"Consignee"];
    
    //收货人
    CGSize nameSize = [[NSString stringWithFormat:@"%@",ConsigneeDict[@"name"]] sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(999, 100)];
    _name.frame = CGRectMake(40 * scaleWidth, 40 * scaleHeight, nameSize.width, nameSize.height);
    _name.text = [NSString stringWithFormat:@"%@",ConsigneeDict[@"name"]];
    
    //收货人手机号
    CGSize telSize = [[NSString stringWithFormat:@"%@",ConsigneeDict[@"telephone"]] sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(999, 100)];
    _telphone.frame = CGRectMake(632 * scaleWidth - telSize.width, 40 * scaleHeight, telSize.width, telSize.height);
    _telphone.text = [NSString stringWithFormat:@"%@",ConsigneeDict[@"telephone"]];
    
    //收货人地址
    CGSize dizhiSize = [[NSString stringWithFormat:@"%@%@%@%@",ConsigneeDict[@"province"], ConsigneeDict[@"city"], ConsigneeDict[@"district"], ConsigneeDict[@"address"]] sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(990, 100)];
    
    if (dizhiSize.width >= 990) {
        dizhiSize.height = dizhiSize.height * 0.5;
    }
    CGFloat width = dizhiSize.width;
    NSInteger count = 1;
    for (NSInteger i = 0; width >= 592 * scaleHeight; i++) {
        count++;
        width -= 592 * scaleHeight;
    }
    if (count > 1) {
        _dizhi.frame = CGRectMake(40 * scaleWidth, 60 * scaleHeight + nameSize.height, 632 * scaleWidth, dizhiSize.height * count);
    }
    else {
        
        _dizhi.frame = CGRectMake(40 * scaleWidth, 60 * scaleHeight + nameSize.height, dizhiSize.width, dizhiSize.height);
    }
    _dizhi.numberOfLines = 0;
    _dizhi.text = [NSString stringWithFormat:@"%@%@%@%@",ConsigneeDict[@"province"], ConsigneeDict[@"city"], ConsigneeDict[@"district"], ConsigneeDict[@"address"]];

    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 100 * scaleHeight + nameSize.height + dizhiSize.height * count - 1, 672 * scaleWidth, 1)];
    line.backgroundColor = BaseColor(242, 242, 242, 1);
    [_bgIamgeView addSubview:line];
    
    
    
    _morenBtn.frame = CGRectMake(40 * scaleWidth, 120 * scaleHeight + nameSize.height + dizhiSize.height * count, 38 * scaleWidth, 38 *scaleHeight);
    CGSize morenSize = [NSLocalizedString(@"The default address", @"") sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(999, 100)];
    _morenLabel.frame = CGRectMake(98 * scaleWidth, 120 * scaleHeight + nameSize.height + dizhiSize.height * count, morenSize.width, morenSize.height);
    
    _editBtn.frame = CGRectMake(336 * scaleWidth, 100 * scaleHeight + nameSize.height + dizhiSize.height * count, 168 * scaleWidth, 78 * scaleHeight);
    _editBtn.tag = [[NSString stringWithFormat:@"%@",ConsigneeDict[@"id"]] integerValue];
    
    _deleteBtn.frame = CGRectMake(504 * scaleWidth, 100 * scaleHeight + nameSize.height + dizhiSize.height * count, 168 * scaleWidth, 78 * scaleHeight);
    
    _bgIamgeView.frame = CGRectMake(24 * scaleWidth, 20 * scaleHeight, Screen_Width - 48 * scaleWidth, 178 * scaleHeight + nameSize.height + dizhiSize.height * count);
    
    if ([ConsigneeDict[@"isdefault"] isEqualToString:@"true"] == YES) {
        _morenBtn.selected = YES;
    }

    _sheng = [NSString stringWithFormat:@"%@",ConsigneeDict[@"province"]];
    _shi = [NSString stringWithFormat:@"%@",ConsigneeDict[@"city"]];
    _qu = [NSString stringWithFormat:@"%@",ConsigneeDict[@"district"]];
    _jiedao = [NSString stringWithFormat:@"%@",ConsigneeDict[@"address"]];
    _ConsigneeId = [NSString stringWithFormat:@"%@",ConsigneeDict[@"id"]];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
