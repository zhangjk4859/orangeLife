//
//  HPTagButton.m
//  orangeLife
//
//  Created by 张俊凯 on 16/8/8.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "HPTagButton.h"

@implementation HPTagButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.adjustsImageWhenHighlighted = NO;
        
        
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = 5;
    
    return CGRectMake(15, titleY, (JKScreenW - 30) / 4.0f - 15,  20);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 10, 10, 10);
}
@end
