//
//  QYHomeViewController.m
//  QYMovieScanner
//
//  Created by 范林松 on 14-3-10.
//  Copyright (c) 2014年 freeDev. All rights reserved.
//

#import "QYHomeViewController.h"
#import "QYHttpRequestManager.h"
#import "JSON.h"
#import "QYVideoModule.h"

@interface QYHomeViewController ()

//测试表视图
@property (nonatomic ,retain) UITableView * homeTableView;
//用来接受下载解析完的数据
@property (nonatomic ,retain) NSMutableDictionary * tableViewDictionary;
//表视图的section对应的频道
@property (nonatomic ,retain) NSDictionary * sectionDictionary;
//网络请求用到的频道值
@property (nonatomic ,retain) NSString * channelString;
//QYMovieRequest类，多次使用，设为属性，方便调用
//@property (nonatomic ,retain) QYMovieRequest * movieRequst;
//tabHeaderView的网络数据组成的数组
@property (nonatomic ,retain) NSMutableArray * scrollViewArray;


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
        _sectionToChannelDictionary = [NSMutableDictionary dictionary];
        [_sectionToChannelDictionary setObject:[NSNumber numberWithInt:CHANNEL_EDUCATOINS] forKey:@"0"];
        [_sectionToChannelDictionary setObject:[NSNumber numberWithInt:CHANNEL_ENTERTANMENTS] forKey:@"1"];
        [_sectionToChannelDictionary setObject:[NSNumber numberWithInt:CHANNEL_MOVIES] forKey:@"2"];
        [_sectionToChannelDictionary setObject:[NSNumber numberWithInt:CHANNEL_HOTNEWS] forKey:@"3"];
        
        _tableSectionElementsDictionary = [NSMutableDictionary dictionary];
        
        /***************初始化轮播图片数组***************/
        _imageURLS = [NSMutableArray arrayWithObjects:@"http://old.dongway.com.cn/picture/indexdatapic/2013-12/02/220d0bf6-bbf7-4a7e-b27b-80e3fdcaae8b.png",@"1.jpg",@"2.jpg",@"3.jpg",nil];
    }
    return self;
}
#pragma mark-------------- 表示图头部图片轮播数据初始化工作 --------------------
- (void)setupViews:(NSMutableArray *)imagesURLS titlesChanels:(NSMutableArray *)titlesChanels{//传入图片地址
    
    EScrollerView *scroller;
    //设置轮播图片
    scroller=[[EScrollerView alloc] initWithFrameRect:CGRectMake(0, 20, 320, 150)
                                           ImageArray:imagesURLS
                                           TitleArray:titlesChanels];
    scroller.delegate=self;
    self.tableView.tableHeaderView = scroller;//添加到表示图HeaderTableView上
    [scroller release];
    
}
-(void)EScrollerViewDidClicked:(NSUInteger)index
{
    NSLog(@"index--%d",index);
}


#pragma mark-------------- 初始化字典数据 根据频道获取 --------------------
-(void)_loadVideoArrayData:(NSArray *)channelIDArray{
    
    SBJsonParser* parser = [[SBJsonParser alloc] init];//JSON解析
    //依次对6个频道进行网络请求数据，全部请求完成再刷新tableView的数据
    //根据频道获取值
    for (int i=0; i<channelIDArray.count; i++) {
        //获取频道id
        NSInteger channdelID = [channelIDArray[i] integerValue];
        //根据频道id获取对字典
        NSDictionary *channalDic = [parser objectWithString:[QYHttpRequestManager getVideoRankTopList:channdelID]];
//        NSLog(@"%@",channalDic);
        NSArray *movieInfoArray = [channalDic objectForKey:@"results"];
//        NSLog(@"%@",movieInfoArray);
        if (movieInfoArray == nil) {
            [parser objectWithString:[QYHttpRequestManager getVideoRankTopList:channdelID]];
        }
        NSMutableArray *showMovies = [NSMutableArray arrayWithCapacity:movieInfoArray.count];
        for (int j= 0; j <movieInfoArray.count; j++) {
            NSDictionary *oneDic = movieInfoArray[j];//频道数组
            QYVideoModule *movie = [[QYVideoModule alloc] initWithVideoInfos:oneDic];
            NSLog(@"%@----%d",movie,j);
            [showMovies addObject:movie];
//            NSLog(@"%@",showMovies);
            RELEASE_SAFETY(movie);
        }
        //将不同频道数组以键值方式存入
        [_tableSectionElementsDictionary setObject:showMovies forKey:channelIDArray[i]];
    }
//    NSLog(@"%@",_tableSectionElementsDictionary);
    
    
    RELEASE_SAFETY(parser);
}
#pragma mark-------------- 初始化标示图 --------------------
-(void)_initTableView{

    //表视图
    self.tableView = [[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped] autorelease];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
#pragma mark---表示图显示之前 属性初始化部分----
    //初始化数组
//    _tableVideosListArrayByChannel  = [[NSMutableArray array] autorelease];
    
#pragma mark----程序按顺序执行部分-----
    //调用加载视频方法
    NSArray *arraysNumber =  @[[NSNumber numberWithInt:CHANNEL_EDUCATOINS],
                               [NSNumber numberWithInt:CHANNEL_ENTERTANMENTS],
                               [NSNumber numberWithInt:CHANNEL_MOVIES],
                               [NSNumber numberWithInt:CHANNEL_HOTNEWS]];
    
    //根据频道获取数据
    [self _loadVideoArrayData:arraysNumber];
    //初始化tableView
    [self _initTableView];
    //表示图初始化后待用该方法{此处放置网络图片轮播}
     [self setupViews:_imageURLS titlesChanels:nil];
    [_tableSectionElementsDictionary objectForKey:[NSNumber numberWithInt:CHANNEL_EDUCATOINS]];
    

}

#pragma mark--TableViewController  Delegate--
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{


    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIndetifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndetifier] autorelease];
    }
    NSString * sectionString = [NSString stringWithFormat:@"%d",indexPath.section];
    NSNumber * numChannel = [self.sectionToChannelDictionary objectForKey:sectionString];
//    NSLog(@"%@",self.sectionToChannelDictionary);
    NSMutableArray * array = [self.tableSectionElementsDictionary objectForKey:numChannel];
    cell.textLabel.text = ((QYVideoModule *)[array objectAtIndex:indexPath.row]).title;


    
    
    return cell;

}
//sectionTitle
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    switch (section) {
        case 0:
            return KEYWORD_CHANNEL_EDUCATOINS;
            break;
        case 1:
            return KEYWORD_CHANNEL_ENTERTANMENTS;
            break;
        case 2:
            return KEYWORD_CHANNEL_MOVIES;
            break;
        case 3:
            return KEYWORD_CHANNEL_HOTNEWS;
            break;
    }
    return KEYWORD_CHANNEL_WRONGFLAG;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)dealloc{
    
    RELEASE_SAFETY(_tableView);
    RELEASE_SAFETY(_sectionToChannelDictionary);
    RELEASE_SAFETY(_tableVideosListArrayByChannel);
    RELEASE_SAFETY(_tableSectionElementsDictionary);
    [super dealloc];

}

@end
