//
//  TicketViewController.m
//  ON THE WAY
//
//  Created by Apple on 16/10/20.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import "TicketViewController.h"
#import "TrainViewController.h"
#import "CommonTrainCell.h"
#import "HighTrainCell.h"
@interface TicketViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
    NSMutableDictionary *params;
    NSMutableArray *_dataArray;
    NSMutableArray *_modelArray;
}
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation TicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    [self requestData];
}
- (IBAction)buttonAction:(UIButton *)sender {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date = params[@"date"];
    NSDate *cureentDate = [formatter dateFromString:date];
    NSString *newDate;
    if (sender.tag == 101) {
        NSDate *tomorrowDate = [cureentDate dateByAddingTimeInterval:24*60*60];
        newDate = [formatter stringFromDate:tomorrowDate];
    }else if (sender.tag == 102){
        NSDate *yestodayDate = [cureentDate dateByAddingTimeInterval:-24*60*60];
        newDate = [formatter stringFromDate:yestodayDate];
    }
    [params setObject:newDate forKey:@"date"];
    _dateLabel.text = params[@"date"];
    [self requestData];
}
#pragma mark - 创建表视图
- (void)createView {
    _dateLabel.text = params[@"date"];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 104, kScreenWidth, kScreenHeight - 104) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _modelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *trainDic = _dataArray[indexPath.row];
    NSString *trainType = trainDic[@"trainType"];
    if ([trainType isEqualToString:@"高速动车"]||[trainType isEqualToString:@"动车组"]) {
        HighTrainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HighTrainCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"HighTrainCell" owner:nil options:nil]lastObject];
        }
        cell.model = _modelArray[indexPath.row];
        return cell;
    }
    CommonTrainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommonTrainCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CommonTrainCell" owner:nil options:nil]lastObject];
    }
    cell.model = _modelArray[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
#pragma mark - 请求数据
- (void)requestData {
    @synchronized(self) {
    _dataArray = nil;
    _modelArray = nil;
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    if (_modelArray == nil) {
        _modelArray = [NSMutableArray array];
    }
    NSString *urlString = @"http://apis.baidu.com/qunar/qunar_train_service/s2ssearch";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager.requestSerializer setValue:@"86713d64e814e3a2a9392d7f4e43c06e" forHTTPHeaderField:@"apikey"];
    [manager GET:urlString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
     
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _dataArray = [[(NSDictionary *)responseObject objectForKey:@"data"] objectForKey:@"trainList"];
        for (NSDictionary *dic in _dataArray) {
            if (dic[@"trainType"] == nil || [dic[@"trainType"] isEqualToString:@""]) {
                [_dataArray removeObject:dic];
                continue;
            }
            TicketModel *model = [[TicketModel alloc]init];
            model.trainNo = dic[@"trainNo"];
            model.from = dic[@"from"];
            model.to = dic[@"to"];
            model.startTime = dic[@"startTime"];
            model.endTime = dic[@"endTime"];
            model.duration = dic[@"duration"];
            model.seatInfos = dic[@"seatInfos"];
            [_modelArray addObject:model];
            }
        [_tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"查询失败%@",error);
    }];
    }
}
#pragma mark - 接收通知，处理数据
- (void)awakeFromNib {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getParamsRequestData:) name:@"params" object:nil];
}
- (void)getParamsRequestData:(NSNotification *)noti {
    params = [NSMutableDictionary dictionaryWithDictionary:noti.userInfo];

    self.title = [NSString stringWithFormat:@"%@ 一 %@",params[@"from"],params[@"to"]];
}
-(void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
