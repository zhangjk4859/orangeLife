//
//  HPFoodMenuVC.h
//  orangeLife
//
//  Created by 张俊凯 on 16/8/9.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HPFoodMenuVC : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property(nonatomic,assign)NSUInteger recipeId;

@end
