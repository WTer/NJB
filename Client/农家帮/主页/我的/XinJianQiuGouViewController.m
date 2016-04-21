//
//  XinJianQiuGouViewController.m
//  农家帮
//
//  Created by 赵波 on 16/3/8.
//  Copyright © 2016年 jingqi. All rights reserved.
//

#import "XinJianQiuGouViewController.h"
#import "TfButton.h"

@interface XinJianQiuGouViewController ()

@property (nonatomic, strong) UITextField *productType;
@property (nonatomic, strong) UITextField *count;
@property (nonatomic, strong) UITextField *price;
@property (nonatomic, strong) UITextField *descrip;

@end

@implementation XinJianQiuGouViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"新建求购信息";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadViews
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    
    [self.view addGestureRecognizer:tap];
    CGFloat y = 24, width = Screen_Width-48;
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(24, y, width, 80 * scaleHeight)];
    textField.background = [UIImage imageNamed:@"zhuce3-2_input.png"];
    textField.clearButtonMode = UITextFieldViewModeAlways;
    //    textField.delegate = self;
    CGSize companyWebSize = [NSLocalizedString(@"商品类别", @"") sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(990, 100)];
    TfButton *companyWebLeft = [[TfButton alloc] initWithFrame:CGRectMake(0, 0, companyWebSize.width + 90, 80 * scaleHeight)];
    [companyWebLeft setTitle:NSLocalizedString(@"商品类别", @"") forState:UIControlStateNormal];
    [companyWebLeft setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [companyWebLeft setImage:[UIImage imageNamed:@"zhuce3-2_icon_wangzhan.png"] forState:UIControlStateNormal];
    companyWebLeft.userInteractionEnabled = NO;
    textField.leftView = companyWebLeft;
    textField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:textField];
    _productType = textField;
    
    y = CGRectGetMaxY(textField.frame)+10;
    
    textField = [[UITextField alloc] initWithFrame:CGRectMake(24, y, width, 80 * scaleHeight)];
    textField.background = [UIImage imageNamed:@"zhuce3-2_input.png"];
    textField.clearButtonMode = UITextFieldViewModeAlways;
    //    textField.delegate = self;
    companyWebSize = [NSLocalizedString(@"求购数量", @"") sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(990, 100)];
    companyWebLeft = [[TfButton alloc] initWithFrame:CGRectMake(0, 0, companyWebSize.width + 90, 80 * scaleHeight)];
    [companyWebLeft setTitle:NSLocalizedString(@"求购数量", @"") forState:UIControlStateNormal];
    [companyWebLeft setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [companyWebLeft setImage:[UIImage imageNamed:@"zhuce3-2_icon_wangzhan.png"] forState:UIControlStateNormal];
    companyWebLeft.userInteractionEnabled = NO;
    textField.leftView = companyWebLeft;
    textField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:textField];
    _count = textField;
    
    y = CGRectGetMaxY(textField.frame)+10;
    
    textField = [[UITextField alloc] initWithFrame:CGRectMake(24, y, width, 80 * scaleHeight)];
    textField.background = [UIImage imageNamed:@"zhuce3-2_input.png"];
    textField.clearButtonMode = UITextFieldViewModeAlways;
    //    textField.delegate = self;
    companyWebSize = [NSLocalizedString(@"最高价位", @"") sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(990, 100)];
    companyWebLeft = [[TfButton alloc] initWithFrame:CGRectMake(0, 0, companyWebSize.width + 90, 80 * scaleHeight)];
    [companyWebLeft setTitle:NSLocalizedString(@"最高价位", @"") forState:UIControlStateNormal];
    [companyWebLeft setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [companyWebLeft setImage:[UIImage imageNamed:@"zhuce3-2_icon_wangzhan.png"] forState:UIControlStateNormal];
    companyWebLeft.userInteractionEnabled = NO;
    textField.leftView = companyWebLeft;
    textField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:textField];
    _price = textField;
    
    y = CGRectGetMaxY(textField.frame)+10;
    
    textField = [[UITextField alloc] initWithFrame:CGRectMake(24, y, width, 80 * scaleHeight)];
    textField.background = [UIImage imageNamed:@"zhuce3-2_input.png"];
    textField.clearButtonMode = UITextFieldViewModeAlways;
    //    textField.delegate = self;
    companyWebSize = [NSLocalizedString(@"说明和要求", @"") sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(990, 100)];
    companyWebLeft = [[TfButton alloc] initWithFrame:CGRectMake(0, 0, companyWebSize.width + 90, 80 * scaleHeight)];
    [companyWebLeft setTitle:NSLocalizedString(@"说明和要求", @"") forState:UIControlStateNormal];
    [companyWebLeft setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [companyWebLeft setImage:[UIImage imageNamed:@"zhuce3-2_icon_wangzhan.png"] forState:UIControlStateNormal];
    companyWebLeft.userInteractionEnabled = NO;
    textField.leftView = companyWebLeft;
    textField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:textField];
    _descrip = textField;
    
    y = CGRectGetMaxY(textField.frame)+20;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.backgroundColor = [UIColor greenColor];
    button.layer.cornerRadius = 8;
    button.layer.masksToBounds = YES;
    button.frame = CGRectMake(50, y, Screen_Width-100, 60);
    [button setTitle:@"提交求购信息" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)tap:(UITapGestureRecognizer *)tap
{
    [_productType resignFirstResponder];
    [_count resignFirstResponder];
    [_price resignFirstResponder];
    [_descrip resignFirstResponder];
}

- (void)action:(UIControl *)sender
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    JQBaseRequest * jq = [[JQBaseRequest alloc]init];
    
    [jq xinZengQiuGouXinXiWithConsumerId:[ud valueForKey:UserID]
                                     dic:@{@"ProductType":_productType.text, @"Count":_count.text, @"Price":_price.text, @"Description":_descrip.text}
                                complete:^(NSDictionary *responseObject) {
                                    [MBProgressHUD showHUDAddedTo:self.view animated:YES label:@"提交成功" afterDelay:1.5f];
                                    [self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:[NSNumber numberWithBool:YES] afterDelay:1.5];
                                }
                                    fail:^(NSError *error, NSString *errorString) {
                                        [MBProgressHUD showHUDAddedTo:self.view animated:YES label:errorString afterDelay:1.5f];
                                    }];
}


@end
