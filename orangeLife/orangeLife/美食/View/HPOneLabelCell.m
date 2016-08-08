//
//  HPOneLabelCell.m
//  orangeLife
//
//  Created by 张俊凯 on 16/8/8.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "HPOneLabelCell.h"

@implementation HPOneLabelCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
         _coverView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, JKScreenW - 30, 200)];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 200, JKScreenW - 30, 20)];
        _titleLabel.font = [UIFont fontWithName:@"bold" size:16];
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 220, JKScreenW - 30, 30)];
        _descLabel.font  = [UIFont systemFontOfSize:12];
        [_descLabel setNumberOfLines:3];
        
        //        _titleLabel.text = [UIFont boldSystemFontOfSize:16];
        _rTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 150, JKScreenW - 50, 20)];
        _rTitleLabel.font = [UIFont fontWithName:@"bold" size:16];
        [_rTitleLabel setTextColor:[UIColor whiteColor]];
        _introLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 160, JKScreenW - 50, 30)];
        [_introLabel setTextColor:[UIColor whiteColor]];
        _introLabel.font = [UIFont systemFontOfSize:12];
        [_introLabel setNumberOfLines:3];
        
        [self.contentView addSubview:_coverView];
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_introLabel];
        [self.contentView addSubview:_descLabel];
        [self.contentView addSubview:_rTitleLabel];
    }
    return self;
}


@end
