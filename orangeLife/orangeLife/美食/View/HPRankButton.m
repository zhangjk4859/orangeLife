//
//  HPRankButton.m
//  orangeLife
//
//  Created by 张俊凯 on 16/8/8.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "HPRankButton.h"

@implementation HPRankButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        _textLabel = [[UILabel alloc] init];
        _textLabel.frame = CGRectMake(15, 0, 100, 30);
        [_textLabel setFont:[UIFont systemFontOfSize:16]];
        
        _moreLabel = [[UILabel alloc] init];
        _moreLabel.frame = CGRectMake(JKScreenW -80, 0, 100, 30);
        [_moreLabel setFont:[UIFont systemFontOfSize:12]];
        
        [self addSubview:_textLabel];
        [self addSubview:_moreLabel];
        
        
    }
    
    return self;
}


@end
