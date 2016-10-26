//
//  WikiDestinationViewController.m
//  ON THE WAY
//
//  Created by Apple on 16/10/25.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import "WikiDestinationViewController.h"
#import "WikiCategoryModel.h"
#import "WikiCell.h"
#import "WikiCellLayout.h"

@interface WikiDestinationViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_table;
    NSArray *_data;
    NSArray *_titleArr;
    NSArray *_title_enArr;
    
    
}

@end

@implementation WikiDestinationViewController

-(void)viewDidLoad{
    
    
    //15个类别
    _titleArr = @[@"概览",@"出行须知",@"如何到达",@"当地交通",@"景点",@"娱乐",@"住宿",@"美食",@"购物",@"离境须知",@"其它10",@"其它11",@"其它12",@"其它13",@"其它14"];
    _title_enArr = @[@"Overview",@"Notes",@"Arrive",@"Traffic",@"Spots",@"Activity",@"Hotel",@"Food",@"Shopping",@"Depature",@"10",@"Other",@"12",@"13",@"14"];
    [self loadData];
    [self createTable];
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
        NSArray *array = (NSArray *)responseObject;
        NSMutableArray *mArr = [[NSMutableArray alloc]init];
        for (NSDictionary *dic in array) {
            WikiCategoryModel *model = [[WikiCategoryModel alloc]init];
            model.category_type = dic[@"category_type"];
            model.pages = dic[@"pages"];
            [mArr addObject:model];
            
        }
        _data = [mArr copy];
        
        [_table reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"失败");
    }];
    
    
}
#pragma mark - tableView

-(void)createTable{
    
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    _table.delegate = self;
    _table.dataSource = self;
//    _table.backgroundColor = [UIColor greenColor];
    
    UINib *nib = [UINib nibWithNibName:@"WikiCell" bundle:[NSBundle mainBundle]];
    [_table registerNib:nib forCellReuseIdentifier:@"WikiCell"];
    
    [self.view addSubview:_table];
    
}

#pragma mark - tableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}

-(WikiCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WikiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WikiCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleArr = _titleArr;
    cell.titlt_enArr = _title_enArr;
    cell.wikiModel = _data[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    WikiCategoryModel *wikiModel = _data[indexPath.row];
    WikiCellLayout *layout = [WikiCellLayout layoutWithWikiModel:wikiModel];
    
    return [layout cellHeight];
}

@end
