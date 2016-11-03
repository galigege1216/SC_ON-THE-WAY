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
#import "DestinationCell.h"

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
    
    NSDictionary *dic = self.sections[indexPath.section];
    NSString *type = dic[@"type"];
    
    if ([type isEqualToString:@"Destination"]) {
        //目的地组
        NSArray *modelArr = dic[@"models"];
        NSMutableArray *mArr = [[NSMutableArray alloc]init];
        
        for (NSDictionary *dic in modelArr) {
            DestinationModel *model = [DestinationModel yy_modelWithJSON:dic];
            [mArr addObject:model];
        }
        NSArray *models = [mArr copy];
        
        DestinationCell *cell = [[DestinationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DestinationCell"];
        cell.models = models;
        return cell;
    }

    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DestinationCell"];
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
    
}
//单元格高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 150;
    }
    return 80;
}

//尾视图按钮点击事件
-(void)footButtonAction:(UIButton *)btn{
    NSLog(@"列表1");
    TravelViewController *traveVC = [[TravelViewController alloc]init];
    traveVC.district_id = @"100007";
    
    [self.navigationController pushViewController:traveVC animated:YES];
    
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
