//
//  HomeViewController.m
//  ON THE WAY
//
//  Created by Apple on 16/10/20.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeRegion.h"
#import "DestinationView.h"
#import "DestinationModel.h"
#import "ListDestinationViewController.h"
#import "BaseDestinationViewController.h"

#define kHomeFootViewHeight 40
#define kHomeHeadViewHeight 30
#define kHomeScrollViewHeight 120
//间隙
#define kHomeCellSpace 8
//destinationView高度
#define kHomeCellItemHeight 120
#define kHomeCellItenWidth (kScreenWidth - 4*kHomeCellSpace)/3

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_table;
    NSArray *_data;
    NSArray *_homeRegionArr;
    NSArray *_advertData;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:223 green:223 blue:223 alpha:1];
    [self loadData];
    
    [self createTbale];
    
    
    
    
}

#pragma mark - 请求数据
-(void)loadData{
    
    NSString *urlString = @"http://q.chanyouji.com/api/v2/destinations.json";
//    NSString *adverts = @"http://q.chanyouji.com/api/v1/adverts.json?";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager GET:adverts parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *advertDic = (NSDictionary *)responseObject;
//        _advertData = advertDic[@"data"];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//    }];
    [manager GET:urlString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功");
        NSDictionary *regionDic = (NSDictionary *)responseObject;
        _data = [regionDic[@"data"] copy];
        
        NSMutableArray *mArr = [NSMutableArray array];
        for (NSDictionary *dic in _data) {
            HomeRegion *homeRegion = [HomeRegion yy_modelWithJSON:dic];
            [mArr addObject:homeRegion];
            
            NSLog(@"region:%@",homeRegion.name);
        }
        _homeRegionArr = [mArr copy];
        
        [_table reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"失败");
    }];
}

#pragma mark - 表视图

-(void)createTbale{
    
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    _table.delegate = self;
    _table.backgroundColor = [UIColor colorWithRed:196/255.0 green:206/255.0 blue:206/255.0 alpha:1];
    _table.dataSource = self;
//    _table.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:_table];
}

#pragma mark - tableViewDeleget
//每组单元格个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==1) {
        return 1;
    }
    return 2;
}
//组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return _data.count;
    return _data.count;
}
//自定义单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];

    //填充数据
    HomeRegion *region = _homeRegionArr[indexPath.section];
    
//    NSLog(@"row: %li",indexPath.row);
    for (int i = 0; i < 3; i++) {
        NSDictionary *dic = region.destinations[indexPath.row *3+i];
        DestinationModel *destination = [DestinationModel yy_modelWithJSON:dic];
        
//        NSLog(@"----%li",indexPath.row*3+i);
        DestinationView *view = [[DestinationView alloc]initWithFrame:CGRectMake(i*(kHomeCellItenWidth +kHomeCellSpace)+kHomeCellSpace, kHomeCellSpace, kHomeCellItenWidth, kHomeCellItemHeight)];
        view.destinationModel = destination;
//        NSLog(@"-----------%@",destination.name);
        [cell.contentView addSubview:view];
    }
    
    return cell;
}


//单元格高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kHomeCellItemHeight+kHomeCellSpace *2;
}

#pragma mark - 头视图
//头视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHomeHeadViewHeight)];
//    imageView.backgroundColor = [UIColor clearColor];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, 20)];
    titleLabel.backgroundColor = [UIColor whiteColor];
    HomeRegion *region = _homeRegionArr[section];
    titleLabel.text =region.name;
    [imageView addSubview:titleLabel];
    
    return imageView;
}
//头视图高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kHomeHeadViewHeight;
}

#pragma mark - 尾视图
//尾视图（按钮）
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    HomeRegion *region = _homeRegionArr[section];
    if (region.button_text) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, kScreenWidth, kHomeFootViewHeight);
//        button.backgroundColor = [UIColor redColor];
        button.tag = 100+section;
//        UIColor *color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"AttractionButton_Pressed@2x"]];
        //尾视图按钮颜色
        UIColor *color = [UIColor lightGrayColor];
        [button setBackgroundColor:color];
        [button addTarget:self action:@selector(footButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:region.button_text forState:UIControlStateNormal];
        [button setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
        return button;
    }
    return nil;
}
//高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    HomeRegion *region = _homeRegionArr[section];
    if (region.button_text) {
        return kHomeFootViewHeight;
    }
    return 0;
}
//尾视图按钮点击事件
-(void)footButtonAction:(UIButton *)btn{
    NSLog(@"列表");
    //五大类
    HomeRegion *region = _homeRegionArr[btn.tag - 100];
    ListDestinationViewController *listVC = [[ListDestinationViewController alloc]init];
    listVC.homeRegion = region;
    //请求url
    //http://q.chanyouji.com/api/v2/destinations/list.json?area=asia
    NSString *urlString = [NSString stringWithFormat:@"http://q.chanyouji.com/api/v2/destinations/list.json?area=%@",region.region];
    listVC.urlString = urlString;
    listVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:listVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
