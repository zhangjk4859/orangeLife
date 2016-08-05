//
//  HPHomeModel.h
//  orangeLife
//
//  Created by 张俊凯 on 16/8/5.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HPHomeInfo.h"


//定义Block
//这里的Block可以设置为返回多个参数
typedef void (^TagBlock)(BOOL isSucess,NSMutableArray *dataDic);
typedef void (^HomeBlock)(BOOL isSucess, NSMutableArray *dataDic);
typedef void (^SearchBlock)(BOOL isSucess, NSMutableArray *dataDic);
typedef void (^AidBlock)(BOOL isSucess,NSMutableArray *dataArr);
typedef void (^TitleBlock)(BOOL isSucess, NSMutableArray *dataArr);

@interface HPHomeModel : NSObject

@property(nonatomic,assign)NSInteger offset;
@property(nonatomic, strong)NSMutableArray *dataArray;
//数组中存一个字典，字典中有两个key
- (void)refreshData:(HomeBlock)homeBlock;
- (void)getSearchData:(SearchBlock)searchBlock;
- (void)getHotData:(HomeBlock)homeBlock;
//返回点击tag后的数据
- (void)getTagDataWithLimit:(NSString *)limit andOffset:(NSString *)offset andScene:(NSString *)scene andSign:(NSString *)sign andTagid:(NSString *)tagid andUid:(NSString *)uid andUuid:(NSString *)uuid TagBlock:(TagBlock)tagBlock;

//获得专辑中的数据
- (void)getAidDataWithAid:(NSString *)aid andLimit:(NSString *)limit andOffset:(NSString *)offset andSign:(NSString *)sign andUid:(NSString *)uid andUuid:(NSString *)uuid andAidBlock:(AidBlock)aidBlock;

//获得热门等的数据
- (void)getTitleWithTitle:(NSString *)title andLimit:(NSString *)limit andOffset:(NSString *)offset andRid:(NSString *)rid andSign:(NSString *)sign andType:(NSString *)type andUid:(NSString *)uid andUuid:(NSString *)uuid andTitleBlock:(TitleBlock)titleBlock;
//这个是获得更多榜单下面的数据，后期只要改变一个id就能传值

//更多榜单,反馈意见


- (void)getRankMoreWithLimit:(NSString *)limit andOffset:(NSString *)offset andTagid:(NSString *)tagid andType:(NSString *)type andHomeBlock:(HomeBlock)homeBlock;

- (void)RefreshgetRankMoreWithLimit:(NSString *)limit andTagid:(NSString *)tagid andType:(NSString *)type andHomeBlock:(HomeBlock)homeBlock;
//- (HPHPHomeInfo *)getHomeDataWithMethod



//获取rankmore的相关数据
//- (void)getRankMoreWithMethod:(NSString *)method andLimit:(NSString *)limit andOffset:(NSString *)offset andTagid:(NSString *)tagid andType:(NSString *)type andHomeBlock:(HomeBlock)homeBlock;
//首页rankmore下的三个，后面会复用，统统id来传值
- (void)getRankDetailWithId:(NSString *)idStr andHomeBlock:(HomeBlock)homeBlock;
//keyword

- (void)getBtnDetailWithKeyWord:(NSString *)keyword andHomeBlock:(HomeBlock)homeBlock;

//rid=66576&sign=&uid=&uuid=17EF523E05B42597F70A95681590F28B

//- (void)getFoodMenuWithRid:(NSString *)rid andHomeBlock:(HomeBlock)homeBlock;
//反馈

- (void)getFeedBackWithContent:(NSString *)content andHomeBlock:(HomeBlock)homeBlock;

//将字典里的信息用一个对象保存Ad
- (HPHomeInfo *)homeInfoWithAdDic:(NSDictionary *)dict;
- (HPHomeInfo *)homeInfoWithAlbumDic:(NSDictionary *)dict;
- (HPHomeInfo *)homeInfoWithRankDic:(NSDictionary *)dict;
- (HPHomeInfo *)homeInfoWithRecipeDic:(NSDictionary *)dict;
- (HPHomeInfo *)homeInfoWithTableDic:(NSDictionary *)dict;
- (HPHomeInfo *)homeInfoWithTagDic:(NSDictionary *)dict;
- (HPHomeInfo *)homeInfoWithWikiDic:(NSDictionary *)dict;
- (HPHomeInfo *)homeInfoWithInfoDic:(NSDictionary *)dict;
- (HPHomeInfo *)homeInfoWithListDic:(NSDictionary *)dict;
//searcherBar
- (HPHomeInfo *)homeInfoWithSearchRecipeDic:(NSDictionary *)dict;
- (HPHomeInfo *)homeInfoWithSearchAlbumDIc:(NSDictionary *)dict;
- (HPHomeInfo *)homeInfoWithListInfoDic:(NSDictionary *)dict;
//tag
- (HPHomeInfo *)homeInfoWithTagDIc:(NSDictionary *)dict;




@end
