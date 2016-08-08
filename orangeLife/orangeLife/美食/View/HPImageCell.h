//
//  HPImageCell.h
//  orangeLife
//
//  Created by 张俊凯 on 16/8/8.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HPImageCell : UITableViewCell
//大图
@property(nonatomic,strong)UIImageView *coverImgView;
//左边图标
@property(nonatomic,strong)UIImageView *iconView;
//标题
@property(nonatomic,strong)UILabel *titleLabel;
//介绍文本
@property(nonatomic,strong)UILabel *introLabel;
//小图
@property(nonatomic,strong)UIImageView *smallCoverImgView;
//图片内部的文本介绍
@property(nonatomic,strong)UILabel *imgIntroLabel;
@end
