//
//  YiJianViewController.m
//  农帮乐
//
//  Created by 王朝源 on 15/12/7.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "YiJianViewController.h"

@interface YiJianViewController ()<UITextViewDelegate, UITextFieldDelegate>

@end

@implementation YiJianViewController
{
    UITextView * _textView;
     UITextView * _textView2;
    UITextField * _textField;
    BOOL _isJianPan;//用于记录键盘的状态
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _isJianPan = NO;
    self.navigationController.navigationBar.translucent = NO;
    if ([[[UIDevice currentDevice]systemVersion]doubleValue] > 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = NSLocalizedString(@"意见反馈", @"");
    [self createBackLeftButton];
    [self createUI];
    // Do any additional setup after loading the view.
}
//创建返回按钮
- (void)createBackLeftButton
{
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [button setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(leftBackButtonClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)leftBackButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createUI
{
    _textView2  = [[UITextView alloc]initWithFrame:CGRectMake(24 * scaleWidth, 330 * scaleHeight, Screen_Width - 48 * scaleWidth, 240 * scaleHeight)];
    _textView2.layer.contents =(id) [[UIImage imageNamed:@"zhuce2_input.png"]CGImage];
    [self.view addSubview:_textView2];
    _textView2.text = NSLocalizedString(@"请至少输入10个字的意见反馈", @"");
    _textView2.delegate = self;
    _textView2.textColor = BaseColor(52, 52, 52, 0.3);
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 260 * scaleHeight)];
    view.layer.contents = (id)[[UIImage imageNamed:@"gezx_sz_yjfk_pic.png"]CGImage];
    [self.view addSubview:view];
    
    _textView  = [[UITextView alloc]initWithFrame:CGRectMake(24 * scaleWidth, 330 * scaleHeight, Screen_Width - 48 * scaleWidth, 240 * scaleHeight)];
    _textView.layer.contents =(id) [[UIImage imageNamed:@"zhuce2_input.png"]CGImage];
    [self.view addSubview:_textView];
    _textView.alpha = 0.1;
    _textView.delegate = self;
//    _textView.textColor = [UIColor blackColor];
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(24 * scaleWidth, 590* scaleHeight, Screen_Width - 48 * scaleWidth, 80 * scaleHeight)];
    _textField.placeholder = NSLocalizedString(@"您的手机号码或者邮箱（选填）", @"");
    _textField.delegate = self;
    _textField.layer.contents =(id) [[UIImage imageNamed:@"zhuce2_input.png"]CGImage];
    [_textField setValue:BaseColor(52, 52, 52, 0.3) forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:_textField];
    
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"shouye_btn_denglu_n.png"] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(commitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(24 * scaleWidth, 770 * scaleHeight, Screen_Width - 48 * scaleWidth, 80 * scaleHeight);
    [button setTitle:NSLocalizedString(@"提交", @"") forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
}
#warning 提交按钮被电击
- (void)commitButtonClick
{
    
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    _isJianPan = NO;
    if (self.view.frame.origin.y == 64) {
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame = CGRectMake(0, - 100 * scaleHeight, Screen_Width, Screen_Height);
            self.view.frame = frame;
        }];
    }
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if(![text isEqualToString:@""])
    {
        _textView.alpha = 1;
        [_textView2 setHidden:YES];
    }
    if([text isEqualToString:@""]&&range.length==1&&range.location==0){
        _textView.alpha = 0.5;
        [_textView2 setHidden:NO];
    }
    if ([text isEqualToString:@"\n"]) {
        _isJianPan = YES;
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if (_isJianPan) {
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame = CGRectMake(0, 64, Screen_Width, Screen_Height);
            self.view.frame = frame;
        }];
    }
    if ([_textView.text isEqualToString:@""]) {
        _textView.alpha = 0.5;
        [_textView2 setHidden:NO];
    }
    return YES;
}


//弹出键盘后view向上升起了100 * scaleHeight
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    _isJianPan = NO;
    if (self.view.frame.origin.y == 64) {
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame = CGRectMake(0, - 100 * scaleHeight, Screen_Width, Screen_Height);
            self.view.frame = frame;
        }];
    }
    
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    _isJianPan = YES;
    [self.view endEditing:YES];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (_isJianPan) {
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame = CGRectMake(0, 64, Screen_Width, Screen_Height);
            self.view.frame = frame;
        }];
    }
}

////点击屏幕触发的事件
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
//    [self.view endEditing:YES];
//    
//    [UIView animateWithDuration:0.5 animations:^{
//        CGRect frame = CGRectMake(0, 0, Screen_Width, Screen_Height);
//        self.view.frame = frame;
//    }];
//    
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
