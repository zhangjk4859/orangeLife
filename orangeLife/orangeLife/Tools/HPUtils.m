//
//  HPUtils.m
//  orangeLife
//
//  Created by 张俊凯 on 16/8/2.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "HPUtils.h"

@implementation HPUtils
+(NSString *)getCurrentTime
{
    NSDate  * senddate=[NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMddHHmmss"];
    return [dateFormat stringFromDate:senddate];
}
@end
