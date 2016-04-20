//
//  ShiMingViewController.m
//  农家帮
//
//  Created by 赵波 on 16/3/7.
//  Copyright © 2016年 jingqi. All rights reserved.
//

#import "ShiMingViewController.h"
#import "TfButton.h"

@interface ShiMingViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) UILabel *status;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UITextField *textField;
@end

@implementation ShiMingViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"实名认证信息";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadViews];
    [self requstStatus];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadViews
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    
    [self.view addGestureRecognizer:tap];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 100)];
    
    label.text = @"实名认证状态：";
    label.font = [UIFont systemFontOfSize:18];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    _status = label;
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(24, 100, Screen_Width-48, 80 * scaleHeight)];
    textField.background = [UIImage imageNamed:@"zhuce3-2_input.png"];
    textField.clearButtonMode = UITextFieldViewModeAlways;
//    textField.delegate = self;
    CGSize companyWebSize = [NSLocalizedString(@"认证标题", @"") sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(990, 100)];
    TfButton *companyWebLeft = [[TfButton alloc] initWithFrame:CGRectMake(0, 0, companyWebSize.width * 2, 80 * scaleHeight)];
    [companyWebLeft setTitle:NSLocalizedString(@"认证标题", @"") forState:UIControlStateNormal];
    [companyWebLeft setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [companyWebLeft setImage:[UIImage imageNamed:@"zhuce3-2_icon_wangzhan.png"] forState:UIControlStateNormal];
    companyWebLeft.userInteractionEnabled = NO;
    textField.leftView = companyWebLeft;
    textField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:textField];
    self.textField = textField;
    
    CGFloat y = CGRectGetMaxY(textField.frame)+24;
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(24, y, Screen_Width-48, 80 * scaleHeight)];
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:16];
    label.text = @"认证材料：";
    [self.view addSubview:label];
    
    y = CGRectGetMaxY(label.frame) + 5;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(74, y, Screen_Width-148, Screen_Width-198)];
    
    imageView.image = [UIImage imageNamed:@"xiangji"];
    [self.view addSubview:imageView];
    self.imageView  = imageView;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.backgroundColor = [UIColor clearColor];
    button.frame = imageView.frame;
    [button addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.tag = 101;
    
    y = CGRectGetMaxY(imageView.frame) + 24;
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor greenColor];
    button.layer.cornerRadius = 8;
    button.layer.masksToBounds = YES;
    button.frame = CGRectMake(50, y, Screen_Width-100, 48);
    [button setTitle:@"提交材料" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 102;
}

- (void)tap:(UITapGestureRecognizer *)tap
{
    [_textField resignFirstResponder];
}

- (void)action:(UIControl *)sender
{
    if (sender.tag == 101) {
        UIActionSheet* actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:nil
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"相机",@"照片图库",nil];
        [actionSheet showInView:self.view];
    } else if (sender.tag == 102) {
        NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
        JQBaseRequest * jq = [[JQBaseRequest alloc]init];
        
        [jq tiJiaoShiMingRenZhengQingQiuWithProducerId:[ud objectForKey:UserID]
                                                 title:_textField.text
                                                   pic:_imageView.image
                                              complete:^(NSDictionary *responseObject) {
                                                  [MBProgressHUD showHUDAddedTo:self.view animated:YES label:@"提交成功！" afterDelay:1.5];
                                                  [self requstStatus];
                                              }
                                                  fail:^(NSError *error, NSString *errorString) {
                                                      [MBProgressHUD showHUDAddedTo:self.view animated:YES label:errorString afterDelay:1.5];
                                                  }];
    }
}

- (void)saveImage:(UIImage *)image
{
    _imageView.image = image;
}

- (void)requstStatus
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    JQBaseRequest * jq = [[JQBaseRequest alloc]init];
    
    [jq chaXunShiMimgRenZhengWith:[ud objectForKey:UserID]
                                          complete:^(NSDictionary *responseObject) {
                                              _status.text = [NSString stringWithFormat:@"实名认证状态：%@", [responseObject valueForKey:@"status"]];
                                          }
                                              fail:^(NSError *error, NSString *errorString) {
                                                  _status.text = [NSString stringWithFormat:@"实名认证状态：%@", errorString];
                                                  [MBProgressHUD showHUDAddedTo:self.view animated:YES label:errorString afterDelay:1.5f];
                                            }];
}

#pragma mark -
#pragma UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0://照相机
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            //            [self presentModalViewController:imagePicker animated:YES];
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
            break;
        case 1://摄像机
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //            [self presentModalViewController:imagePicker animated:YES];
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
            break;
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeImage]) {
        UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
        [self performSelector:@selector(saveImage:)  withObject:img afterDelay:0.5];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //    [picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

// 改变图像的尺寸，方便上传服务器
- (UIImage *) scaleFromImage: (UIImage *) image toSize: (CGSize) size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize
{
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        else{
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}

@end
