//
//  MainTableViewCell.m
//  农帮乐
//
//  Created by hpz on 15/12/3.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "MainTableViewCell.h"
#import "UMSocial.h"
#import <ShareSDK/ShareSDK.h>
#import "DetailViewController.h"


@implementation MainTableViewCell
{
    UIImageView *_bgIamgeView;
    
    NSArray *_ProductImages;
    NSDictionary *_ProductInfo;
    NSDictionary *_ProducerInfo;
    
    JQBaseRequest *_jqRequest;
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = BaseColor(242, 242, 242, 1);
        
        _bgIamgeView = [[UIImageView alloc]initWithFrame:CGRectMake(24 * scaleWidth, 20 * scaleHeight, Screen_Width - 48 * scaleWidth, 560 * scaleHeight)];
        _bgIamgeView.image = [UIImage imageWithData:UIImagePNGRepresentation([UIImage imageNamed:@"zy_bg（农场直供-带线）.jpg"])];
        
        
        _bgIamgeView.userInteractionEnabled = YES;
        [self.contentView addSubview:_bgIamgeView];
        
        [self createUI];
    }
    return self;
}
- (void)createUI {
    
    _jqRequest = [[JQBaseRequest alloc] init];
    
    
    _icon = [[UIImageView alloc] init];
    _icon.layer.cornerRadius = 30 * scaleWidth;
    _icon.layer.masksToBounds = YES;
    [_bgIamgeView addSubview:_icon];
    //代码给_icon添加约束
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20 * scaleWidth);
        make.top.mas_equalTo(20 * scaleHeight);
        make.size.mas_equalTo(CGSizeMake(60 * scaleWidth, 60 * scaleHeight));
        
    }];

    //昵称的size是400 * 100;
    _niChengLabel = [[UILabel alloc] init];
    _niChengLabel.font = [UIFont systemFontOfSize:18];
    _niChengLabel.adjustsFontSizeToFitWidth = YES;
    _niChengLabel.textColor = BaseColor(52, 52, 52, 1);
    [_bgIamgeView addSubview:_niChengLabel];
    //代码给_niChengLabel添加约束
    [_niChengLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_icon.mas_right).offset(20 * scaleWidth);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(210 * scaleWidth, 100 * scaleHeight));
        
    }];
    
    //认证标志
    _renzhengImage = [[UIImageView alloc] init];
    
//    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    [_jqRequest chaXunShiMimgRenZhengWith:[NSString stringWithFormat:@"%@",[ud objectForKey:@"ProducerId"]] complete:^(NSDictionary *responseObject) {
//        
//        NSLog(@"认证:%@",responseObject);
//        _renzhengImage.image = [UIImage imageNamed:@"V标_icon.png"];
//        
//    } fail:^(NSError *error, NSString *errorString) {
//        //_renzhengImage.backgroundColor = [UIColor redColor];
//        _renzhengImage.image = [UIImage imageNamed:@"V标_icon.png"];
//        //NSLog(@"未认证:%@",errorString);
//        
//    }];

    [_bgIamgeView addSubview:_renzhengImage];
    [_renzhengImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_niChengLabel.mas_right).offset(15 * scaleWidth);
        make.top.mas_equalTo(35 * scaleHeight);
        make.size.mas_equalTo(CGSizeMake(35 * scaleWidth, 35 * scaleHeight));
        
    }];

    
    
    //_picScrollView写死了不用添加约束
    _picScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(20 * scaleWidth, 100 * scaleHeight, 652 * scaleWidth, 220 * scaleHeight)];
    
    _picScrollView.showsHorizontalScrollIndicator = NO;
    _picScrollView.bounces = NO;
    [_bgIamgeView addSubview:_picScrollView];
    
    //时间Label
    _timeLabel = [[UILabel alloc] init];
    [_bgIamgeView addSubview:_timeLabel];
    //代码给_timeLabel添加约束
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20 * scaleWidth);
        make.bottom.mas_equalTo(_picScrollView.mas_top).offset(-34 * scaleHeight);
        
    }];

    
    //产品名称
    _shuiguoNameLabel = [[UILabel alloc] init];
    _shuiguoNameLabel.textColor = BaseColor(52, 52, 52, 1);
    [_bgIamgeView addSubview:_shuiguoNameLabel];

    
    //产品类型    
    _shuiguoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_shuiguoBtn setTitleColor:BaseColor(14, 184, 58, 1) forState:UIControlStateNormal];
    _shuiguoBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [_shuiguoBtn setBackgroundImage:[UIImage imageWithData:UIImagePNGRepresentation([UIImage imageNamed:@"zy_icon_shuiguo.jpg"])] forState:UIControlStateNormal];
    [_bgIamgeView addSubview:_shuiguoBtn];
    
    //产品详情
    _shuiguoDetailLabel = [[UILabel alloc] init];
    _shuiguoDetailLabel.textColor = BaseColor(105, 105, 105, 1);
    _shuiguoDetailLabel.font = [UIFont systemFontOfSize:18.0];
    [_bgIamgeView addSubview:_shuiguoDetailLabel];
    
    //产品价格和运费
    _shuiguoPriceLabel = [[UILabel alloc] init];
    [_bgIamgeView addSubview:_shuiguoPriceLabel];
    

    //分享按钮
    _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_shareBtn setBackgroundImage:[UIImage imageWithData:UIImagePNGRepresentation([UIImage imageNamed:@"zy_btn_fenxiang.jpg"])] forState:UIControlStateNormal];
    [_shareBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [_bgIamgeView addSubview:_shareBtn];
    
    //关注按钮
    _guanzhuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_guanzhuBtn setBackgroundImage:[UIImage imageNamed:@"zy_btn_guanzhu.jpg"] forState:UIControlStateNormal];
    _guanzhuBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    //[_guanzhuBtn setBackgroundImage:[UIImage imageWithData:UIImagePNGRepresentation([UIImage imageNamed:@""])] forState:UIControlStateNormal];
    //[_guanzhuBtn setBackgroundImage:[UIImage imageWithData:UIImagePNGRepresentation([UIImage imageNamed:@""])] forState:UIControlStateSelected];
    [_guanzhuBtn addTarget:self action:@selector(guanzhu) forControlEvents:UIControlEventTouchUpInside];
    [_bgIamgeView addSubview:_guanzhuBtn];
    
    //商品状态按钮
    _shangpinzhuangtaiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _shangpinzhuangtaiBtn.backgroundColor = [UIColor redColor];
    //[_shangpinzhuangtaiBtn setBackgroundImage:[UIImage imageNamed:@"zy_btn_chushouzhong.jpg"] forState:UIControlStateNormal];
    [_shangpinzhuangtaiBtn addTarget:self action:@selector(shangpinzhuangtai:) forControlEvents:UIControlEventTouchUpInside];
    [_bgIamgeView addSubview:_shangpinzhuangtaiBtn];
    
}
- (void)shangpinzhuangtai:(UIButton *)sender {

    sender.selected = !sender.selected;
    
}
- (void)guanzhu {
    
    //先判断网络状态,没网络时可以先从缓存的内容里面读取
    [[JudgeNetState shareInstance]monitorNetworkType:self.viewController.view complete:^(NSInteger state) {
        if (state == 1 || state == 2) {
            
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            if ([ud boolForKey:@"IsConsumer"]) {
                
                NSLog(@"%@  %@",[NSString stringWithFormat:@"%@",[ud objectForKey:@"ConsumerId"]],_ProductInfo[@"producerid"]);
                
              //新增买家关注卖家
              [_jqRequest XinZengMaiJia3GuanZhuMaiJia4WithConsumerId:[NSString stringWithFormat:@"%@",[ud objectForKey:@"ConsumerId"]] ProducerId:[NSString stringWithFormat:@"%@",_ProductInfo[@"producerid"]] complete:^(NSDictionary *responseObject) {
                  
                  CGSize size = [NSLocalizedString(@"Focus on success", @"") sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(999, 100)];
                  CGFloat labelX = (720 * scaleWidth - size.width) / 2 ;
                  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, 1200 * scaleHeight - 64, size.width, size.height)];
                  label.backgroundColor = [UIColor blackColor];
                  label.textAlignment = NSTextAlignmentCenter;
                  label.textColor = [UIColor whiteColor];
                  label.text = NSLocalizedString(@"Focus on success", @"");
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
                
            }
            else {
                //新增卖家关注卖家
                [_jqRequest XinZengMaiJia4GuanZhuMaiJia4WithProducerId:[NSString stringWithFormat:@"%@",[ud objectForKey:@"ProducerId"]] FollowProducerId:[NSString stringWithFormat:@"%@",_ProductInfo[@"producerid"]] complete:^(NSDictionary *responseObject) {
                    
                    CGSize size = [NSLocalizedString(@"Focus on success", @"") sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(999, 100)];
                    CGFloat labelX = (720 * scaleWidth - size.width) / 2 ;
                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, 1200 * scaleHeight - 64, size.width, size.height)];
                    label.backgroundColor = [UIColor blackColor];
                    label.textAlignment = NSTextAlignmentCenter;
                    label.textColor = [UIColor whiteColor];
                    label.text = NSLocalizedString(@"Focus on success", @"");
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
                
                
            }
        }
    }];

}

- (void)removeLabel:(UILabel *)label {
    
    [label removeFromSuperview];

}

- (void)share {
    
    [UMSocialSnsService presentSnsIconSheetView:self.viewController
                                         appKey:@"568b233667e58e19b3001c71"
                                      shareText:@"#农家帮 零污染、零添加、零残留，我们用心从零开始#"
                                     shareImage:nil
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,nil]
                                       delegate:nil];

//    NSString *imagePath=[[NSBundle mainBundle]pathForResource:@"me4s" ofType:@"png"];
//    
//    //构造分享内容
//    id<ISSContent> publishContent = [ShareSDK content:@"#农家帮 零污染、零添加、零残留，我们用心从零开始#"
//                                       defaultContent:@"测试一下"
//                                                image:[ShareSDK imageWithPath:imagePath]
//                                                title:@"#农家帮#"
//                                                  url:@"http://www.NongJiaBang.com.cn/"
//                                          description:@"农家帮是一款你值得拥有的app！ ~~"
//                                            mediaType:SSPublishContentMediaTypeNews];
//    NSArray *shareList = [ShareSDK customShareListWithType:
//                          [NSNumber numberWithInteger:ShareTypeWeixiTimeline],
//                          [NSNumber numberWithInteger:ShareTypeWeixiSession],
//                          [NSNumber numberWithInteger:ShareTypeSinaWeibo],nil];
//    //创建容器
//    id<ISSContainer> container = [ShareSDK container];
//    [container setIPadContainerWithView:self arrowDirect:UIPopoverArrowDirectionUp];
//    
//    
//    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
//                                                         allowCallback:YES
//                                                         authViewStyle:SSAuthViewStyleModal
//                                                          viewDelegate:nil
//                                               authManagerViewDelegate:nil];
//    
//    
//    //弹出分享菜单
//    [ShareSDK showShareActionSheet:container
//                         shareList:shareList
//                           content:publishContent
//                     statusBarTips:YES
//                       authOptions:authOptions
//                      shareOptions:nil
//                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
//                                
//                                if (state == SSResponseStateSuccess)
//                                {
//                                    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"TEXT_ShARE_SUC", @"") preferredStyle:UIAlertControllerStyleAlert];
//                                    UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
//                                        
//                                        
//                                        
//                                    }];
//                                    [alertController addAction:otherAction];
//                                    [self.viewController presentViewController:alertController animated:YES completion:nil];
//                                }
//                                else if (state == SSResponseStateFail)
//                                {
//                                    NSLog(@"%ld %@", (long)[error errorCode], [error errorDescription]);
//                                    NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
//                                    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"TEXT_ShARE_FAI", @"") preferredStyle:UIAlertControllerStyleAlert];
//                                    UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
//                                        
//                                        
//                                        
//                                    }];
//                                    [alertController addAction:otherAction];
//                                    [self.viewController presentViewController:alertController animated:YES completion:nil];
//                                }
//                            }];
    
    
    
}


- (void)configWithDictionary:(NSDictionary *)dict {
    
    _ProducerInfo = dict[@"ProducerInfo"];
    _ProductInfo = dict[@"ProductInfo"];
    _ProductImages = dict[@"ProductImages"];
    
    NSDictionary *ProducerInfoDict = dict[@"ProducerInfo"];
    NSDictionary *ProductInfoDict = dict[@"ProductInfo"];
    //头像
    NSString *iconStr = ProducerInfoDict[@"smallportraiturl"];
    if (iconStr.length) {
        [_icon sd_setImageWithURL:[NSURL URLWithString:iconStr] placeholderImage:[UIImage imageNamed:@""]];
    }
    else {
        _icon.image = [UIImage imageNamed:@"zhuce3_btn_shezhitouxiang_n.png"];
    }
    
    //昵称
    _niChengLabel.text = ProducerInfoDict[@"displayname"];
    
    //时间
    NSDictionary* style = @{@"body" :@[[UIFont fontWithName:@"HelveticaNeue" size:14.0],BaseColor(178, 178, 178, 1)],
                            @"shijian":[UIImage imageWithData:UIImagePNGRepresentation([UIImage imageNamed:@"zy_icon_shijian.jpg"])] };
    TimeString *timeStr = [[TimeString alloc] init];
    //2015-12-18 15:33:25
    _timeLabel.attributedText = [[NSString stringWithFormat:@"<shijian> </shijian>  %@", [timeStr getDayTimeFromLastmodifiedtime:ProductInfoDict[@"lastmodifiedtime"]]]attributedStringWithStyleBook:style];
    
    
    
    //产品图片
    NSArray *ProductImages = dict[@"ProductImages"];
    //3张以上图片
    if (ProductImages.count >= 3) {
        _picScrollView.contentSize = CGSizeMake(240 * scaleWidth * ProductImages.count, 220 * scaleHeight);
        for (NSInteger i = 0; i < ProductImages.count; i++) {
            NSDictionary *imageDict = ProductImages[i];
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(240 * scaleWidth * i, 0, 220 * scaleWidth, 220 * scaleHeight)];
            [button sd_setBackgroundImageWithURL:[NSURL URLWithString:imageDict[@"smallportraiturl"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@""]];
            [button addTarget:self action:@selector(clickImage) forControlEvents:UIControlEventTouchUpInside];
            [_picScrollView addSubview:button];
        }
    }
    else {
        //只有一张图片
        _picScrollView.contentSize = CGSizeMake(240 * scaleWidth * ProductImages.count, 220 * scaleHeight);
        for (NSInteger i = 0; i < ProductImages.count; i++) {
            NSDictionary *imageDict = ProductImages[i];
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(240 * scaleWidth * i, 0, 220 * scaleWidth, 220 * scaleHeight)];
            [button sd_setBackgroundImageWithURL:[NSURL URLWithString:imageDict[@"smallportraiturl"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@""]];
            [button addTarget:self action:@selector(clickImage) forControlEvents:UIControlEventTouchUpInside];
            [_picScrollView addSubview:button];
        }

    }
    
    //产品名称
    _shuiguoNameLabel.text = [NSString stringWithFormat:@"%@",ProductInfoDict[@"name"]];
    CGSize sizeLabel = [_shuiguoNameLabel.text sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(990, 100)];
    if (sizeLabel.width >= 990) {
        sizeLabel.height = sizeLabel.height * 0.5;
    }
    NSInteger count = 1;
    CGFloat width = sizeLabel.width;
    for (NSInteger i = 0; width >= 632 * scaleWidth; i++) {
        count++;
        width -= 632 * scaleWidth;
    }
    if (count > 1) {
        _shuiguoNameLabel.frame = CGRectMake(20 * scaleWidth, 340 * scaleHeight, 632 * scaleWidth, sizeLabel.height * count);
    }
    else {
        
        _shuiguoNameLabel.frame = CGRectMake(20 * scaleWidth, 340 * scaleHeight, sizeLabel.width, sizeLabel.height);
    }
    _shuiguoNameLabel.numberOfLines = 0;

    
    
    //产品类型
    [_shuiguoBtn setTitle:ProductInfoDict[@"type"] forState:UIControlStateNormal];
    CGSize sizeBtn = [_shuiguoBtn.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:16.0] maxSize:CGSizeMake(999, 1000)];
    if ((sizeBtn.width + 10 * scaleWidth) > Screen_Width - 168 * scaleWidth) {
        _shuiguoBtn.frame = CGRectMake(sizeLabel.width + 30 * scaleWidth, 340 * scaleHeight, Screen_Width - 168 * scaleWidth, sizeBtn.height + 10 * scaleHeight);
    }
    else {
        
        _shuiguoBtn.frame = CGRectMake(sizeLabel.width + 30 * scaleWidth, 340 * scaleHeight, sizeBtn.width + 10 * scaleWidth, sizeBtn.height + 10 * scaleHeight);
    }
    

    
    //关注按钮
    [_guanzhuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20 * scaleWidth);
        make.size.mas_equalTo(CGSizeMake(100 * scaleWidth, 40 * scaleHeight));
        make.top.mas_equalTo(350 * scaleHeight);
    }];
    
    
    
    //产品详情
    _shuiguoDetailLabel.text = ProductInfoDict[@"description"];
    CGSize sizeDetailLabel = [_shuiguoDetailLabel.text sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(990, 1000)];
    if (sizeDetailLabel.width >= 990) {
        sizeDetailLabel.height = sizeDetailLabel.height * 0.5;
    }
    NSInteger detailCount = 1;
    for (NSInteger i = 0; sizeDetailLabel.width >= 632 * scaleWidth; i++) {
        detailCount++;
        sizeDetailLabel.width -= 632 * scaleWidth;
    }
    if (detailCount > 1) {
        _shuiguoDetailLabel.frame = CGRectMake(20 * scaleWidth, 360 * scaleHeight + _shuiguoNameLabel.frame.size.height, 632 * scaleWidth, sizeDetailLabel.height * detailCount);
    }
    else {
        
         _shuiguoDetailLabel.frame = CGRectMake(20 * scaleWidth, 360 * scaleHeight + _shuiguoNameLabel.frame.size.height, sizeDetailLabel.width, sizeDetailLabel.height);
    }
    _shuiguoDetailLabel.numberOfLines = 0;
   

    //产品价格和运费
    NSDictionary* priceStyle = @{@"fuhao" :@[[UIFont fontWithName:@"HelveticaNeue" size:27.0],BaseColor(255, 104, 104, 1)],
                                 @"price" :@[[UIFont fontWithName:@"HelveticaNeue-Bold" size:27.0],BaseColor(255, 104, 104, 1)],
                                 @"type" :@[[UIFont fontWithName:@"HelveticaNeue" size:16.0],BaseColor(255, 104, 104, 1)],
                                 @"yunfei":@[[UIFont fontWithName:@"HelveticaNeue" size:16.0],BaseColor(105, 105, 105, 1)]};
    _shuiguoPriceLabel.text = ProductInfoDict[@"price"];
    _shuiguoPriceLabel.attributedText = [[NSString stringWithFormat:@"<fuhao>¥</fuhao><price>%@</price><type>/%@</type> <yunfei>| 运费:%@</yunfei>",ProductInfoDict[@"price"], ProductInfoDict[@"unit"], ProductInfoDict[@"freight"]] attributedStringWithStyleBook:priceStyle];
    CGSize sizePrice = [_shuiguoPriceLabel.text sizeWithFont:[UIFont systemFontOfSize:27.0] maxSize:CGSizeMake(999, 100)];
    if (sizePrice.width > Screen_Width - 248 * scaleWidth) {
        _shuiguoPriceLabel.frame = CGRectMake(20 * scaleWidth, 380 * scaleHeight + _shuiguoNameLabel.frame.size.height + _shuiguoDetailLabel.frame.size.height,  Screen_Width - 248 * scaleWidth, sizePrice.height - 15 * scaleHeight);
    }
    else {
    
        _shuiguoPriceLabel.frame = CGRectMake(20 * scaleWidth, 380 * scaleHeight + _shuiguoNameLabel.frame.size.height + _shuiguoDetailLabel.frame.size.height, sizePrice.width - 250 * scaleWidth, sizePrice.height - 15 * scaleHeight);
    }
    _shuiguoPriceLabel.adjustsFontSizeToFitWidth = YES;
   
    
    //认证状态
    if ([[NSString stringWithFormat:@"%@",ProducerInfoDict[@"status"]] isEqualToString:@"1"] == YES) {
        //已认证
        _renzhengImage.image = [UIImage imageNamed:@"V标_icon.png"];
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setBool:YES forKey:@"IsRenZheng"];
        [ud synchronize];
        
    }
    else {
        //未认证
        
        //_renzhengImage.image = [UIImage imageNamed:@"V标_icon.png"];
    }
    

    
    //分享
    _shareBtn.frame = CGRectMake(522 * scaleWidth, 410 * scaleHeight + _shuiguoNameLabel.frame.size.height + _shuiguoDetailLabel.frame.size.height, 100 * scaleWidth, 37 * scaleHeight);
    
    //商品状态
    if ([[NSString stringWithFormat:@"%@",ProductInfoDict[@"status"]] isEqualToString:@"0"] == YES || [[NSString stringWithFormat:@"%@",ProductInfoDict[@"status"]] isEqualToString:@"<null>"] == YES) {
        
        [_shangpinzhuangtaiBtn setBackgroundImage:[UIImage imageNamed:@"zy_btn_chushouzhong.jpg"] forState:UIControlStateNormal];
        
    }
    else {
    
        [_shangpinzhuangtaiBtn setBackgroundImage:[UIImage imageNamed:@"zy_btn_yixiajia.jpg"] forState:UIControlStateNormal];
    }
    _shangpinzhuangtaiBtn.frame = CGRectMake(522 * scaleWidth, 420 * scaleHeight + _shuiguoNameLabel.frame.size.height + _shuiguoDetailLabel.frame.size.height + _shuiguoPriceLabel.frame.size.height, 100 * scaleWidth, 37 * scaleHeight );

    
    _bgIamgeView.frame = CGRectMake(24 * scaleWidth, 20 * scaleHeight, Screen_Width - 48 * scaleWidth, 450 * scaleHeight + _shuiguoNameLabel.frame.size.height + _shuiguoDetailLabel.frame.size.height + _shuiguoPriceLabel.frame.size.height * 2);
    
    
    
}

- (void)clickImage {
    
   
    
    DetailViewController *detailVC = [[DetailViewController alloc] init];
   
    detailVC.ProductImages = _ProductImages;
    detailVC.ProductInfo = _ProductInfo;
    detailVC.ProducerInfo = _ProducerInfo;
    [self.viewController.navigationController pushViewController:detailVC animated:YES];
    

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
