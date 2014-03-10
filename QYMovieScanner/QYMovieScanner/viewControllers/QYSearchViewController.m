//
//  QYSearchViewController.m
//  QYMovieScanner
//
//  Created by 范林松 on 14-3-10.
//  Copyright (c) 2014年 freeDev. All rights reserved.
//

#import "QYSearchViewController.h"

@interface QYSearchViewController ()

@end

@implementation QYSearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"搜索";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
