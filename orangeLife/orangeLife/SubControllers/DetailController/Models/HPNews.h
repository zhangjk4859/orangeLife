//
//  HPNews.h
//  orangeLife
//
//  Created by 张俊凯 on 16/8/2.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HPNews : NSObject
/**
 *  <#注释#>
 */
@property(nonatomic,copy)NSString *source;
@property(nonatomic,copy)NSArray *imageurls;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *link;
@property(nonatomic,copy)NSString *pubDate;
@property(nonatomic,copy)NSString *desc;
@end
