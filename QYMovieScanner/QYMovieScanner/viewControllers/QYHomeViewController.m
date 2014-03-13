//
//  QYHomeViewController.m
//  QYMovieScanner
//
//  Created by 范林松 on 14-3-10.
//  Copyright (c) 2014年 freeDev. All rights reserved.
//

#import "QYHomeViewController.h"
#import "QYHttpRequestManager.h"
#import "QYVodeoDetailViewController.h"
#import "JSON.h"
#import "UIUtils.h"
#import "QYVideoModule.h"

@interface QYHomeViewController ()

-(void)_initTableView;
-(void)_loadVideoArrayData:(NSArray *)channelIDArray;

@end

@implementation QYHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"推荐首页";
        /**********************初始化sectionDictionary***********************/
        self.tableSectionElementsArray = [NSMutableArray array];
        
        /***************初始化轮播图片数组***************/
        self.imageURLArray = [NSMutableArray array];
    }
    return self;
}
#pragma mark-------------- 初始化字典数据 根据频道获取 --------------------
-(void)_loadVideoArrayData:(NSArray *)channelIDArray{
    
    SBJsonParser* parser = [[SBJsonParser alloc] init];//JSON解析
   
    NSDictionary *movieDic = [parser objectWithString:[QYHttpRequestManager getVideoRankTopList:CHANNEL_MOVIES]];
//    NSLog(@"%@",movieDic);
    NSArray *movie = [movieDic objectForKey:@"results"];//获取结果数组
//    NSLog(@"%@",movie);
    for (int i=0; i<movie.count-1; i++) {
        NSDictionary *oneDic = movie[i];
        //放置轮播图片
        if (i<6) {
            QYVideoModule *imageMovie = [[QYVideoModule alloc] initWithVideoInfos:oneDic];
            [self.imageURLArray addObject:imageMovie];
            RELEASE_SAFETY(imageMovie);
        }
        
        QYVideoModule *addMoives = [[QYVideoModule alloc] initWithVideoInfos:oneDic];
        NSLog(@"%@",addMoives);
        //筛选出不同的视频对象
        if (![[[QYVideoModule alloc] initWithVideoInfos:movie[i]] isEqual:[[QYVideoModule alloc] initWithVideoInfos:movie[i+1]]]) {
            if (addMoives && addMoives.title != nil) {
                [self.tableSectionElementsArray addObject:addMoives];
                RELEASE_SAFETY(addMoives);
            }
        }
    }
    QYVideoModule *lastMovie = [[QYVideoModule alloc] initWithVideoInfos:[movie lastObject]];
    [self.tableSectionElementsArray addObject:lastMovie];
    RELEASE_SAFETY(lastMovie);
    
//    NSLog(@"%@",_tableSectionElementsArray);
    NSLog(@"%d",self.tableSectionElementsArray.count);
    
    RELEASE_SAFETY(parser);
}
#pragma mark-------------- 表示图头部图片轮播数据初始化工作 --------------------
- (void)setupViews:(NSMutableArray *)imagesURLS titlesChanels:(NSMutableArray *)titlesChanels{//传入图片地址
    
    //循环得出存入数组的视频对象获取对应图片地址
    NSMutableArray *imageUrl = [NSMutableArray arrayWithCapacity:imagesURLS.count];
    for (int i = 0; i<imagesURLS.count;i++) {
        QYVideoModule *url = imagesURLS[i];
        [imageUrl addObject:url.bigPicUrl];
    }
    
    EScrollerView *scroller;
    //设置轮播图片
    scroller=[[EScrollerView alloc] initWithFrameRect:CGRectMake(0, 20, 320, 160)
                                           ImageArray:imageUrl
                                           TitleArray:titlesChanels];
    scroller.delegate=self;
    self.tableView.tableHeaderView = scroller;//添加到表示图HeaderTableView上
    [scroller release];
    
}
-(void)EScrollerViewDidClicked:(NSUInteger)index{
    
    NSLog(@"index--%d",index);
    if (index<self.imageURLArray.count+1) {
        QYVideoModule *pic = [self.imageURLArray objectAtIndex:index-1];
        QYVodeoDetailViewController *detailVC = [[QYVodeoDetailViewController alloc] init];
        detailVC.picUrl = pic.playUrl;
        [self.navigationController pushViewController:detailVC animated:YES];
        RELEASE_SAFETY(detailVC);
    }else{
        //当index大于图片数组的长度+1-->此时为下一轮图片轮播开始
        QYVideoModule *pic = [self.imageURLArray objectAtIndex:0];
        QYVodeoDetailViewController *detailVC = [[QYVodeoDetailViewController alloc] init];
        detailVC.picUrl = pic.playUrl;
        [self.navigationController pushViewController:detailVC animated:YES];
        RELEASE_SAFETY(detailVC);
    }
    
    
}

#pragma mark-------------- 初始化标示图 --------------------
-(void)_initTableView{

    //表视图
    self.tableView = [[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain] autorelease];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
#pragma mark---表示图显示之前 属性初始化部分----

    
#pragma mark----程序按顺序执行部分-----

    //根据频道获取数据
    [self _loadVideoArrayData:nil];
    //初始化tableView
    [self _initTableView];
    //表示图初始化后待用该方法{此处放置网络图片轮播}
    NSLog(@"%d",self.imageURLArray.count);
     [self setupViews:self.imageURLArray titlesChanels:nil];
    
#pragma mark--下拉刷新--
    if (_refreshTableView == nil) {
        //初始化下拉控件
        EGORefreshTableHeaderView *refreshView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f,0.0f - self.tableView.bounds.size.height,self.view.frame.size.width,self.tableView.bounds.size.height)];
        refreshView.delegate = self;
        //        [refreshView setHidden:YES];
        //将下拉刷新控件作为子控件添加到UITableView中
        [self.tableView addSubview:refreshView];
        _refreshTableView = refreshView;
        
    }
    
    //重新加载表格数据
    [self.tableView reloadData];
    

}

#pragma mark--TableViewController  Delegate--
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return _tableSectionElementsArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIndetifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndetifier] autorelease];
    }
    QYVideoModule *movieModule = [_tableSectionElementsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = movieModule.title;
//    NSLog(@"%@",_tableSectionElementsArray);
    
    return cell;

}
//sectionTitle
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    return KEYWORD_CHANNEL_MOVIES;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    QYVideoModule *pic = [self.tableSectionElementsArray objectAtIndex:indexPath.row];
    QYVodeoDetailViewController *detailVC = [[QYVodeoDetailViewController alloc] init];
    detailVC.picUrl = pic.playUrl;
    [self.navigationController pushViewController:detailVC animated:YES];
    RELEASE_SAFETY(detailVC);
}
#pragma mark -------Data Source Loading / Reloading Methods-----------
//开始重新加载时调用的方法
- (void)reloadTableViewDataSource{
    _reloading = YES;
    //开始刷新后执行后台线程，在此之前可以开启HUD或其他对UI进行阻塞
    [NSThread detachNewThreadSelector:@selector(doInBackground) toTarget:self withObject:nil];
}

//完成加载时调用的方法
- (void)doneLoadingTableViewData{
    NSLog(@"doneLoadingTableViewData");
    
    _reloading = NO;
    [_refreshTableView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    //刷新表格内容
    [self.tableView reloadData];
}


#pragma mark Background operation
//这个方法运行于子线程中，完成获取刷新数据的操作
-(void)doInBackground
{
    NSLog(@"doInBackground");
    
    //    NSArray *dataArray2 = [NSArray arrayWithObjects:@"Ryan2",@"Vivi2", nil];
    //    self.array = dataArray2;
    [NSThread sleepForTimeInterval:3];
    
    //后台操作线程执行完后，到主线程更新UI
    [self performSelectorOnMainThread:@selector(doneLoadingTableViewData) withObject:nil waitUntilDone:YES];
}


#pragma mark EGORefreshTableHeaderDelegate Methods
//下拉被触发调用的委托方法
-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view
{
    [self reloadTableViewDataSource];
}

//返回当前是刷新还是无刷新状态
-(BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view
{
    return _reloading;
}

//返回刷新时间的回调方法
-(NSDate *)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view
{
    return [NSDate date];
}


#pragma mark UIScrollViewDelegate Methods
//滚动控件的委托方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshTableView egoRefreshScrollViewDidScroll:scrollView];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshTableView egoRefreshScrollViewDidEndDragging:scrollView];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)dealloc{

    RELEASE_SAFETY(_tableSectionElementsArray);
    RELEASE_SAFETY(_imageURLArray);
    [super dealloc];

}

@end
