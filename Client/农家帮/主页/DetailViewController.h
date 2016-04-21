//
//  DetailViewController.h
//  农帮乐
//
//  Created by hpz on 15/12/9.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController


@property (nonatomic, strong) NSArray *ProductImages;
@property (nonatomic, strong) NSDictionary *ProductInfo;
@property (nonatomic, strong) NSDictionary *ProducerInfo;


@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *telphone;
@property (nonatomic, copy) NSString *dizhi;


@property (nonatomic, strong) UITableView *tableView;


@end
