//
//  LiuYanBanViewController.m
//  农家帮
//
//  Created by Mac on 16/4/11.
//  Copyright © 2016年 jingqi. All rights reserved.
//

#import "LiuYanBanViewController.h"

@interface LiuYanBanViewController ()<UITextViewDelegate,UIScrollViewDelegate>

@end

@implementation LiuYanBanViewController
{
    UIScrollView *_scrollView;
    UITextView *_liuyanTV;
    UILabel *_liuyan;
    UILabel *_liuyanxianzi;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    self.view.backgroundColor = BaseColor(255, 255, 255, 1);
    
    self.title = @"留言板";
    
    [self createUI];
    
}
- (void)createUI {
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height - 64)];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(Screen_Width, Screen_Height + 50);
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    _liuyanTV = [[UITextView alloc] initWithFrame:CGRectMake(24 * scaleWidth, 26 * scaleHeight, 672 * scaleWidth, 400 * scaleHeight)];
    _liuyanTV.backgroundColor = BaseColor(248, 249, 249, 1);
    _liuyanTV.delegate = self;
    [_scrollView addSubview:_liuyanTV];
    
    _liuyan = [[UILabel alloc] initWithFrame:CGRectMake(21 * scaleWidth, 28 * scaleHeight, 200 * scaleWidth, 40 * scaleHeight)];
    _liuyan.font = [UIFont systemFontOfSize:14.0];
    _liuyan.textColor = BaseColor(178, 178, 178, 1);
    _liuyan.text = @"买家留言";
    [_liuyanTV addSubview:_liuyan];
    
    _liuyanxianzi = [[UILabel alloc] initWithFrame:CGRectMake(250 * scaleWidth, 310 * scaleHeight, 450 * scaleWidth, 80 * scaleHeight)];
    _liuyanxianzi.adjustsFontSizeToFitWidth = YES;
    _liuyanxianzi.font = [UIFont systemFontOfSize:14.0];
    _liuyanxianzi.textColor = BaseColor(178, 178, 178, 1);
    _liuyanxianzi.text = @"最多可编辑200字（0/200）";
    [_liuyanTV addSubview:_liuyanxianzi];
    
    //保存按钮
    UIButton *baocun = [[UIButton alloc] initWithFrame:CGRectMake(24 * scaleWidth, 474 * scaleHeight, 672 * scaleWidth, 80 * scaleHeight)];
    [baocun setBackgroundImage:[UIImage imageNamed:@"shdz2_btn_baocun_down.png"] forState:UIControlStateNormal];
    [baocun setTitle:NSLocalizedString(@"SAVE", @"") forState:UIControlStateNormal];
    [baocun addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:baocun];
    
    
}
- (void)save {


}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (_liuyanTV.text.length) {
        
    }
    else {
        [_liuyanTV addSubview:_liuyan];
    }
    [self.view endEditing:YES];
    
}

#define UITextView的代理方法
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {

    [_liuyan removeFromSuperview];
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {

    if (textView.text.length > 200) {
        
        UIAlertController*alertController = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"最多可编辑200字，现在字数为%d",_liuyanTV.text.length] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
            
        }];
        
        [alertController addAction:otherAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
        _liuyanxianzi.text = [NSString stringWithFormat:@"最多可编辑200字（%d/200）",textView.text.length];
        
    }
    else {
        
        _liuyanxianzi.text = [NSString stringWithFormat:@"最多可编辑200字（%d/200）",textView.text.length];
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    
    //NSLog(@"%d",textView.text.length);
    
    return YES;
}

- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
