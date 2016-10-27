//
//  ListDestinationViewController.m
//  ON THE WAY
//
//  Created by Apple on 16/10/21.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import "ListDestinationViewController.h"
#import "HomeRegion.h"
#import "DestinationModel.h"
#import "ListTableViewCell.h"
#import "TopDestinationViewController.h"

@interface ListDestinationViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_table;
    NSArray *_data;
}

@end

@implementation ListDestinationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    NSLog(@"%@",_homeRegion.name);
    self.navigationItem.title = _homeRegion.name;
    
    [self createTableView];
}

#pragma mark - 导航栏透明半透明设置

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"mask_titlebar64@2x.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    //    导航栏变为透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
    //    让黑线消失的方法
    self.navigationController.navigationBar.shadowImage=[UIImage new];
}

#pragma mark - 请求数据
-(void)loadData{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:_urlString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功");
        NSDictionary *regionDic = (NSDictionary *)responseObject;
        _data = [regionDic[@"data"] copy];
        
        [_table reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"失败");
    }];
    
}

-(void)createTableView{
    
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    _table.delegate = self;
    _table.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:@"ListTableViewCell" bundle:[NSBundle mainBundle]];
    [_table registerNib:nib forCellReuseIdentifier:@"ListTableViewCell"];
    
    
    [self.view addSubview:_table];
}

#pragma mark - tableviewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%li",_data.count);
    return _data.count;
}

-(ListTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListTableViewCell"];
    
    //填充数据
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dic = _data[indexPath.row];
    DestinationModel *destination = [DestinationModel yy_modelWithJSON:dic];
    [cell.iconImageView sd_setImageWithURL:destination.photo_url];
    cell.nameLabel.text = destination.name;
    cell.name_enLabel.text = destination.name_en;
    
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = _data[indexPath.row];
    DestinationModel *destination = [DestinationModel yy_modelWithJSON:dic];
    
    TopDestinationViewController *destinationVC = [[TopDestinationViewController alloc]init];
    NSString *urlString = [NSString stringWithFormat:@"http://q.chanyouji.com/api/v3/destinations/%@.json",destination.destination_id];
    destinationVC.urlString = urlString;
    
    //使用响应者链查找导航控制器
    UIResponder *nextResponder =self.nextResponder;
    while (nextResponder) {
        //找到导航控制器 跳转界面跳出循环
        if ([nextResponder isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navi = (UINavigationController *)nextResponder;
            //跳转
            [navi pushViewController:destinationVC animated:YES];
            break;
        }
        nextResponder = nextResponder.nextResponder;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 68;
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
