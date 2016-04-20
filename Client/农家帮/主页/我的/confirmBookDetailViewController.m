//
//  confirmBookDetailViewController.m
//  农帮乐
//
//  Created by 王朝源 on 15/12/15.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "confirmBookDetailViewController.h"

@interface confirmBookDetailViewController ()

@end

@implementation confirmBookDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView * view = [[UIImageView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:view];
    if (_IsUrl) {
        [view sd_setImageWithURL:[NSURL URLWithString:_urlString] placeholderImage:[UIImage imageNamed:@"600.png"]];
    }else{
        view.image = _image;
    }
    
    view.userInteractionEnabled = YES;
    // Do any additional setup after loading the view.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}

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
