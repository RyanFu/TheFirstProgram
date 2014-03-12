//
//  QYHttpRequestManager.h
//  QYMovieScanner
//
//  Created by 范林松 on 14-3-11.
//  Copyright (c) 2014年 freeDev. All rights reserved.
//

#import <Foundation/Foundation.h>
/***********视频*****************
  该类中目前只提供相关的
 1.视频搜索
 2.视频信息
 3.排行榜
 4.视频状态
 5.视频评论
 6.视频上传和评论<暂未开放>
 
 **************用户***************
 若后期优化时，可涉及到是网站登陆以及单个用户信息
 1.用户信息
 2.用户视频
 3.用户豆单
 4.用户视频列表
 5.用户频道搜藏列表
 6.用户频道订阅列表
 7.用户观众列表
 8.用户视频收藏操作
 9.频道订阅操作
 
 ****************工具*************
 1.URl转帖工具
 
 ##############################################
 
  频道字典说明
  索引值     频道名称
  1         娱乐
  3         乐活
  5         搞笑
  9         动画
  10        游戏
  14        音乐
  15        体育
  21        科技
 ————————————————————————————————
  22        电影
 ————————————————————————————————
  24        财富
  25        教育
  26        汽车
  27        女性
  28        纪录片
  29        热点
 ————————————————————————————————
  30        电视剧
 ————————————————————————————————
  31        综艺
  32        风尚
  99        原创
 
  **************************************/



//处理网络地址http的get请求
@interface QYHttpRequestManager : NSObject

//使用开源库处理网络请求
+(id)parserDataByRequest:(NSString *)requestLink;

#pragma mark--------读取接口部分-------------
//处理视频搜索链接接口 kTUDO_VIDEO_SEARCH_URL(__kKeyWord__) 
+(id)getVideoSearchList:(NSString *)keyWord;
//获取视频信息接口 kTUDO_VIDEO_INFO_URL(__kItemCodes__)
+(id)getVideoInfoList:(NSString *)itemCodes;
//获取排行榜接口 kTUDO_VIDEO_TOPLIST_URL(__kChannelId__)
+(id)getVideoRankTopList:(NSInteger)channelID;
//获取视频状态接口 kTUDO_VIDEO_STATUS_URL(__kItemCodes__)
+(id)getVideoStatusList:(NSString *)itemCodes;
//获取视频评论接口 kTUDO_VIDEO_COMMENTLIST_URL(__kItemCodes__)
+(id)getVideoCommentList:(NSString *)itemCodes;

/*
#pragma mark------------读取豆单------------------
//获取豆单搜索接口
+(id)findPlayListSearchInterface;
//获取豆单信息接口
+(id)findPlayListInfoInterface;
//获取豆单频道信息接口
+(id)findPlayListVideoInfoInterface;
//获取豆单排行
+(id)findPlayListRankTopInterface;


#pragma mark---------------写入接口--------------
//视频添加接口
+(id)inputVideoCommentAdd;
//视频挖掘
+(id)inputVideoDigBuryInfo;
//视频上传
+(id)inputVideoUploadInfo;

#pragma mark------------------OAuth2认证------------------
//获取请求授权
+(id)getOauthRight;
//获取用户授权过的access_token
+(id)getOauthAccessToken;
//获取access_token信息
+(id)getOauthGetTokenInfo;
//销毁授权
+(id)getOauthRemoveAccessToken;

*/




















@end
