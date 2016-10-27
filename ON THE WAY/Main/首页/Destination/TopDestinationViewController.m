//
//  TopDestinationViewController.m
//  ON THE WAY
//
//  Created by Apple on 16/10/21.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import "TopDestinationViewController.h"
#import "TopBGView.h"
#import "TravelViewController.h"

#define kTopBGViewHeight 240
#define kBgImageViewHeight 200
#define kLabelHeight 20
#define kBottomLabelHeight 40

#define kHomeFootViewHeight 40
#define kHomeHeadViewHeight 30


@interface TopDestinationViewController ()<UITableViewDataSource,UITableViewDelegate>
//{
//    TopBGView *_topBGView;
//    UITableView *_table;
//    NSDictionary *_data;
//    NSArray *_sections;
//    NSDictionary *_destinationDic;
//    UIImageView *_naviBGimageView;
//}




@end

@implementation TopDestinationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor clearColor];
    
    //    导航栏变为透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
    //    让黑线消失的方法
    self.navigationController.navigationBar.shadowImage=[UIImage new];
//    [self loadData];
//    [self createTable];
    self.table.backgroundColor = [UIColor colorWithRed:196/255.0 green:206/255.0 blue:206/255.0 alpha:1];
    
    self.table.delegate = self;
    self.table.dataSource = self;
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.translucent = YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DestinationCell"];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
    
}

//尾视图按钮点击事件
-(void)footButtonAction:(UIButton *)btn{
    NSLog(@"列表1");
    TravelViewController *traveVC = [[TravelViewController alloc]init];
    traveVC.district_id = @"100007";
    
    
    [self.navigationController pushViewController:traveVC animated:YES];
    
}

//#pragma mark - 请求数据
//-(void)loadData{
//    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager GET:_urlString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"请求成功");
//        NSDictionary *regionDic = (NSDictionary *)responseObject;
//        _data = [regionDic[@"data"] copy];
//        _sections = _data[@"sections"];
//        _destination = [DestinationModel yy_modelWithJSON:_data[@"destination"]];
//        _topBGView.destinationModel = _destination;
//        [_naviBGimageView sd_setImageWithURL:_destination.photo_url];
//        [_table reloadData];
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        NSLog(@"失败");
//    }];
//    
//    
//}

//-(void)createTable{
//    _topBGView = [[TopBGView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kTopBGViewHeight)];
//    
//    [self.view addSubview:_topBGView];
//    
//    _naviBGimageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64-kBgImageViewHeight, kScreenWidth, kBgImageViewHeight)];
//    _naviBGimageView.hidden = YES;
//    
//    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
//    _table.delegate = self;
//    _table.dataSource = self;
//    //头视图
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kTopBGViewHeight)];
//    _table.tableHeaderView = view;
////    view.backgroundColor = [UIColor purpleColor];
////    _table.backgroundColor = [UIColor blueColor];
//    
//    [self.view addSubview:_table];
//    [self.view insertSubview:_table belowSubview:_topBGView];
//    [self.view insertSubview:_naviBGimageView aboveSubview:_topBGView];
//    [_table reloadData];
//    //设置内容偏移量
//    _table.contentInset = UIEdgeInsetsMake(-64, 0, 64, 0);
//    
//}
//
//#pragma mark - scrollViewDelegate
//
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
//    CGFloat offSetY = scrollView.contentOffset.y;
//
//    
//    if (offSetY > 0 &&offSetY < kTopBGViewHeight - 40 - 64) {
//        _topBGView.frame = CGRectMake(0, -offSetY, kScreenWidth, kTopBGViewHeight);
//        _naviBGimageView.hidden = YES;
//    }else if (offSetY >= kTopBGViewHeight - 40 - 64){
//        _topBGView.frame = CGRectMake(0, -offSetY, kScreenWidth, kTopBGViewHeight);
//        _naviBGimageView.hidden = NO;
//    }else{
//        _topBGView.frame = CGRectMake(0, 0, kScreenWidth, kTopBGViewHeight);
//        _naviBGimageView.hidden = YES;
//    }
//    NSLog(@"%lf",offSetY);
//}
//
//#pragma mark - tableViewDelegate
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    
//    
//    return _sections.count;
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    
//    return 2;
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DestinationCell"];
//    cell.backgroundColor = [UIColor grayColor];
//    return cell;
//    
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    return 60;
//}
//#pragma mark - 头视图
////头视图
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHomeHeadViewHeight)];
//    
//    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, 20)];
//    NSString *title = _sections[section][@"title"];
//    titleLabel.text = title;
//    imageView.backgroundColor = [UIColor redColor];
//    [imageView addSubview:titleLabel];
//    
//    return imageView;
//}
////头视图高度
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return kHomeHeadViewHeight;
//}
//
//#pragma mark - 尾视图
////尾视图（按钮）
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    NSString *button_text = _sections[section][@"button_text"];
//    if (![button_text isKindOfClass:[NSNull class]]) {
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.frame = CGRectMake(0, 0, kScreenWidth, kHomeFootViewHeight);
//        //        button.backgroundColor = [UIColor redColor];
//
//        [button addTarget:self action:@selector(footButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//        [button setTitle:button_text forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        return button;
//    }
//    return nil;
//}
////高度
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    NSString *button_text = _sections[section][@"button_text"];
//    if (![button_text isKindOfClass:[NSNull class]]) {
//        return kHomeFootViewHeight;
//    }
//    return 0;
//}
//
////尾视图按钮点击事件
//-(void)footButtonAction:(UIButton *)btn{
//    NSLog(@"列表");
//    
//    
//}

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
