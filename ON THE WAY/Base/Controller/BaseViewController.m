//
//  BaseViewController.m
//  ON THE WAY
//
//  Created by Apple on 16/10/12.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.navigationController.viewControllers.count >= 2) {
        [self createBackButton];
    }
    // Do any additional setup after loading the view.
}

#pragma mark - 导航栏背景设置

//-(void)viewWillAppear:(BOOL)animated{
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"mask_titlebar64@2x.png"] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.translucent = NO;
//}
//
//-(void)viewWillDisappear:(BOOL)animated{
//    //    导航栏变为透明
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
//    //    让黑线消失的方法
//    self.navigationController.navigationBar.shadowImage=[UIImage new];
//}
//自定义返回按钮
- (void)createBackButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"cm2_topbar_icn_back.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 28, 28);
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
//    [button setTitle:@"返回" forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = item;
}
- (void)buttonAction {
    [self.navigationController popViewControllerAnimated:YES];
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
