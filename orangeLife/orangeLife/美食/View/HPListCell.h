//
//  HPListCell.h
//  orangeLife
//
//  Created by 张俊凯 on 16/8/9.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HPListCell : UITableViewCell
@property(nonatomic,strong)UIImageView *coverView;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *userNameLab;
@property(nonatomic,strong)UIButton *likeBtn;
@property(nonatomic,strong)UIImageView *likeImgView;
@property(nonatomic,strong)UILabel *introLab;
@property(nonatomic,strong)UIImageView *bigLabView;
@property(nonatomic,strong)UIImageView *showLabView;
@property(nonatomic,strong)UILabel *showLab;
@property(nonatomic,assign)BOOL isClick;
@end
