//
//  TravelViewController.m
//  ON THE WAY
//
//  Created by 邱添旺 on 2016/10/27.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import "TravelViewController.h"
#import "TravelModel.h"
#import "TraveiCell.h"
#import "ContentModel.h"
#import "UserModel.h"
#import "ActivityModel.h"
#import "DetailViewController.h"
@interface TravelViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
    NSArray *_dataArray;         //数据数组
}
@end

@implementation TravelViewController

#pragma mark - 导航栏背景设置

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"mask_titlebar64@2x.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"游记";
}

-(void)viewWillDisappear:(BOOL)animated{
    //    导航栏变为透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
    //    让黑线消失的方法
    self.navigationController.navigationBar.shadowImage=[UIImage new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTableView];
    [self requestData];
    // Do any additional setup after loading the view.
}
#pragma mark - 处理数据
- (void)requestData{
    
    NSString *apiString = @"http://q.chanyouji.com/api/v1/user_activities.json";
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    NSDictionary *params = @{@"district_id":_district_id,
                             @"page":@"1",
                             @"filter":@"",
                             @"sort":@""};
    [manager GET:apiString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self loadData:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
- (void)loadData:(NSDictionary *)DataDic{
    NSArray *dataArr = [DataDic[@"data"] objectForKey:@"user_activities"];
    NSMutableArray *mArray = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in dataArr) {
        ActivityModel *actModel = [ActivityModel yy_modelWithDictionary:dic];
//        UserModel *userModel = [UserModel yy_modelWithDictionary:dic[@"user"]];
        TravelModel *model = [[TravelModel alloc]init];
        model.activity = actModel;
//        model.user = userModel;
        [mArray addObject:model];
        
    }
    _dataArray = [mArray copy];
    [_tableView reloadData];
}
#pragma mark - 创建视图
- (void)createTableView {
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}
#pragma mark - 表视图方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TraveiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TraveiCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"TraveiCell" owner:nil options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = _dataArray[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TravelModel *model = _dataArray[indexPath.row];
    NSString *topic = model.activity.topic;
    CGSize maxSize = CGSizeMake(kScreenWidth - 20, 9000);
    CGRect topicRect = [topic boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:nil];
    
    NSString *des = model.activity.des;
    CGRect desRect = [des boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    
    return 250 + kScrollViewHeight + topicRect.size.height + 23 + desRect.size.height + 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //kUserIDNotificationName
    DetailViewController *detailVC = [[DetailViewController alloc]init];
    TravelModel *model = _dataArray[indexPath.row];
    [[NSNotificationCenter defaultCenter]postNotificationName:kUserIDNotificationName object:nil userInfo:@{@"userID" : model.activity.user.userID}];
    [self.navigationController pushViewController:detailVC animated:YES];
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
