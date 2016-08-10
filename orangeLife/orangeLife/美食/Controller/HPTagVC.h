//
//  HPTagVC.h
//  orangeLife
//
//  Created by 张俊凯 on 16/8/10.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HPTagVC : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,assign)NSInteger tagId;
-(id)initWithTag:(NSUInteger)tageID;


@end
