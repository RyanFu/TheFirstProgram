//
//  QYHttpRequestManager.m
//  QYMovieScanner
//
//  Created by 范林松 on 14-3-11.
//  Copyright (c) 2014年 freeDev. All rights reserved.
//

#import "QYHttpRequestManager.h"
#import "ASIHTTPRequest.h"


@implementation QYHttpRequestManager

+(id)parserDataByRequest:(NSString *)requestLink{

    //实例化ASI
    ASIHTTPRequest* requestString = [[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:requestLink]] autorelease];
    [requestString startSynchronous];//开启同步
    NSString* string = [requestString responseString];
    return string;
    
}
//视频搜索
+(id)getVideoSearchList{

//    NSString *link = @"http://api.tudou.com/v6/video/search?app_key=33b2e6eb944a6449&format=json&kw=电影&pageNo=1&pageSize=5&orderBy=createTime";
    
    NSString *link = kTUDO_VIDEO_SEARCH_URL;
    NSString *encodinglink = [link stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return [self parserDataByRequest:encodinglink];
    
}
//视频信息
+(id)getVideoInfoList{

    NSString *link = kTUDO_VIDEO_INFO_URL;
    NSString *encodinglink = [link stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return [self parserDataByRequest:encodinglink];

}
//视屏排行榜
+(id)getVideoRankTopList{

    NSString *link = kTUDO_VIDEO_TOPLIST_URL;
    NSString *encodinglink = [link stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return [self parserDataByRequest:encodinglink];

}
//视频评论
+(id)getVideoCommentList{

    NSString *link = kTUDO_VIDEO_COMMENTLIST_URL;
    NSString *encodinglink = [link stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return [self parserDataByRequest:encodinglink];

}
//视屏状态列表
+(id)getVideoStatusList{

    NSString *link = kTUDO_VIDEO_STATUS_URL;
    NSString *encodinglink = [link stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return [self parserDataByRequest:encodinglink];
}
@end
