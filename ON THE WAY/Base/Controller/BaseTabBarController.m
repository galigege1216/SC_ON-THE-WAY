//
//  BaseTabBarController.m
//  ON THE WAY
//
//  Created by Apple on 16/10/12.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import "BaseTabBarController.h"
@interface BaseTabBarController ()

@end

@implementation BaseTabBarController
- (instancetype)init {
    if (self = [super init]) {
        [self createSubViews];
        [self customTabBarButton];
    }
    return self;
}
//添加子视图

- (void)createSubViews {
    NSArray *sbNames = @[@"Home",@"Travels",@"Tool",@"Profile"];
    NSMutableArray *mArray = [NSMutableArray array];
    for (NSString *sbName in sbNames) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:sbName bundle:[NSBundle mainBundle]];
        UIViewController *subView = [storyBoard instantiateInitialViewController];
        [mArray addObject:subView];
    }
    self.viewControllers = mArray;
}
- (void)customTabBarButton {
        NSArray *imageNames = @[@"2.png",@"1.png",@"3.png",@"4.png"];
        NSArray *titleNames = @[@"首页",@"游记",@"工具箱",@"我"];
    for (int i = 0; i<4; i++) {
        UITabBarItem *item = self.tabBar.items[i];
        item.title = titleNames[i];
        item.image = [UIImage imageNamed:imageNames[i]];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
