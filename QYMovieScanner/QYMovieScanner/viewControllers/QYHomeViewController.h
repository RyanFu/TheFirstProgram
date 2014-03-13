//
//  QYHomeViewController.h
//  QYMovieScanner
//
//  Created by 范林松 on 14-3-10.
//  Copyright (c) 2014年 freeDev. All rights reserved.
//

#import "QYBaseViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "EScrollerView.h"

//首页
@interface QYHomeViewController : QYBaseViewController<UITableViewDataSource,UITableViewDelegate,EScrollerViewDelegate,EGORefreshTableHeaderDelegate>{

    BOOL isflage;
    BOOL _reloading;
    EGORefreshTableHeaderView *_refreshTableView;
    
}

@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)NSMutableArray *tableSectionElementsArray;
@property(nonatomic,retain)NSMutableArray *imageURLArray;

-(void)downRefresh;//下拉刷新


//开始重新加载时调用的方法
-(void)reloadTableViewDataSource;

//完成加载时调用的方法
-(void)doneLoadingTableViewData;



@end
