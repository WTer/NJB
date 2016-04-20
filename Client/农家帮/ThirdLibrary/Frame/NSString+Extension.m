//
//  NSString+Extension.m
//  cs13
//
//  Created by qianfeng on 15/10/11.
//  Copyright (c) 2015年 wyl. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

//*******************根据字符串的长度返回所需lable的size************************/
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

@end
