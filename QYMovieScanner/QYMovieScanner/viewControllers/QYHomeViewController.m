//
//  QYHomeViewController.m
//  QYMovieScanner
//
//  Created by 范林松 on 14-3-10.
//  Copyright (c) 2014年 freeDev. All rights reserved.
//

#import "QYHomeViewController.h"

@interface QYHomeViewController ()

@end

@implementation QYHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"首页";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor cyanColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
