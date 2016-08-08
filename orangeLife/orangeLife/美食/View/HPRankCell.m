//
//  HPRankCell.m
//  orangeLife
//
//  Created by 张俊凯 on 16/8/8.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "HPRankCell.h"

@implementation HPRankCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        _coverImgView = [[UIImageView alloc] init];
        _coverImgView.frame = CGRectMake(15, 0, 80, 50);
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.frame = CGRectMake(110, 0, JKScreenW - 130, 30);
        _titleLabel.font = [UIFont fontWithName:@"bold" size:16];
        
        _introLabel = [[UILabel alloc] init];
        _introLabel.frame = CGRectMake(110, 25, JKScreenW - 130, 30);
        _introLabel.font = [UIFont systemFontOfSize:12];
        [_introLabel setNumberOfLines:3];
        
        [self.contentView addSubview:_coverImgView];
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_introLabel];
        
    }
    return self;
}


@end
