//
//  TravelsViewController.m
//  ON THE WAY
//
//  Created by Apple on 16/10/12.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import "TravelsViewController.h"
#import "TravelModel.h"
#import "TraveiCell.h"
#import "ContentModel.h"
#import "UserModel.h"
#import "DetailViewController.h"
@interface TravelsViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
    NSArray *_dataArray;         //数据数组
}

@end

@implementation TravelsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    [self requestData];
    // Do any additional setup after loading the view.
}
#pragma mark - 处理数据
- (void)requestData {
    NSString *apiString = @"http://q.chanyouji.com/api/v1/timelines.json";
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    NSDictionary *params = @{@"interests":@"",
                             @"page":@"1",
                             @"per":@"50"};
    [manager GET:apiString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self loadData:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
- (void)loadData:(NSDictionary *)DataDic{
    NSArray *dataArr = DataDic[@"data"];
    NSMutableArray *mArray = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in dataArr) {
        TravelModel *model = [TravelModel yy_modelWithDictionary:dic];
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TravelModel *model = _dataArray[indexPath.row];
    DetailViewController *detail = [[DetailViewController alloc]init];
    detail.hidesBottomBarWhenPushed = YES;
    NSDictionary *dic = @{@"userID":model.activity.user.userID};
    [[NSNotificationCenter defaultCenter]postNotificationName:kUserIDNotificationName object:nil userInfo:dic];
    [self.navigationController pushViewController:detail animated:YES];
    
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
