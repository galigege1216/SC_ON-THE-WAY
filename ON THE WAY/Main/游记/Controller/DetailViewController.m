//
//  DetailViewController.m
//  ON THE WAY
//
//  Created by Apple on 16/10/25.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import "DetailViewController.h"
#import "ActivityModel.h"
#import "DetailCell.h"
#import "ImageCell.h"
#import "ContentModel.h"
#define kCollectionViewCellWidth (kScreenWidth/3)
@interface DetailViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>{
    UICollectionView *_collectionView;
    UITableView *_tableView;
    UITableView *_footTableView;
    NSArray *_dataArray;         //数据数组
    NSMutableArray *_imageArray;        //图片模型数组
}

@end

@implementation DetailViewController
- (instancetype)init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestData:) name:kUserIDNotificationName object:nil];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    [self setTopView];
    [self requestData];
}



#pragma mark - 创建视图
- (void)createView {
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc]init];
    layOut.itemSize = CGSizeMake(kCollectionViewCellWidth, kCollectionViewCellWidth);
    //单元格水平方向之间的间隙
    layOut.minimumInteritemSpacing = 0;
    //竖直
    layOut.minimumLineSpacing = 0;
    //滑动方向
    layOut.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 200 + 44, kScreenWidth, kScreenHeight - 244) collectionViewLayout:layOut];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    //注册单元格
    [_collectionView registerNib:[UINib nibWithNibName:@"ImageCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ImageCell"];
    
    _footTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 200 + 44, kScreenWidth, kScreenHeight - 244) style:UITableViewStyleGrouped];
    _footTableView.delegate = self;
    _footTableView.dataSource = self;
    
}
- (void)setTopView {
    _iconImgView.layer.cornerRadius = 35;
    _iconImgView.layer.masksToBounds = YES;
    //让导航栏透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
    //让黑线消失的方法
    self.navigationController.navigationBar.shadowImage=[UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    [_topImgView addSubview:_iconImgView];
    [_topImgView addSubview:_userNameLabel];
    [_topImgView addSubview:_sexImgView];
    [_topImgView addSubview:_fansLabel];
    [_topImgView addSubview:_focusLabel];
    [self.view insertSubview:_topImgView atIndex:self.view.subviews.count-1];
    [self.view insertSubview:_selectedImgView atIndex:self.view.subviews.count-1];
    [self.view insertSubview:_imageButton aboveSubview:_selectedImgView];
    [self.view insertSubview:_taskButton aboveSubview:_selectedImgView];
    [self.view insertSubview:_footButton aboveSubview:_selectedImgView];
}
#pragma mark - 视图切换
- (IBAction)buttonAction:(UIButton *)sender {
    if (sender.tag == 101) {
        [self.view insertSubview:_collectionView belowSubview:_selectedImgView];
    }else if (sender.tag == 102){
        [self.view insertSubview:_tableView belowSubview:_selectedImgView];
    }else if (sender.tag == 103){
        [self.view insertSubview:_footTableView belowSubview:_selectedImgView];

    }
    [self.view insertSubview:_topImgView atIndex:self.view.subviews.count-1];
}

#pragma mark - collectionView代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imageArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ImageCell" owner:nil options:nil]lastObject];
    }
    ContentModel *model = _imageArray[indexPath.row];
    cell.imageUrl = [NSURL URLWithString:model.photo_url];
    return cell;
}
#pragma mark - 表视图代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _tableView) {
        return _dataArray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _tableView) {
        DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"DetailCell" owner:nil options:nil]lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.activity = _dataArray[indexPath.row];
        return cell;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return _topImgView.frame.size.height + _selectedImgView.frame.size.height-64;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ActivityModel *model = _dataArray[indexPath.row];
    NSString *topic = model.topic;
    CGSize maxSize = CGSizeMake(kScreenWidth - 20, 9000);
    CGRect topicRect = [topic boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:nil];
    
    NSString *des = model.des;
    CGRect desRect = [des boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    
    return  200 + kScrollViewHeight + topicRect.size.height + 23 + desRect.size.height + 10;

}
#pragma mark - 请求数据
- (void)requestData:(NSNotification *)noti {
    NSInteger userID = [noti.userInfo[@"userID"]integerValue];
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    if ([userDef objectForKey:@"userID"]) {
        [userDef removeObjectForKey:@"userID"];
    }
    [userDef setObject:@(userID) forKey:@"userID"];
    [userDef synchronize];
   }
- (void)requestData {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSInteger userID = [[def objectForKey:@"userID"]integerValue];
    NSString *urlStr = [NSString stringWithFormat:@"http://q.chanyouji.com/api/v1/users/%li/profiles.json",userID];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self loadData:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    urlStr = [NSString stringWithFormat:@"http://q.chanyouji.com/api/v1/users/%li/user_activities.json?grouped=1",userID];
    [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self loadDetailData:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
//处理数据
- (void)loadDetailData:(NSDictionary *)DataDic {
    NSMutableArray *mArray = [[NSMutableArray alloc]init];
    _imageArray = [[NSMutableArray alloc]init];
    NSArray *dataArr = DataDic[@"data"];
    for (NSDictionary *dic in dataArr) {
        NSArray *acArr = dic[@"activities"];
        for (NSDictionary *acDic in acArr) {
            ActivityModel *model = [ActivityModel yy_modelWithDictionary:acDic];
            [mArray addObject:model];
            NSArray *contents = acDic[@"contents"];
            for (NSDictionary *imgDic in contents) {
                ContentModel *imageModel = [ContentModel yy_modelWithDictionary:imgDic];
                [_imageArray addObject:imageModel];
            }
        }
    }
    _dataArray = [mArray copy];
    [_collectionView reloadData];
    [_tableView reloadData];
}
//填充信息
- (void)loadData:(NSDictionary *)responseObject {
    NSString *urlStr = [[[responseObject objectForKey:@"data"] objectForKey:@"header_photo"] objectForKey:@"photo_url"];
    [_topImgView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    [_iconImgView sd_setImageWithURL:[NSURL URLWithString:[[responseObject objectForKey:@"data"] objectForKey:@"photo_url"]]];
    _userNameLabel.text = [[responseObject objectForKey:@"data"] objectForKey:@"name"];
    NSInteger fans = [[[responseObject objectForKey:@"data"] objectForKey:@"followers_count"]integerValue];
    _fansLabel.text = [NSString stringWithFormat:@"%li粉丝",fans];
    NSInteger focus = [[[responseObject objectForKey:@"data"] objectForKey:@"followings_count"]integerValue];
    _focusLabel.text = [NSString stringWithFormat:@"%li关注",focus];
    
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"mask_titlebar64@2x.png"] forBarMetrics:0];
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
