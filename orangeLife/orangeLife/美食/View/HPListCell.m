//
//  HPListCell.m
//  orangeLife
//
//  Created by 张俊凯 on 16/8/9.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "HPListCell.h"

@implementation HPListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self customInit];
    }
    return self;
}

-(void)customInit
{
    _coverView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, JKScreenW - 30, 200)];
    _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(25, 150, JKScreenW - 30, 20)];
    _titleLab.font = [UIFont systemFontOfSize:18];
    [_titleLab setTextColor:[UIColor whiteColor]];
    _userNameLab = [[UILabel alloc] initWithFrame:CGRectMake(25, 170, JKScreenW - 30, 15)];
    _userNameLab.font = [UIFont systemFontOfSize:12];
    [_userNameLab setTextColor:[UIColor whiteColor]];
    _introLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 200, JKScreenW - 30 ,                  0)];
    _introLab.font = [UIFont systemFontOfSize:14];
    [_introLab setTextColor:[UIColor blackColor]];
    [_introLab setNumberOfLines:0];
    
    
    UIImage *bigLabImg = [UIImage imageNamed:@"yuan_03.png"];
    UIImage *showLabImg = [UIImage imageNamed:@"yuan_06.png"];
    UIImage *likeImg = [UIImage imageNamed:@"like_show@2x.png"];
   
    _bigLabView = [[UIImageView alloc] init];
    _bigLabView.frame = CGRectMake(15, 0,likeImg.size.width, likeImg.size.height);
    _bigLabView.center = CGPointMake((JKScreenW - 30)/2.0f, 200/2.0f);
    [_bigLabView setImage:likeImg];
    [_bigLabView setAlpha:0];
    
    _likeImgView = [[UIImageView alloc] init];
    _likeImgView.frame = CGRectMake(JKScreenW - 80, 150, 42, 42);
    [_likeImgView setImage:bigLabImg];
    
    _showLabView = [[UIImageView alloc] initWithFrame:CGRectMake(JKScreenW - 50, 175, showLabImg.size.width, showLabImg.size.height)];
    [_showLabView setImage:showLabImg];
    
    _showLab = [[UILabel alloc] init];
    _showLab.frame = CGRectMake(JKScreenW - 50, 180, showLabImg.size.width, 10);
    [_showLab setTextAlignment:NSTextAlignmentCenter];
    _showLab.font = [UIFont systemFontOfSize:8];
    [_showLab setTextColor:[UIColor whiteColor]];
    
    
    _likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *btnNor = [UIImage imageNamed:@"ico_orange_love.png"];
    [_likeBtn setFrame:CGRectMake(JKScreenW - 68, 162, 20, 20)];
    [_likeBtn setImage:btnNor forState:UIControlStateNormal];
    
    [_likeBtn addTarget:self action:@selector(likeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //顺序添加子视图
    [self.contentView addSubview:_coverView];
    [self.contentView addSubview:_titleLab];
    [self.contentView addSubview:_userNameLab];
    [self.contentView addSubview:_introLab];
    [self.contentView addSubview:_bigLabView];
    [self.contentView addSubview:_likeImgView];
    [self.contentView addSubview:_showLabView];
    [self.contentView addSubview:_showLab];
    [self.contentView addSubview:_likeBtn];
   
}

//点击按钮切换是否选中状态，实现图片的放大，改变背景等功能
- (void)likeBtnClick:(UIButton *)btn
{
    JKLog(@"likeBtnClick");
    if (self.isClick) {
        self.isClick = NO;
        [btn setSelected:NO];
        [UIView animateWithDuration:0.5 animations:^{
            [btn setImage:[UIImage imageNamed:@"ico_orange_love.png"] forState:UIControlStateSelected];
            [btn setAlpha:0.5];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        } completion:^(BOOL finished) {
            [btn setAlpha:1];
        }];
        
    }
    else
    {
        self.isClick = YES;
        [btn setSelected:YES];
        [UIView animateWithDuration:1 animations:^{
            [btn setImage:[UIImage imageNamed:@"ico_orange_love_on.png"] forState:UIControlStateSelected];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
            _bigLabView.center = CGPointMake((JKScreenW - 30)/2.0f, 200/2.0f);
            
            [_bigLabView setAlpha:1.0f];
        } completion:^(BOOL finished) {
            [_bigLabView setAlpha:0];
        }];
    }
    
}


@end
