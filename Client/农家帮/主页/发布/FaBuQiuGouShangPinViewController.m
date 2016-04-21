//
//  FaBuQiuGouShangPinViewController.m
//  农家帮
//
//  Created by Mac on 16/4/4.
//  Copyright © 2016年 jingqi. All rights reserved.
//

#import "FaBuQiuGouShangPinViewController.h"

@interface FaBuQiuGouShangPinViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, UITextFieldDelegate,UIScrollViewDelegate>

@end

@implementation FaBuQiuGouShangPinViewController
{
    UIScrollView *_scrollView;
    UIScrollView *_picScrollView;
    NSMutableArray *_picArray;
    NSMutableArray *_shangchaunPicArray;
    UIImagePickerController *_imagePickerController;
    
    UITextField *_mingchengTF;
    UILabel *_jieshao;
    UITextView *_jieshaoTV;
    UILabel *_shangpinjieshao;
    
    UITextField *_jiegeTF;
    UITextField *_shuliangTF;
    UITextField *_danweiTF;
    UITextField *_typeTF;
  
    UIButton *_saveBtn;
    
    CGSize _size;
    
    
    JQBaseRequest *_JQRequest;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.title = @"发布求购商品";
    
    _JQRequest = [[JQBaseRequest alloc] init];
    _shangchaunPicArray = [[NSMutableArray alloc] init];
    
    [self createUI];
}
- (void)back {
    
    NSNotification *noti = [[NSNotification alloc] initWithName:@"fanhui" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter]postNotification:noti];

}

- (void)createUI {
    
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height - 113)];
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchScrollView)];
    [recognizer setNumberOfTapsRequired:1];
    [recognizer setNumberOfTouchesRequired:1];
    [_scrollView addGestureRecognizer:recognizer];
    
    
    

    //商品名称
    _mingchengTF = [[UITextField alloc] initWithFrame:CGRectMake(24 * scaleWidth, 40 * scaleHeight, 672 * scaleWidth, 80 * scaleWidth)];
    _mingchengTF.background = [UIImage imageNamed:@"fbsp_input.png"];
    _mingchengTF.delegate = self;
    _mingchengTF.placeholder = NSLocalizedString(@"Name of commodity", @"");
    [_scrollView addSubview:_mingchengTF];
    UILabel *mingcheng = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30 * scaleWidth, 75 * scaleHeight)];
    mingcheng.textColor = BaseColor(249, 249, 249, 249);
    _mingchengTF.leftView = mingcheng;
    _mingchengTF.leftViewMode = UITextFieldViewModeAlways;
    
    //商品介绍textView
    _jieshaoTV = [[UITextView alloc] initWithFrame:CGRectMake(24 * scaleWidth, 140 * scaleHeight, 672 * scaleWidth, 300 * scaleWidth)];
    _jieshaoTV.layer.contents =(id) [[UIImage imageNamed:@"fbsp_input.png"]CGImage];
    [_scrollView addSubview:_jieshaoTV];
    _jieshaoTV.font = [UIFont systemFontOfSize:21.0];
    _jieshaoTV.textColor = BaseColor(178, 178, 178, 1);
    CGSize shangpinjieshaoSize = [NSLocalizedString(@"The introduction", @"") sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(990, 100)];
    _shangpinjieshao = [[UILabel alloc] initWithFrame:CGRectMake(30 * scaleWidth, 0, shangpinjieshaoSize.width, shangpinjieshaoSize.height)];
    _shangpinjieshao.text = [NSString stringWithFormat:NSLocalizedString(@"The introduction", @"")];
    _shangpinjieshao.font = [UIFont systemFontOfSize:21.0];
    _shangpinjieshao.textColor = BaseColor(178, 178, 178, 1);
    [_jieshaoTV addSubview:_shangpinjieshao];
    _jieshaoTV.delegate = self;
    
    
    //价格
    _jiegeTF = [[UITextField alloc] initWithFrame:CGRectMake(24 * scaleWidth, 460 * scaleHeight, 324 * scaleWidth, 80 * scaleHeight)];
    _jiegeTF.background = [UIImage imageNamed:@"fbsp_input_jige.png"];
    _jiegeTF.placeholder = NSLocalizedString(@"Commodity prices", @"");
    _jiegeTF.keyboardType = UIKeyboardTypeNumberPad;
    [_scrollView addSubview:_jiegeTF];
    UILabel *yuan = [[UILabel alloc] init];
    yuan.text = NSLocalizedString(@"Yuan", @"");
    CGSize yuanSize = [yuan.text sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(999, 100)];
    yuan.frame = CGRectMake(0, 0, yuanSize.width, yuanSize.height);
    yuan.textColor = BaseColor(52, 52, 52, 1);
    _jiegeTF.rightView = yuan;
    _jiegeTF.rightViewMode = UITextFieldViewModeAlways;
    
    
    _shuliangTF = [[UITextField alloc] initWithFrame:CGRectMake(372 * scaleWidth, 460 * scaleHeight, 324 * scaleWidth, 80 * scaleHeight)];
    _shuliangTF.placeholder = @"数量";
    _shuliangTF.background = [UIImage imageNamed:@"fbsp_input_jige.png"];
    _shuliangTF.keyboardType = UIKeyboardTypeNumberPad;
    [_scrollView addSubview:_shuliangTF];
    

    
    //选择单位
    _danweiTF = [[UITextField alloc] initWithFrame:CGRectMake(24 * scaleWidth, 560 * scaleHeight, 246 * scaleWidth, 80 * scaleHeight)];
    _danweiTF.placeholder = NSLocalizedString(@"Please select a product unit", @"");
    _danweiTF.background = [UIImage imageNamed:@"fbsp_input_danwei.png"];
    _danweiTF.delegate = self;
    UILabel *danwei = [[UILabel alloc] init];
    danwei.text = NSLocalizedString(@"Unit", @"");
    CGSize danweiSize = [danwei.text sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(999, 100)];
    danwei.frame = CGRectMake(0, 0, danweiSize.width, danweiSize.height);
    danwei.textColor = BaseColor(52, 52, 52, 1);
    _danweiTF.leftView = danwei;
    _danweiTF.leftViewMode = UITextFieldViewModeAlways;
    UIButton *xialaBtn = [[UIButton alloc] initWithFrame:CGRectMake(270 * scaleWidth, 560 * scaleHeight, 80 * scaleWidth, 80 * scaleHeight)];
    xialaBtn.tag = 200;
    [xialaBtn setBackgroundImage:[UIImage imageNamed:@"fbsp_btu_xiala.png"] forState:UIControlStateNormal];
    [xialaBtn addTarget:self action:@selector(xiala:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:xialaBtn];
    _danweiTF.userInteractionEnabled = NO;
    [_scrollView addSubview:_danweiTF];
    
    //选择类型
    _typeTF = [[UITextField alloc] initWithFrame:CGRectMake(370 * scaleWidth, 560 * scaleHeight, 246 * scaleWidth, 80 * scaleHeight)];
    _typeTF.placeholder = NSLocalizedString(@"Please choose a commodity type", @"");
    _typeTF.background = [UIImage imageNamed:@"fbsp_input_danwei.png"];
    _typeTF.delegate = self;
    _typeTF.userInteractionEnabled = NO;
    UILabel *type = [[UILabel alloc] init];
    type.text = NSLocalizedString(@"TYPE", @"");
    CGSize typeSize = [type.text sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(999, 100)];
    type.frame = CGRectMake(0, 0, typeSize.width, typeSize.height);
    type.textColor = BaseColor(52, 52, 52, 1);
    _typeTF.leftView = type;
    _typeTF.leftViewMode = UITextFieldViewModeAlways;
    UIButton *xialaAgainBtn = [[UIButton alloc] initWithFrame:CGRectMake(616 * scaleWidth, 560 * scaleHeight, 80 * scaleWidth, 80 * scaleHeight)];
    xialaAgainBtn.tag = 201;
    [xialaAgainBtn setBackgroundImage:[UIImage imageNamed:@"fbsp_btu_xiala.png"] forState:UIControlStateNormal];
    [xialaAgainBtn addTarget:self action:@selector(xiala:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:xialaAgainBtn];
    [_scrollView addSubview:_typeTF];
    
    
    
    
    _saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(24 * scaleWidth, 690 * scaleHeight, 672 * scaleWidth, 80 * scaleHeight)];
    [_saveBtn setBackgroundImage:[UIImage imageNamed:@"fbsp_btn_baocun_down.png"] forState:UIControlStateNormal];
    [_saveBtn setTitle:NSLocalizedString(@"SAVE", @"") forState:UIControlStateNormal];
    [_saveBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_saveBtn];
    
    
    _scrollView.contentSize = CGSizeMake(Screen_Width, Screen_Height + 216);
    
}

#pragma mark -scrollView的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.view endEditing:YES];
    if (!_jieshaoTV.text.length) {
        [_jieshaoTV addSubview:_shangpinjieshao];
    }
}


- (void)touchScrollView {
    
    [self.view endEditing:YES];
}

- (void)xiala:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    if (sender.tag == 200) {
        
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"Please select a product unit", @"") preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *articleAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"Tiao", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
            
            _danweiTF.text = NSLocalizedString(@"Tiao", @"");
            
        }];
        [alertController addAction:articleAction];
        
        UIAlertAction * boxAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"Box", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
            
            _danweiTF.text = NSLocalizedString(@"Box", @"");
            
        }];
        [alertController addAction:boxAction];
        
        UIAlertAction * bottleAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"Bottle", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
            
            _danweiTF.text = NSLocalizedString(@"Bottle", @"");
            
        }];
        [alertController addAction:bottleAction];
        
        UIAlertAction * aAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"Ge", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
            
            _danweiTF.text = NSLocalizedString(@"Ge", @"");
            
        }];
        [alertController addAction:aAction];
        
        UIAlertAction * cancleAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"CANCLE", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
            
            
        }];
        [alertController addAction:cancleAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    if (sender.tag == 201) {
        
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"Please select a product unit", @"") preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *articleAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"Fruit", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
            
            _typeTF.text = NSLocalizedString(@"Fruit", @"");
            
        }];
        [alertController addAction:articleAction];
        
        UIAlertAction * boxAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"FuShi", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
            
            _typeTF.text = NSLocalizedString(@"FuShi", @"");
            
        }];
        [alertController addAction:boxAction];
        
        UIAlertAction * bottleAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"Seafood", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
            
            _typeTF.text = NSLocalizedString(@"Seafood", @"");
            
        }];
        [alertController addAction:bottleAction];
        
        UIAlertAction * aAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"AlcoholAndTobacco", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
            
            _typeTF.text = NSLocalizedString(@"AlcoholAndTobacco", @"");
            
        }];
        [alertController addAction:aAction];
        
        UIAlertAction * cancleAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"CANCLE", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
            
        }];
        [alertController addAction:cancleAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
}

- (void)save {
    

    //先判断网络状态,没网络时可以先从缓存的内容里面读取
    [[JudgeNetState shareInstance]monitorNetworkType:self.view complete:^(NSInteger state) {
        if (state == 1 || state == 2) {
            
            if (_mingchengTF.text.length && _jieshaoTV.text.length && _jiegeTF.text.length && _shuliangTF.text.length && _danweiTF.text.length && _typeTF.text.length) {
                
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                
                
                //消费者发布求购商品
                [_JQRequest xinZengQiuGouXinXiWithConsumerId:[NSString stringWithFormat:@"%@",[ud objectForKey:@"ConsumerId"]] dic:@{@"Name":_mingchengTF.text,@"Description":_jieshaoTV.text,@"Price":_jiegeTF.text,@"Count":_shuliangTF.text,@"Unit":_danweiTF.text,@"ProductType":_typeTF.text} complete:^(NSDictionary *responseObject) {
                    
                    NSLog(@"消费者发布求购商品%@",responseObject);
                    
                    NSNotification *noti = [[NSNotification alloc] initWithName:@"fabu" object:nil userInfo:nil];
                    [[NSNotificationCenter defaultCenter]postNotification:noti];
                    
                    _mingchengTF.text = @"";
                    _jieshaoTV.text = @"";
                    _danweiTF.text = @"";
                    _typeTF.text = @"";
                    _jiegeTF.text = @"";
                    _shuliangTF.text = @"";
                    
                    CGSize size = [@"消费者发布求购商品成功" sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(999, 100)];
                    CGFloat labelX = (720 * scaleWidth - size.width) / 2 ;
                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, 1200 * scaleHeight - 64, size.width, size.height)];
                    label.backgroundColor = [UIColor blackColor];
                    label.textAlignment = NSTextAlignmentCenter;
                    label.textColor = [UIColor whiteColor];
                    label.text = @"消费者发布求购商品成功";
                    [self.view addSubview:label];
                    [self.view bringSubviewToFront:label];
                    [self performSelector:@selector(removeLabel:) withObject:label afterDelay:1];
                    
    
                    
                } fail:^(NSError *error, NSString *errorString) {
                    UIAlertController*alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:errorString preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                        
                        
                        
                    }];
                    
                    [alertController addAction:otherAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                }];
                
            }
            else {
                
                UIAlertController*alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"Input can't be empty", @"") preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                    
                    
                    
                }];
                
                [alertController addAction:otherAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }

            
            
        }
    }];

    
}
- (void)removeLabel:(UILabel *)label {
    
     [label removeFromSuperview];
    
    NSNotification *noti = [[NSNotification alloc] initWithName:@"fanhui" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter]postNotification:noti];
    
   
}
#pragma mark -UITextField的代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}
#pragma mark -UITextView的代理方法
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    [_shangpinjieshao removeFromSuperview];
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    
    [_jieshaoTV resignFirstResponder];
    return YES;
}



- (void)btnDelete:(UIButton *)sender {
    
    [_picScrollView removeFromSuperview];
   
    _picScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(24 * scaleWidth, 60 * scaleHeight + _size.height, 696 * scaleWidth, 220 * scaleHeight)];
    
    UIButton *button = (UIButton *)sender.superview;
    for (NSInteger i = 0; i < _picArray.count; i++) {
        if (button.currentBackgroundImage == (UIImage *)(_picArray[i])) {
            [_picArray removeObjectAtIndex:i];
        }
    }
    
    _picScrollView.contentSize = CGSizeMake(240 * scaleWidth * _picArray.count, 220 * scaleHeight);
    for (NSInteger i = 0; i < _picArray.count; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(240 * scaleWidth * i, 0, 220 * scaleWidth, 220 * scaleHeight)];
        if (i == 0) {
            button.tag = 100;
        }
        else if (i == _picArray.count - 1) {
            button.tag = 101;
        }
        else {
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 170 * scaleHeight, 220 * scaleWidth, 50 * scaleHeight)];
            btn.backgroundColor = BaseColor(0, 0, 0, 0.6);
            [btn setTitle:NSLocalizedString(@"DELETE", @"") forState:UIControlStateNormal];
            [btn setTitleColor:BaseColor(255, 255, 255, 1) forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnDelete:) forControlEvents:UIControlEventTouchUpInside];
            [button addSubview:btn];
        }
        [button setBackgroundImage:_picArray[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [_picScrollView addSubview:button];
    }
    
    [_scrollView addSubview:_picScrollView];
    
}
//点击屏幕触发的事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
