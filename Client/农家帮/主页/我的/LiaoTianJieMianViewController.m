//
//  LiaoTianJieMianViewController.m
//  农家帮
//
//  Created by Mac on 16/3/19.
//  Copyright © 2016年 jingqi. All rights reserved.
//

#import "LiaoTianJieMianViewController.h"

// Picture size macro in chanpinpinglun directory
// chan pin ping lun = product comment
#define CPPL_BG_PNG_HEIGHT    97
#define CPPL_INPUT_PNG_HEIGHT 80
#define CPPL_INPUT_PNG_WIDTH  532
#define CPPL_BTN_FABIAO_DOWN_WIDTH 120
#define CPPL_BTN_FABIAO_DOWN_HEIGHT 80

// View Style
#define LEFT_PADDING 24
#define TOP_PADDING 10
#define SEND_BTN_ORGIN_X 576
#define SEND_BTN_ORGIN_Y 10

@interface LiaoTianJieMianViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@end

@implementation LiaoTianJieMianViewController
{
    UITableView *_tableView;
    NSMutableArray *_resultArray;
    NSMutableArray *_fasongArray;
    NSMutableArray *_jieshouArray;
    
    JQBaseRequest * _jqRequest;
    UIImageView *_bottomImageView;
    UITextField *_pinglunTF;
    
    NSTimer *_timer;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BaseColor(245, 245, 245, 1);
    
    self.title = self.name;
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [button setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    NSLog(@"navigationItem x = %f",self.navigationController.navigationBar.frame.origin.x);
    NSLog(@"navigationItem y = %f",self.navigationController.navigationBar.frame.origin.y);
    NSLog(@"%f",self.navigationController.navigationBar.frame.size.width);
    NSLog(@"%f",self.navigationController.navigationBar.frame.size.height);
    [button addTarget:self action:@selector(leftBackButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    _jqRequest = [[JQBaseRequest alloc] init];
    
    NSLog(@"screen width = %f", Screen_Width);
    NSLog(@"screen heigth = %f", Screen_Height);
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height - StatBar_And_NavBar_Height - CPPL_BG_PNG_HEIGHT * scaleHeight)];
    _tableView.backgroundColor = BaseColor(242, 242, 242, 1);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, Screen_Height - StatBar_And_NavBar_Height - CPPL_BG_PNG_HEIGHT * scaleHeight, Screen_Width, CPPL_BG_PNG_HEIGHT * scaleHeight)];
    _bottomImageView.image = [UIImage imageNamed:@"cppl_bg.png"];
    _bottomImageView.userInteractionEnabled = YES;
    [self.view addSubview:_bottomImageView];
    
    _pinglunTF = [[UITextField alloc]
                  initWithFrame:CGRectMake(LEFT_PADDING * scaleWidth,
                                           TOP_PADDING * scaleHeight,
                                           CPPL_INPUT_PNG_WIDTH * scaleWidth,
                                           CPPL_INPUT_PNG_HEIGHT * scaleHeight)];
    _pinglunTF.layer.cornerRadius = 5 * scaleHeight;
    _pinglunTF.layer.borderColor = BaseColor(242, 242, 242, 1).CGColor;
    _pinglunTF.layer.borderWidth = 2;
    _pinglunTF.background = [UIImage imageNamed:@"cppl_input.png"];
    _pinglunTF.delegate = self;
    _pinglunTF.placeholder = NSLocalizedString(@"Say two words...", @"");
    [_bottomImageView addSubview:_pinglunTF];
    
    UIButton *fasongBtn = [[UIButton alloc]
                           initWithFrame:CGRectMake(SEND_BTN_ORGIN_X * scaleWidth,
                                                    SEND_BTN_ORGIN_Y * scaleHeight,
                                                    CPPL_BTN_FABIAO_DOWN_WIDTH * scaleWidth,
                                                    CPPL_BTN_FABIAO_DOWN_HEIGHT * scaleHeight)];
    [fasongBtn setTitle:NSLocalizedString(@"SEND", @"") forState:UIControlStateNormal];
    [fasongBtn setBackgroundImage:[UIImage imageNamed:@"cppl_btn_fabiao_down.png"] forState:UIControlStateNormal];
    [fasongBtn addTarget:self action:@selector(fasong) forControlEvents:UIControlEventTouchUpInside];
    [_bottomImageView addSubview:fasongBtn];

    _fasongArray = [[NSMutableArray alloc] init];
    _jieshouArray = [[NSMutableArray alloc] init];
    _resultArray = [[NSMutableArray alloc] init];
    

    //计时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(qingqiu) userInfo:nil repeats:YES];
   
    

}
//1s请求一次
- (void)qingqiu {
    
     NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    if ([ud boolForKey:@"IsConsumer"]) {
    
        [_jqRequest MaiJia3GHuoQuMaiJia4LiaoTianXiaoXiWithConsumerId:[NSString stringWithFormat:@"%@",[ud objectForKey:@"ConsumerId"]] ProducerId:self.producerId  complete:^(NSDictionary *responseObject) {
            
            //NSLog(@"接收聊天消息:%@",responseObject);
            
            NSArray *array = responseObject[@"List"];
            
            if ([[ud objectForKey:@"Count"] integerValue] != [responseObject[@"Count"] integerValue]) {
                
                [ud setObject:responseObject[@"Count"] forKey:@"Count"];
                [ud synchronize];
                
                
                for (NSDictionary *dict in array) {
                    NSDictionary *dict1 = [NSDictionary dictionaryWithObjectsAndKeys:@"weixin",@"name",[NSString stringWithFormat:@"%@",dict[@"lastmodifiedtime"]],@"shijian",[NSString stringWithFormat:@"%@",dict[@"message"]],@"content", nil];
                    [_resultArray addObject:dict1];
                }
                
            }
            
            _timer.fireDate = [NSDate distantFuture];
            
        } fail:^(NSError *error, NSString *errorString) {
            
        }];

    
    }
    else {
    
        [_jqRequest MaiJia4GHuoQuMaiJia4LiaoTianXiaoXiWithProducerId:self.producerId ChatProducerId:[NSString stringWithFormat:@"%@",[ud objectForKey:@"ProducerId"]] complete:^(NSDictionary *responseObject) {
            
            //NSLog(@"接收聊天消息:%@",responseObject);
            
            NSArray *array = responseObject[@"List"];
            
            if ([[ud objectForKey:@"Count"] integerValue] != [responseObject[@"Count"] integerValue]) {
                
                [ud setObject:responseObject[@"Count"] forKey:@"Count"];
                [ud synchronize];
                
                
                for (NSDictionary *dict in array) {
                    NSDictionary *dict1 = [NSDictionary dictionaryWithObjectsAndKeys:@"weixin",@"name",[NSString stringWithFormat:@"%@",dict[@"lastmodifiedtime"]],@"shijian",[NSString stringWithFormat:@"%@",dict[@"message"]],@"content", nil];
                    [_resultArray addObject:dict1];
                }
                
            }
            
            _timer.fireDate = [NSDate distantFuture];
            
        } fail:^(NSError *error, NSString *errorString) {
            
        }];

    }

}
- (void)fasong {
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *dateStr = [df stringFromDate:[NSDate date]];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([ud boolForKey:@"IsConsumer"]) {
        // consumer send msg to producer
        [_jqRequest MaiJia3GeiMaiJia4FaSongLiaoTianXiaoXiWithConsumerId:[NSString stringWithFormat:@"%@",[ud objectForKey:@"ConsumerId"]] ProducerId:self.producerId BaseMassage:@{@"Count":@"1",@"List":@[@{@"Message":[NSString stringWithFormat:@"%@",_pinglunTF.text],@"Time":dateStr}]} complete:^(NSDictionary *responseObject) {
            
            NSLog(@"发送聊天消息:%@",responseObject);
            
            
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"rhl",@"name",dateStr,@"shijian",_pinglunTF.text,@"content", nil];
            [_resultArray addObject:dict];
            [_tableView reloadData];
            
            [UIView animateWithDuration:0.5 animations:^{
                CGRect frame = CGRectMake(0, StatBar_And_NavBar_Height,
                                          Screen_Width, Screen_Height - StatBar_And_NavBar_Height);
                self.view.frame = frame;
                
            }];
            _pinglunTF.text = @"";
            [_pinglunTF resignFirstResponder];
            
            _timer.fireDate = [NSDate distantPast];
            
        } fail:^(NSError *error, NSString *errorString) {
            
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:errorString preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                
                
            }];
            [alertController addAction:otherAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
            
        }];
        
    }
    else {
    
        [_jqRequest MaiJia4GeiMaiJia4FaSongLiaoTianXiaoXiWithProducerId:[NSString stringWithFormat:@"%@",[ud objectForKey:@"ProducerId"]] ChatProducerId:self.producerId BaseMassage:@{@"Count":@"1",@"List":@[@{@"Message":[NSString stringWithFormat:@"%@",_pinglunTF.text],@"Time":dateStr}]} complete:^(NSDictionary *responseObject) {
            
            NSLog(@"发送聊天消息:%@",responseObject);
            
            
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"rhl",@"name",dateStr,@"shijian",_pinglunTF.text,@"content", nil];
            [_resultArray addObject:dict];
            [_tableView reloadData];
            
            [UIView animateWithDuration:0.5 animations:^{
                CGRect frame = CGRectMake(0, StatBar_And_NavBar_Height,
                                          Screen_Width, Screen_Height - StatBar_And_NavBar_Height);
                self.view.frame = frame;
                
            }];
            _pinglunTF.text = @"";
            [_pinglunTF resignFirstResponder];
            
            _timer.fireDate = [NSDate distantPast];
            
        } fail:^(NSError *error, NSString *errorString) {
            
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:errorString preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                
                
                
            }];
            [alertController addAction:otherAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
            
        }];

    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = CGRectMake(0, - 216, Screen_Width, Screen_Height + 216);
        self.view.frame = frame;
    }];
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = CGRectMake(0, 64, Screen_Width, Screen_Height - 64);
        self.view.frame = frame;
    }];

    return YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == _tableView) {
        
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame = CGRectMake(0, 64, Screen_Width, Screen_Height - 64);
            self.view.frame = frame;
            
        }];
        [_pinglunTF resignFirstResponder];

    }
    
}
//泡泡文本
- (UIView *)bubbleView:(NSString *)text time:(NSString *)shijian from:(BOOL)fromSelf withPosition:(int)position{
    
    //计算大小
    UIFont *font = [UIFont systemFontOfSize:14];
    CGSize size = [[NSString stringWithFormat:@"%@%@",text,shijian] sizeWithFont:font constrainedToSize:CGSizeMake(180.0f, 20000.0f) lineBreakMode:NSLineBreakByWordWrapping];
    
    // build single chat bubble cell with given text
    UIView *returnView = [[UIView alloc] initWithFrame:CGRectZero];
    returnView.backgroundColor = [UIColor clearColor];
    
    //背影图片
    UIImage *bubble = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fromSelf?@"SenderAppNodeBkg_HL":@"ReceiverTextNodeBkg" ofType:@"png"]];
    
    UIImageView *bubbleImageView = [[UIImageView alloc] initWithImage:[bubble stretchableImageWithLeftCapWidth:floorf(bubble.size.width/2) topCapHeight:floorf(bubble.size.height/2)]];
    
    
    
    //添加文本信息
    UILabel *bubbleText = [[UILabel alloc] initWithFrame:CGRectMake(fromSelf?15.0f:22.0f, 20.0f, size.width+10, size.height+10)];
    bubbleText.backgroundColor = [UIColor clearColor];
    bubbleText.font = font;
    bubbleText.numberOfLines = 0;
    bubbleText.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary* style = @{@"shijian" :@[[UIFont fontWithName:@"HelveticaNeue" size:14.0],BaseColor(255, 104, 104, 1)],
                            @"neirong" :@[[UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0],[UIColor blackColor]]};
    bubbleText.attributedText = [[NSString stringWithFormat:@"<shijian>%@</shijian>   <neirong>%@</neirong>",shijian, text] attributedStringWithStyleBook:style];
    
    bubbleImageView.frame = CGRectMake(0.0f, 14.0f, bubbleText.frame.size.width+30.0f, bubbleText.frame.size.height+20.0f);
    
    if(fromSelf)
        returnView.frame = CGRectMake(320 - position - (bubbleText.frame.size.width + 30.0f), 0.0f, bubbleText.frame.size.width + 30.0f, bubbleText.frame.size.height + 30.0f);
    else
        returnView.frame = CGRectMake(position, 0.0f, bubbleText.frame.size.width + 30.0f, bubbleText.frame.size.height + 30.0f);
    
    [returnView addSubview:bubbleImageView];
    [returnView addSubview:bubbleText];
    
    return returnView;
}

//泡泡语音
- (UIView *)yuyinView:(NSInteger)logntime from:(BOOL)fromSelf withIndexRow:(NSInteger)indexRow  withPosition:(int)position{
    
    //根据语音长度
    int yuyinwidth = 66+fromSelf;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = indexRow;
    if(fromSelf)
        button.frame =CGRectMake(320-position-yuyinwidth, 10, yuyinwidth, 54);
    else
        button.frame =CGRectMake(position, 10, yuyinwidth, 54);
    
    //image偏移量
    UIEdgeInsets imageInsert;
    imageInsert.top = -10;
    imageInsert.left = fromSelf?button.frame.size.width/3:-button.frame.size.width/3;
    button.imageEdgeInsets = imageInsert;
    
    [button setImage:[UIImage imageNamed:fromSelf?@"SenderVoiceNodePlaying":@"ReceiverVoiceNodePlaying"] forState:UIControlStateNormal];
    UIImage *backgroundImage = [UIImage imageNamed:fromSelf?@"SenderVoiceNodeDownloading":@"ReceiverVoiceNodeDownloading"];
    backgroundImage = [backgroundImage stretchableImageWithLeftCapWidth:20 topCapHeight:0];
    [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(fromSelf?-30:button.frame.size.width, 0, 30, button.frame.size.height)];
    label.text = [NSString stringWithFormat:@"%d''",logntime];
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:13];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    [button addSubview:label];
    
    return button;
}

#pragma UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _resultArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dict = [_resultArray objectAtIndex:indexPath.row];
    UIFont *font = [UIFont systemFontOfSize:14];
    CGSize size = [[NSString stringWithFormat:@"%@%@",[dict objectForKey:@"shijian"],[dict objectForKey:@"content"]] sizeWithFont:font constrainedToSize:CGSizeMake(180.0f, 20000.0f) lineBreakMode:NSLineBreakByWordWrapping];
    
    return size.height + 44;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = BaseColor(242, 242, 242, 1);
        
    }else{
        for (UIView *cellView in cell.subviews){
            [cellView removeFromSuperview];
        }
    }
    
    NSDictionary *dict = [_resultArray objectAtIndex:indexPath.row];
    
    //创建头像
    UIImageView *photo ;
    if ([[dict objectForKey:@"name"]isEqualToString:@"rhl"]) {
        photo = [[UIImageView alloc]initWithFrame:CGRectMake(320 * ScaleWidth - 60 * ScaleWidth, 10, 30 * ScaleWidth, 30 * ScaleWidth)];
        [cell addSubview:photo];
        
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
        [photo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[ud objectForKey:@"ProducerURL"]]] placeholderImage:nil];
        
        
        if ([[dict objectForKey:@"content"] isEqualToString:@"0"]) {
            [cell addSubview:[self yuyinView:1 from:YES withIndexRow:indexPath.row withPosition:65]];
            
            
        }else{
            [cell addSubview:[self bubbleView:[dict objectForKey:@"content"] time:[dict objectForKey:@"shijian"] from:YES withPosition:65]];
        }
        
    }
    else{
        
        photo = [[UIImageView alloc]initWithFrame:CGRectMake(10 * ScaleWidth, 10 * ScaleWidth, 30 * ScaleWidth, 30 * ScaleWidth)];
        [cell addSubview:photo];
        [photo sd_setImageWithURL:[NSURL URLWithString:self.touxiang] placeholderImage:nil];
        
        if ([[dict objectForKey:@"content"] isEqualToString:@"0"]) {
            [cell addSubview:[self yuyinView:1 from:NO withIndexRow:indexPath.row withPosition:65]];
        }else{
            [cell addSubview:[self bubbleView:[dict objectForKey:@"content"] time:[dict objectForKey:@"shijian"] from:NO withPosition:65]];
        }
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)leftBackButtonClick {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
