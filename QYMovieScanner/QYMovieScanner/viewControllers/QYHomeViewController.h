//
//  QYHomeViewController.h
//  QYMovieScanner
//
//  Created by 范林松 on 14-3-10.
//  Copyright (c) 2014年 freeDev. All rights reserved.
//

#import "QYBaseViewController.h"
#import "EScrollerView.h"

//首页
@interface QYHomeViewController : QYBaseViewController<UITableViewDataSource,UITableViewDelegate,EScrollerViewDelegate>{

    NSArray *_imageNames;
    NSMutableArray *_imageURLS;

}

@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)NSMutableDictionary *tableSectionElementsDictionary;
@property(nonatomic,retain)NSMutableArray *tableVideosListArrayByChannel;
@property(nonatomic,retain)NSMutableDictionary *sectionToChannelDictionary;



@end
