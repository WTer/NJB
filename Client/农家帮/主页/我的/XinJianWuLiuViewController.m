//
//  XinJianWuLiuViewController.m
//  农家帮
//
//  Created by 赵波 on 16/3/8.
//  Copyright © 2016年 jingqi. All rights reserved.
//

#import "XinJianWuLiuViewController.h"
#import "TfButton.h"
#import "AreaButton.h"

@interface XinJianWuLiuViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITextField *name;
@property (nonatomic, strong) AreaButton *type;
@property (nonatomic, strong) UITextField *address;
@property (nonatomic, strong) UITextField *telephone;
@property (nonatomic, strong) UITextField *discount;
@property (nonatomic, strong) UITextField *descrip;
@property (nonatomic, strong) UITapGestureRecognizer *tap;

@end

@implementation XinJianWuLiuViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"新建物流信息";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadViews];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadViews
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    
    [self.view addGestureRecognizer:tap];
    _tap = tap;
    CGFloat y = 24, width = Screen_Width-48;
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(24, y, width, 80 * scaleHeight)];
    textField.background = [UIImage imageNamed:@"zhuce3-2_input.png"];
    textField.clearButtonMode = UITextFieldViewModeAlways;
    //    textField.delegate = self;
    CGSize companyWebSize = [NSLocalizedString(@"物流商", @"") sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(990, 100)];
    TfButton *companyWebLeft = [[TfButton alloc] initWithFrame:CGRectMake(0, 0, companyWebSize.width + 90, 80 * scaleHeight)];
    [companyWebLeft setTitle:NSLocalizedString(@"物流商", @"") forState:UIControlStateNormal];
    [companyWebLeft setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [companyWebLeft setImage:[UIImage imageNamed:@"zhuce3-2_icon_wangzhan.png"] forState:UIControlStateNormal];
    companyWebLeft.userInteractionEnabled = NO;
    textField.leftView = companyWebLeft;
    textField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:textField];
    _name = textField;

    y = CGRectGetMaxY(textField.frame)+10;
    
    AreaButton *areaButton = [[AreaButton alloc] initWithFrame:CGRectMake(24, y, width, 80 * scaleHeight)];
    [areaButton setBackgroundImage:[UIImage imageNamed:@"zhuce3-2_btn_xuanzedizhi.png"] forState:UIControlStateNormal];
    [areaButton setTitle:NSLocalizedString(@"物流类型", @"") forState:UIControlStateNormal];
    [areaButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [areaButton setImage:[UIImage imageNamed:@"zhuce3-2_btn_icon_xiala.png"] forState:UIControlStateNormal];
    [areaButton addTarget:self action:@selector(wuLiuLeiXing) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:areaButton];
    _type = areaButton;
    
    y = CGRectGetMaxY(areaButton.frame)+10;
    
    textField = [[UITextField alloc] initWithFrame:CGRectMake(24, y, width, 80 * scaleHeight)];
    textField.background = [UIImage imageNamed:@"zhuce3-2_input.png"];
    textField.clearButtonMode = UITextFieldViewModeAlways;
    //    textField.delegate = self;
    companyWebSize = [NSLocalizedString(@"地址", @"") sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(990, 100)];
    companyWebLeft = [[TfButton alloc] initWithFrame:CGRectMake(0, 0, companyWebSize.width + 90, 80 * scaleHeight)];
    [companyWebLeft setTitle:NSLocalizedString(@"地址", @"") forState:UIControlStateNormal];
    [companyWebLeft setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [companyWebLeft setImage:[UIImage imageNamed:@"zhuce3-2_icon_wangzhan.png"] forState:UIControlStateNormal];
    companyWebLeft.userInteractionEnabled = NO;
    textField.leftView = companyWebLeft;
    textField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:textField];
    _address = textField;
    
    y = CGRectGetMaxY(textField.frame)+10;

    textField = [[UITextField alloc] initWithFrame:CGRectMake(24, y, width, 80 * scaleHeight)];
    textField.background = [UIImage imageNamed:@"zhuce3-2_input.png"];
    textField.clearButtonMode = UITextFieldViewModeAlways;
    //    textField.delegate = self;
    companyWebSize = [NSLocalizedString(@"联系电话", @"") sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(990, 100)];
    companyWebLeft = [[TfButton alloc] initWithFrame:CGRectMake(0, 0, companyWebSize.width + 90, 80 * scaleHeight)];
    [companyWebLeft setTitle:NSLocalizedString(@"联系电话", @"") forState:UIControlStateNormal];
    [companyWebLeft setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [companyWebLeft setImage:[UIImage imageNamed:@"zhuce3-2_icon_wangzhan.png"] forState:UIControlStateNormal];
    companyWebLeft.userInteractionEnabled = NO;
    textField.leftView = companyWebLeft;
    textField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:textField];
    _telephone = textField;
    
    y = CGRectGetMaxY(textField.frame)+10;

    textField = [[UITextField alloc] initWithFrame:CGRectMake(24, y, width, 80 * scaleHeight)];
    textField.background = [UIImage imageNamed:@"zhuce3-2_input.png"];
    textField.clearButtonMode = UITextFieldViewModeAlways;
    //    textField.delegate = self;
    companyWebSize = [NSLocalizedString(@"物流商", @"") sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(990, 100)];
    companyWebLeft = [[TfButton alloc] initWithFrame:CGRectMake(0, 0, companyWebSize.width + 90+40, 80 * scaleHeight)];
    [companyWebLeft setTitle:NSLocalizedString(@"运费折扣率", @"") forState:UIControlStateNormal];
    [companyWebLeft setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [companyWebLeft setImage:[UIImage imageNamed:@"zhuce3-2_icon_wangzhan.png"] forState:UIControlStateNormal];
    companyWebLeft.userInteractionEnabled = NO;
    textField.leftView = companyWebLeft;
    textField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:textField];
    _discount = textField;
    
    y = CGRectGetMaxY(textField.frame)+10;
    
    textField = [[UITextField alloc] initWithFrame:CGRectMake(24, y, width, 80 * scaleHeight)];
    textField.background = [UIImage imageNamed:@"zhuce3-2_input.png"];
    textField.clearButtonMode = UITextFieldViewModeAlways;
    //    textField.delegate = self;
    companyWebSize = [NSLocalizedString(@"备注", @"") sizeWithFont:[UIFont systemFontOfSize:18.0] maxSize:CGSizeMake(990, 100)];
    companyWebLeft = [[TfButton alloc] initWithFrame:CGRectMake(0, 0, companyWebSize.width + 90, 80 * scaleHeight)];
    [companyWebLeft setTitle:NSLocalizedString(@"备注", @"") forState:UIControlStateNormal];
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
    [button setTitle:@"提交物流信息" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)action:(UIControl *)sender
{
    JQBaseRequest * jq = [[JQBaseRequest alloc]init];
    
    [jq wuLiuBanKuaiWithDic:@{@"Name":_name.text, @"Type":_type.titleLabel.text, @"Address":_address.text,@"Telephone":_telephone.text, @"Discount":_discount.text, @"Description":_descrip.text}
                              complete:^(NSDictionary *responseObject) {
                                  [MBProgressHUD showHUDAddedTo:self.view animated:YES label:@"提交成功" afterDelay:1.5f];
                                  [self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:[NSNumber numberWithBool:YES] afterDelay:1.5];
                              }
                                  fail:^(NSError *error, NSString *errorString) {
                                      [MBProgressHUD showHUDAddedTo:self.view animated:YES label:errorString afterDelay:1.5f];
                                  }];

}

- (void)wuLiuLeiXing
{
    [_name resignFirstResponder];
    [_address resignFirstResponder];
    [_telephone resignFirstResponder];
    [_discount resignFirstResponder];
    [_descrip resignFirstResponder];

    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    
    view.backgroundColor = [UIColor colorWithWhite:.5f alpha:.5f];
    [self.view addSubview:view];
    [self.view removeGestureRecognizer:_tap];
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width-150, 236)];
    
    table.scrollEnabled = NO;
    table.center = view.center;
    table.delegate = self;
    table.dataSource = self;
    [view addSubview:table];
}

- (void)tap:(UITapGestureRecognizer *)tap
{
    [_name resignFirstResponder];
    [_address resignFirstResponder];
    [_telephone resignFirstResponder];
    [_discount resignFirstResponder];
    [_descrip resignFirstResponder];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *labbel = [[UILabel alloc] initWithFrame:CGRectZero];
    
    labbel.text = @"物流类型";
    labbel.backgroundColor = [UIColor grayColor];
    labbel.textColor = [UIColor whiteColor];
    labbel.font = [UIFont systemFontOfSize:18];

    return labbel;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = NSStringFromClass([self class]);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSString *string;

    if (indexPath.row == 0) {
        string = @"同城";
    } else if (indexPath.row == 1) {
        string = @"城际";
    } else if (indexPath.row == 2) {
        string = @"冷链";
    }
    
    cell.textLabel.text = string;
    cell.textLabel.textColor = [UIColor blackColor];
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [tableView.superview removeFromSuperview];
    [_type setTitle:cell.textLabel.text forState:UIControlStateNormal];
    [self.view addGestureRecognizer:_tap];
}

@end
