//
//  HPFoodWebVC.h
//  orangeLife
//
//  Created by 张俊凯 on 16/8/5.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HPFoodWebVC : UIViewController<UIWebViewDelegate>
@property(nonatomic,strong)NSString *urlStr;

@property(nonatomic,assign)NSUInteger index;
- (id)initWithIndex:(NSUInteger)index;

@end
