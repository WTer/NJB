//
//  YongHuRenZhengViewController.m
//  农家帮
//
//  Created by Mac on 16/4/5.
//  Copyright © 2016年 jingqi. All rights reserved.
//

#import "YongHuRenZhengViewController.h"

@interface YongHuRenZhengViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, UITextFieldDelegate,UIScrollViewDelegate>

@end

@implementation YongHuRenZhengViewController
{
    UIScrollView *_scrollView;
    UIScrollView *_picScrollView;
    NSMutableArray *_picArray;
    NSMutableArray *_shangchaunPicArray;
    UIImagePickerController *_imagePickerController;
    
    
    UILabel *_jieshao;
    UITextView *_jieshaoTV;
    UILabel *_shangpinjieshao;
    
    
    UIButton *_saveBtn;
    
    CGSize _size;
    
    
    JQBaseRequest *_JQRequest;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BaseColor(245, 245, 245, 1);
    
    self.title = NSLocalizedString(@"用户认证", @"");
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [button setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(leftBackButtonClick) forControlEvents:UIControlEventTouchUpInside];

    
    _JQRequest = [[JQBaseRequest alloc] init];
    _shangchaunPicArray = [[NSMutableArray alloc] init];
    
    [self createUI];
}

- (void)createUI {
    
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height - 113)];
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchScrollView)];
    [recognizer setNumberOfTapsRequired:1];
    [recognizer setNumberOfTouchesRequired:1];
    [_scrollView addGestureRecognizer:recognizer];
    
    UILabel *title = [[UILabel alloc] init];
    title.text = [NSString stringWithFormat:@"%@（%@）",NSLocalizedString(@"Upload the product image", @""),NSLocalizedString(@"Upload eight pictures at most", @"")];
    NSDictionary *style = @{
                            @"tupian" :@[[UIFont fontWithName:@"HelveticaNeue" size:21.0],BaseColor(52, 52, 52, 1)],
                            @"xianzhi" :@[[UIFont fontWithName:@"HelveticaNeue" size:18.0],BaseColor(178, 178, 178, 1)]};
    title.attributedText = [[NSString stringWithFormat:@"<tupian>%@</tupian><xianzhi>%@</xianzhi>",NSLocalizedString(@"Upload the product image", @""), [NSString stringWithFormat:@"（%@）",NSLocalizedString(@"Upload eight pictures at most", @"")]] attributedStringWithStyleBook:style];
    _size = [title.text sizeWithFont:[UIFont systemFontOfSize:21.0] maxSize:CGSizeMake(999, 100)];
    title.frame = CGRectMake(24 * scaleWidth, 40 * scaleHeight, _size.width, _size.height);
    [_scrollView addSubview:title];
    
    //上传照片
    _picScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(24 * scaleWidth, 60 * scaleHeight + _size.height, 696 * scaleWidth, 220 * scaleHeight)];
    _picScrollView.showsHorizontalScrollIndicator = NO;
    _picScrollView.bounces = NO;
    [_scrollView addSubview:_picScrollView];
    
    _picArray = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"fbsp_btn_paizhao.png"], [UIImage imageNamed:@"fbsp_btn_tianjia.png"],nil];
    
    _picScrollView.contentSize = CGSizeMake(240 * scaleWidth * _picArray.count, 220 * scaleHeight);
    for (NSInteger i = 0; i < _picArray.count; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(240 * scaleWidth * i, 0, 220 * scaleWidth, 220 * scaleHeight)];
        button.tag = 100 + i;
        [button setBackgroundImage:_picArray[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [_picScrollView addSubview:button];
    }
    
    
    //请输入用户验证信息textView
    _jieshaoTV = [[UITextView alloc] initWithFrame:CGRectMake(24 * scaleWidth, 310 * scaleHeight + _size.height, 672 * scaleWidth, 300 * scaleWidth)];
    _jieshaoTV.layer.contents =(id) [[UIImage imageNamed:@"fbsp_input.png"]CGImage];
    [_scrollView addSubview:_jieshaoTV];
    _jieshaoTV.font = [UIFont systemFontOfSize:18.0];
    _jieshaoTV.textColor = BaseColor(178, 178, 178, 1);
    CGSize shangpinjieshaoSize = [@"请输入用户验证信息" sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(990, 100)];
    _shangpinjieshao = [[UILabel alloc] initWithFrame:CGRectMake(30 * scaleWidth, 10 * scaleHeight, shangpinjieshaoSize.width, shangpinjieshaoSize.height)];
    _shangpinjieshao.text = @"请输入用户验证信息";
    _shangpinjieshao.font = [UIFont systemFontOfSize:18.0];
    _shangpinjieshao.textColor = BaseColor(178, 178, 178, 1);
    [_jieshaoTV addSubview:_shangpinjieshao];
    _jieshaoTV.delegate = self;
    
    
    
    _saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(24 * scaleWidth, 680 * scaleHeight + _size.height, 672 * scaleWidth, 80 * scaleHeight)];
    [_saveBtn setBackgroundImage:[UIImage imageNamed:@"fbsp_btn_baocun_down.png"] forState:UIControlStateNormal];
    [_saveBtn setTitle:NSLocalizedString(@"SAVE", @"") forState:UIControlStateNormal];
    [_saveBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_saveBtn];
    
    
    _scrollView.contentSize = CGSizeMake(Screen_Width, 680 * scaleHeight + _size.height + 280);
    
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


- (void)save {
    
    
    for (NSInteger i = 1; i < _picArray.count - 1; i++) {
        [_shangchaunPicArray addObject:_picArray[i]];
    }
    
    //先判断网络状态,没网络时可以先从缓存的内容里面读取
    [[JudgeNetState shareInstance]monitorNetworkType:self.view complete:^(NSInteger state) {
        if (state == 1 || state == 2) {

            if (_jieshaoTV.text.length) {
                
                //保存到服务器
               // NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                
                
                
//                [_JQRequest ShangPinFaBUImageByPutRequestWithProductId:responseObject[@"id"] Count:_shangchaunPicArray.count List:_shangchaunPicArray complete:^(NSDictionary *responseObject) {
//                    
//                    
//                    
//                    
//                    _jieshaoTV.text = @"";
//                    
//                    
//                    [_picArray removeAllObjects];
//                    [_shangchaunPicArray removeAllObjects];
//                    
//                    [_picScrollView removeFromSuperview];
//                    
//                    _picScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(24 * scaleWidth, 60 * scaleHeight + _size.height, 696 * scaleWidth, 220 * scaleHeight)];
//                    _picScrollView.showsHorizontalScrollIndicator = NO;
//                    _picScrollView.bounces = NO;
//                    [_scrollView addSubview:_picScrollView];
//                    
//                    _picArray = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"fbsp_btn_paizhao.png"], [UIImage imageNamed:@"fbsp_btn_tianjia.png"],nil];
//                    
//                    _picScrollView.contentSize = CGSizeMake(240 * scaleWidth * _picArray.count, 220 * scaleHeight);
//                    for (NSInteger i = 0; i < _picArray.count; i++) {
//                        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(240 * scaleWidth * i, 0, 220 * scaleWidth, 220 * scaleHeight)];
//                        button.tag = 100 + i;
//                        [button setBackgroundImage:_picArray[i] forState:UIControlStateNormal];
//                        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
//                        [_picScrollView addSubview:button];
//                    }
//                    
//                    
//                    
//                } fail:^(NSError *error, NSString *errorString) {
//                    
//                    UIAlertController*alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message: errorString preferredStyle:UIAlertControllerStyleAlert];
//                    UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
//                        
//                        
//                        
//                    }];
//                    
//                    [alertController addAction:otherAction];
//                    [self presentViewController:alertController animated:YES completion:nil];
//                    
//                }];
                
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


- (void)click:(UIButton *)sender {
    
    //操作类型
    _imagePickerController = [[UIImagePickerController alloc] init];
    if (sender.tag == 100) {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == YES) {
            //相机可用
            _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            _imagePickerController.delegate = self;
            
            [self presentViewController:_imagePickerController animated:YES completion:nil];
            
        }
    }
    if (sender.tag == 101) {
        
        if (_picArray.count <= 10) {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"CANCLE", @"") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Choose from the album", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                //相册
                _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                //设置代理
                _imagePickerController.delegate = self;
                
                [self presentViewController:_imagePickerController animated:YES completion:nil];
                
            }];
            [alertController addAction:cancelAction];
            [alertController addAction:archiveAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else {
            
            UIAlertController*alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ATTENTION", @"") message:NSLocalizedString(@"Warm prompt: the maximum upload eight", @"") preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction*otherAction = [UIAlertAction  actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                
                
                
            }];
            
            [alertController addAction:otherAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }
}
#pragma mark -UIImagePickerController的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    [_picArray insertObject:info[UIImagePickerControllerOriginalImage] atIndex:1];
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
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
//
//    [picker dismissViewControllerAnimated:YES completion:nil];
//
//}
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

- (void)leftBackButtonClick {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
