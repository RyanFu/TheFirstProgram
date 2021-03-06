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
    ASIHTTPRequest* requestString = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:requestLink]];
    [requestString startSynchronous];//开启异步
    NSString* string = [requestString responseString];
    RELEASE_SAFETY(requestString);
    return string;
    
}
//视频搜索
+(id)getVideoSearchList:(NSString *)keyWord{

    NSString *link = kTUDO_VIDEO_SEARCH_URL(keyWord);
    NSString *encodinglink = [link stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return [self parserDataByRequest:encodinglink];
    
}
//视频信息
+(id)getVideoInfoList:(NSString *)itemCodes{

    NSString *link = kTUDO_VIDEO_INFO_URL(itemCodes);
    NSString *encodinglink = [link stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return [self parserDataByRequest:encodinglink];

}
//视屏排行榜
+(id)getVideoRankTopList:(NSInteger)channelID{

    NSString *link = kTUDO_VIDEO_TOPLIST_URL(channelID);
    NSString *encodinglink = [link stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return [self parserDataByRequest:encodinglink];

}
//视频评论
+(id)getVideoCommentList:(NSString *)itemCodes{

    NSString *link = kTUDO_VIDEO_COMMENTLIST_URL(itemCodes);
    NSString *encodinglink = [link stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return [self parserDataByRequest:encodinglink];

}
//视屏状态列表
+(id)getVideoStatusList:(NSString *)itemCodes{

    NSString *link = kTUDO_VIDEO_STATUS_URL(itemCodes);
    NSString *encodinglink = [link stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return [self parserDataByRequest:encodinglink];
}





@end
