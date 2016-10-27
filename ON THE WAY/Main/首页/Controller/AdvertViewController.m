//
//  AdvertViewController.m
//  ON THE WAY
//
//  Created by Apple on 16/10/27.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import "AdvertViewController.h"

@interface AdvertViewController ()

@end

@implementation AdvertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.title = @"氢专题";
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight -64)];
    [self.view addSubview:webView];
    //创建请求
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:self.urlString]];
    //加载网络数据
    [webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
