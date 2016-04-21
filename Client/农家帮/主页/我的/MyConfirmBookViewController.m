//
//  MyConfirmBookViewController.m
//  农帮乐
//
//  Created by 王朝源 on 15/12/8.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "MyConfirmBookViewController.h"
#import "NSString+WPAttributedMarkup.h"

#import "WPAttributedStyleAction.h"
#import "WPHotspotLabel.h"
#import "confirmBookDetailViewController.h"

@interface MyConfirmBookViewController ()<UITextFieldDelegate, UITextViewDelegate, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation MyConfirmBookViewController
{
    UIScrollView * _scrollerView;
    UITextView * _textView;
    UITextView * _textView2;
    UITextField * _textField;
    BOOL _isJianPan;//用于记录键盘的状态
    NSMutableArray * _dataArray;
    UIImagePickerController * _imagePickerController;
    
    NSMutableArray * _requestDataArray;
}
#pragma mark ---查询扩展信息
- (void)userSelectedextensionMessage
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    JQBaseRequest * jq = [[JQBaseRequest alloc]init];
    [jq FarmerOwnerSelectedExtensiobMessageWithProducerID:[ud objectForKey:UserID] complete:^(NSDictionary *responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]] == YES) {
            if ([[responseObject allKeys] containsObject:@"createtime"] == YES) {
                _textField.text = responseObject[@"createtime"];
            }
            if ([[responseObject allKeys] containsObject:@"description"] == YES) {
                _textView.text = responseObject[@"description"];
            }
        }
        if (_textView.text.length > 0) {
            _textView.alpha = 1;
        }
    } fail:^(NSError *error, NSString *errorString) {
        
    }];
}

#pragma mark  --创建imagepick
- (void)addButtonClick {
    
    if (_dataArray.count + _requestDataArray.count < 8) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]==NO) {
            NSLog(@"设备不可用");
        }
        _imagePickerController = [[UIImagePickerController alloc] init];
        
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //设置代理
        _imagePickerController.delegate = self;
        
        [self presentViewController:_imagePickerController animated:YES completion:nil];
    }else{
       
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"友情提示", @"") message: NSLocalizedString(@"最多上传8张哦！", @"") preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * otherAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"点击继续", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:otherAction];
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
    }
    
    
    
    
}
#pragma mark  ---创建actionsheet(清理缓存)
- (void)createActionSheet
{
    UIAlertController*alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction * otherAction1 = [UIAlertAction  actionWithTitle:NSLocalizedString(@"确定要退出登录?", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
           }];
    UIAlertAction * otherAction2 = [UIAlertAction  actionWithTitle:NSLocalizedString(@"取消", @"") style:UIAlertActionStyleCancel handler:^(UIAlertAction*action) {
        
        
    }];
    [alertController addAction:otherAction1];
    [alertController addAction:otherAction2];
    [self presentViewController:alertController animated:YES completion:nil];
}
#pragma mark -UIImagePickerController的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{

//    _image = info[UIImagePickerControllerOriginalImage];
    [_dataArray addObject:info[UIImagePickerControllerOriginalImage]];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self createScrollerView];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self createScrollerView];
    
}
- (void)viewDidLoad {
    self.navigationItem.title = NSLocalizedString(@"我的证书", @"");
    [super viewDidLoad];
    _isJianPan = NO;
    self.navigationController.navigationBar.translucent = NO;
    if ([[[UIDevice currentDevice]systemVersion]doubleValue] > 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    [self createBackLeftButton];
    [self createUI];
    _dataArray = [[NSMutableArray alloc]init];
    _requestDataArray = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view.
    [self createScrollerView];
    [self requestConfirmBook];
    [self userSelectedextensionMessage];//用户查询扩展信息
    
}

#pragma mark  --查询证书
- (void)requestConfirmBook
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    JQBaseRequest * jq = [[JQBaseRequest alloc]init];
    [jq FarmerSelectedConfirmBookWithProducerID:[ud objectForKey:UserID] complete:^(NSDictionary *responseObject) {
        _requestDataArray = responseObject[@"List"];
        [self createScrollerView];
    } fail:^(NSError *error, NSString *errorString) {
        
    }];
}

//创建scrollerView
- (void)createScrollerView
{
    _scrollerView  = [[UIScrollView alloc]initWithFrame:CGRectMake(198 * scaleWidth, 88 * scaleHeight, Screen_Width - 194 * scaleWidth, 150 * scaleHeight)];
    _scrollerView.backgroundColor = [UIColor whiteColor];
    _scrollerView.contentSize = CGSizeMake((_dataArray.count + _requestDataArray.count + 1) * 174 * scaleWidth, 150 * scaleHeight);
    // 是否整页滑动
    _scrollerView.pagingEnabled = NO;
    // 关掉水平滚动条
    _scrollerView.showsHorizontalScrollIndicator = NO;
    // 关掉垂直滚动条
    _scrollerView.showsVerticalScrollIndicator = NO;
    // 设置滚动风格
    _scrollerView.indicatorStyle = UIScrollViewIndicatorStyleDefault;
    _scrollerView.bounces = NO;
    _scrollerView.scrollEnabled = YES;
    _scrollerView.delegate = self;
    [self.view addSubview:_scrollerView];
    
    for (int i = 0; i < _dataArray.count + _requestDataArray.count; i++) {
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(i * 174 * scaleWidth, 0, 150 * scaleWidth, 150 * scaleHeight)];
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * 174 * scaleWidth, 0, 150 * scaleWidth, 150 * scaleHeight)];
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 110 * scaleHeight, 150 * scaleWidth, 40 * scaleHeight)];
        btn.tag = 200 + i;
        [btn addTarget:self action:@selector(deleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:NSLocalizedString(@"删除", @"") forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.backgroundColor = BaseColor(0, 0, 0, 0.6);
        [button addSubview:btn];
        button.tag = 100 + i;
        [button addTarget:self action:@selector(BeBiger:) forControlEvents:UIControlEventTouchUpInside];
        if (i >= _requestDataArray.count) {
            imageView.image =_dataArray[i - _requestDataArray.count];
        }else{
            [imageView sd_setImageWithURL:[NSURL URLWithString:_requestDataArray[i][@"smallcertificateurl"]] placeholderImage:[UIImage imageNamed:@"600.png"]];
        }
        [_scrollerView addSubview:imageView];
        [_scrollerView addSubview:button];
        
    }
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(( _dataArray.count + _requestDataArray.count) * 174 * scaleWidth, 0, 150 * scaleWidth, 150 * scaleHeight)];
    [button setImage:[UIImage imageNamed:@"grzx_wdzs_btn_tianjia.png"] forState:UIControlStateNormal];
    [_scrollerView addSubview:button];
    [button addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark  －－点击图片变大
- (void)BeBiger:(UIButton *)button
{
    confirmBookDetailViewController * cvc = [[confirmBookDetailViewController alloc]init];
    if (button.tag - 100 >= _requestDataArray.count) {
        UIImage * image = _dataArray[(button.tag - 100 - _requestDataArray.count)];
        cvc.IsUrl = NO;
        cvc.image = image;
    }else{
        cvc.IsUrl = YES;
        cvc.urlString = _requestDataArray[button.tag - 100][@"smallcertificateurl"];
    }
    [self presentViewController:cvc animated:NO completion:^{
        
    }];
}

#pragma mark 删除
- (void)deleButtonClick:(UIButton *)button
{
    if (button.tag - 200 >= _requestDataArray.count) {
        [_dataArray removeObjectAtIndex:(button.tag - 200 - _requestDataArray.count)];
    }else{
        JQBaseRequest * jq = [[JQBaseRequest alloc]init];
        [jq FarmerOwnerDeleteConfirmBookWithCertificationID:_requestDataArray[button.tag - 200][@"id"] complete:^(NSDictionary *responseObject) {
            NSLog(@"dadsada%@", responseObject);
        } fail:^(NSError *error, NSString *errorString) {
            NSLog(@"%@", errorString);
        }];
        [_requestDataArray removeObjectAtIndex:(button.tag - 200)];
    }
    [self createScrollerView];
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
    UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(24 * scaleWidth, 40 * scaleHeight, 600 * scaleWidth, 28 * scaleHeight)];
    NSDictionary* style1 = @{@"body":[UIFont systemFontOfSize:21],
                             @"color1": BaseColor(52, 52, 52, 1),
                             @"color2": BaseColor(178, 178, 178, 1)
                             };
    lable.attributedText = [[NSString stringWithFormat:@"<color1>%@ </color1> <color2>(%@)</color2>", NSLocalizedString(@"上传产品图片", @""),NSLocalizedString(@"最多上传8张图片", @"")] attributedStringWithStyleBook:style1];
    [self.view addSubview:lable];
    lable.adjustsFontSizeToFitWidth = YES;
    
    UIButton * btn  =[[UIButton alloc]initWithFrame:CGRectMake(24 * scaleWidth, 88 * scaleHeight, 150 * scaleWidth, 150 * scaleHeight)];
    [self.view addSubview:btn];
    [btn setImage:[UIImage imageNamed:@"grzx_wdzs_btn_paizhao.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(paizhaoClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(24 * scaleWidth, 278 * scaleHeight, Screen_Width - 48 * scaleWidth, 80 * scaleHeight)];
    _textField.placeholder = NSLocalizedString(@"农场创建时间", @"");
    _textField.delegate = self;
    _textField.layer.contents =(id) [[UIImage imageNamed:@"zhuce2_input.png"]CGImage];
    [_textField setValue:BaseColor(52, 52, 52, 0.3) forKeyPath:@"_placeholderLabel.textColor"];
    [_textField setValue:_textField.font forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:_textField];
    
    _textView2  = [[UITextView alloc]initWithFrame:CGRectMake(24 * scaleWidth, 378 * scaleHeight, Screen_Width - 48 * scaleWidth, 240 * scaleHeight)];
    _textView2.layer.contents =(id) [[UIImage imageNamed:@"zhuce2_input.png"]CGImage];
    [self.view addSubview:_textView2];
    _textView2.text = NSLocalizedString(@"农场介绍", @"");
    _textView2.delegate = self;
    _textView2.textColor = BaseColor(52, 52, 52, 0.3);
    
    _textView  = [[UITextView alloc]initWithFrame:CGRectMake(24 * scaleWidth, 378 * scaleHeight, Screen_Width - 48 * scaleWidth, 240 * scaleHeight)];
    _textView.layer.contents =(id) [[UIImage imageNamed:@"zhuce2_input.png"]CGImage];
    [self.view addSubview:_textView];
    _textView.alpha = 0.1;
    _textView.delegate = self;
    
    _textView.font = _textField.font;
    _textView2.font = _textField.font;
    
    
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"shouye_btn_denglu_n.png"] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(commitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(24 * scaleWidth, 770 * scaleHeight, Screen_Width - 48 * scaleWidth, 80 * scaleHeight);
    [button setTitle:NSLocalizedString(@"完成", @"") forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
}

#pragma mark  --拍照
- (void)paizhaoClick
{
    if (_dataArray.count + _requestDataArray.count < 8) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]==NO) {
            NSLog(@"设备不可用");
        }
        _imagePickerController = [[UIImagePickerController alloc] init];
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]==YES) {
            //相机可用
            _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        }else{
            //媒体库
            _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        
        //设置代理
        _imagePickerController.delegate = self;
        
        [self presentViewController:_imagePickerController animated:YES completion:nil];
    }else{
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"友情提示", @"") message: NSLocalizedString(@"最多上传8张哦！", @"") preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * otherAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"点击继续", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:otherAction];
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
    }
    
}



#warning 提交按钮被电击
- (void)commitButtonClick
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    JQBaseRequest * jq = [[JQBaseRequest alloc]init];
    NSMutableArray * array = [[NSMutableArray alloc]init];
    for (int i = 0; i < _dataArray.count; i++) {
        UIImage * image = _dataArray[i];
        NSData *data1 = [self resetSizeOfImageData:image
                                           maxSize:100];
        NSData *data2 = [self resetSizeOfImageData:image
                                           maxSize:100];
        NSString *encodedImageStr1 = [data1 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        NSString *encodedImageStr2 = [data2 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        // 获得系统时区
        NSTimeZone *tz = [NSTimeZone systemTimeZone];
        // 获得当前时间距离GMT时间相差的秒数!
        NSInteger seconds = [tz secondsFromGMTForDate:[NSDate
                                                       date]];
        // 以[NSDate date]时间为基准,间隔seconds秒后的时间!
        NSDate *localDate = [NSDate dateWithTimeInterval:seconds sinceDate:[NSDate date]];
        NSString * str = [dateFormatter stringFromDate:localDate];
        
        NSDictionary * dict = @{ @"CertificateId":@"",@"CertficateTime":str, @"BigPicture":encodedImageStr1, @"SmallPicture":encodedImageStr2};
        [array addObject:dict];
    }
    
    
    NSDictionary * dict2 = @{@"Count":[NSString stringWithFormat:@"%ld", _dataArray.count], @"List":array};
    [jq FarmerOwnerRegisterOrAlertConfirmBookWithProducerID:[ud objectForKey:UserID] dictMessage:dict2 complete:^(NSDictionary *responseObject) {
        NSDictionary * dict3 = @{@"Description":_textView.text, @"CreateTime":_textField.text};
        [jq FarmerOwnerRegisterOrAlertExtensionMessageWithProducerID:[ud objectForKey:UserID] dictMessage:dict3 complete:^(NSDictionary *responseObject) {
            [self.navigationController popViewControllerAnimated:YES];
        } fail:^(NSError *error, NSString *errorString) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
    } fail:^(NSError *error, NSString *errorString) {
        NSDictionary * dict3 = @{@"Description":_textView.text, @"CreateTime":_textField.text};
        [jq FarmerOwnerRegisterOrAlertExtensionMessageWithProducerID:[ud objectForKey:UserID] dictMessage:dict3 complete:^(NSDictionary *responseObject) {
            [self.navigationController popViewControllerAnimated:YES];
        } fail:^(NSError *error, NSString *errorString) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }];
    
}

//调整图片的大小以及分辨率
- (NSData *)resetSizeOfImageData:(UIImage *)source_image maxSize:(NSInteger)maxSize
{
    //先调整分辨率
    
    CGSize newSize = CGSizeMake(source_image.size.width, source_image.size.height);
    
    CGFloat tempHeight = newSize.height / 1024;
    CGFloat tempWidth = newSize.width / 1024;
    
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(source_image.size.width / tempWidth, source_image.size.height / tempWidth);
    }
    else if (tempHeight > 1.0 && tempWidth < tempHeight){
        newSize = CGSizeMake(source_image.size.width / tempHeight, source_image.size.height / tempHeight);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [source_image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //调整大小
    NSData *imageData = UIImageJPEGRepresentation(newImage,1.0);
    NSUInteger sizeOrigin = [imageData length];
    NSUInteger sizeOriginKB = sizeOrigin / 1024;
    if (sizeOriginKB > maxSize) {
        NSData *finallImageData = UIImageJPEGRepresentation(newImage,0.10);
        return finallImageData;
    }
    
    return imageData;
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
