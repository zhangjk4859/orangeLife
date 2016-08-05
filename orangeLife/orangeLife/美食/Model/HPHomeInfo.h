//
//  HPHomeInfo.h
//  orangeLife
//
//  Created by 张俊凯 on 16/8/5.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    ad = 0,
    rank,
    recipe,
    table,
    tag,
}kType;

@interface HPHomeInfo : NSObject
@property(nonatomic,copy)NSString *cover;
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,assign)NSInteger *sortIndex;
@property(nonatomic,assign)kType *type;
@property(nonatomic,copy)NSString *haodouId;
@property(nonatomic,copy)NSString *rankType;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *intro;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSArray *smallCover;
@property(nonatomic,copy)NSString *urlToList;
@property(nonatomic,copy)NSString *keyWord;
@property(nonatomic,copy)NSString *rTitle;
@property(nonatomic,copy)NSString *desc;
@property(nonatomic,copy)NSString *userName;
//searcherBar
@property(nonatomic,copy)NSString *likeCount;
@property(nonatomic,copy)NSString *viewCount;
@property(nonatomic,copy)NSString *stuff;//文本描述
//专辑内cellalbum中的相关信息
@property(nonatomic,copy)NSString *albumAvatarUrl;
@property(nonatomic,copy)NSString *albumContent;
@property(nonatomic,copy)NSString *albumCover;
@property(nonatomic,copy)NSString *albumTitle;
@property(nonatomic,copy)NSString *albumUserName;
//list
@property(nonatomic,copy)NSString *collection;
@property(nonatomic,copy)NSString *recipeId;
@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSArray *tags;
@property(nonatomic,copy)NSString *IdStr;

@end
