//
//  TimeString.m
//  农帮乐
//
//  Created by hpz on 15/12/8.
//  Copyright © 2015年 jingqi. All rights reserved.
//

#import "TimeString.h"


@implementation TimeString

//lastTime "2015-12-18 15:33:25"
- (NSString *)getDayTimeFromLastmodifiedtime:(NSString *)lastTime {
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //字符串转化成格林威治时间
    NSDate *date = [df dateFromString:lastTime];
    //转化成北京时间
    NSTimeZone *tz = [NSTimeZone systemTimeZone];
    NSDate *localDate = [NSDate dateWithTimeInterval:[tz secondsFromGMTForDate:date] sinceDate:date];
        //此时和localDate的时间间隔
    float timeInterval = [[NSDate dateWithTimeInterval:[tz secondsFromGMTForDate:[NSDate date]] sinceDate:[NSDate date]] timeIntervalSinceDate:localDate];
   
    //分钟前
    if ((int)timeInterval / 60 == 0) {
        return [NSString stringWithFormat:@"%@", NSLocalizedString(@"Just", @"")];
    }
    else if (timeInterval / 60 < 60 && (int)timeInterval / 60 != 0) {
        return [NSString stringWithFormat:@"%d%@", (int)timeInterval / 60, NSLocalizedString(@"Minutes ago", @"")];
    }
    //小时前
    else if (timeInterval / 24 / 3600  < 1) {
        return [NSString stringWithFormat:@"%d%@", (int)timeInterval / 3600, NSLocalizedString(@"Hours ago", @"")];
    }
    
    else if (timeInterval / 24 / 3600 == 1) {
        NSString *timeStr = [NSString stringWithFormat:@"%f", timeInterval / 24 / 2600];
        NSArray *array = [timeStr componentsSeparatedByString:@"."];
        NSInteger count = 0;
        if (array.count == 2) {
            NSString *str = array[1];
            unichar ch = [str characterAtIndex:0];
            if (ch >= 5) {
                count = [array[0] integerValue] + 1;
            }
            else {
                count = [array[0] integerValue];
            }
        }
        return [NSString stringWithFormat:@"%ld%@",(long)count, NSLocalizedString(@"days ago", @"")];
 
    }
    //大于2天的时候就换成 yyyy-MM-dd HH:mm:ss
    else {
        
        NSArray *array = [lastTime componentsSeparatedByString:@" "];
        if (array.count == 2) {
            NSArray *arr1 = [array[0] componentsSeparatedByString:@"-"];
            NSArray *arr2 = [array[1] componentsSeparatedByString:@":"];
            if (arr1.count == 3 && arr2.count == 3) {
                return [NSString stringWithFormat:@"%@月%@日 %@:%@",arr1[1],arr1[2],arr2[0],arr2[1]];
            }
        }
        return nil;
    }
}

@end
