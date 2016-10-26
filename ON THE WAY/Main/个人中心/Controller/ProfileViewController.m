//
//  ProfileViewController.m
//  ON THE WAY
//
//  Created by Apple on 16/10/12.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import "ProfileViewController.h"
#import "LoginViewController.h"
@interface ProfileViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [self createView];
}
- (void)createView {
    titleArr = [NSArray arrayWithObjects:@"",@"在线论坛",@"缓存清理",@"关于我们", nil];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, 200)];
    _imgView.image = [UIImage imageNamed:@"head.jpg"];
    _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginButton.frame = CGRectMake((kScreenWidth-100)/2, 60, 120, 80);
    _loginButton.center = _imgView.center;
    [_loginButton setImage:[UIImage imageNamed:@"chat_pic_im_default@2x.png"] forState:UIControlStateNormal];
    [_loginButton setTitle:@"点击登录" forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:_imgView aboveSubview:_tableView];
    [self.view insertSubview:_loginButton aboveSubview:_imgView];
}
- (void)buttonAction:(UIButton *)btn{
    LoginViewController *login = [[LoginViewController alloc]init];
    self.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:login animated:YES completion:nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 180;
    }
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.textLabel.text = titleArr[indexPath.row];
    return cell;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offSet = scrollView.contentOffset.y+20;
    if (offSet > 0) {
        CGRect frame = _imgView.frame;
        frame.origin.y = - offSet;
        _imgView.frame = frame;
    }
    else{
        CGFloat newHeight = 200 - offSet;
        CGFloat newWidth = newHeight / 200 * kScreenWidth;
        _imgView.frame = CGRectMake(-(newWidth/2-kScreenWidth/2), 0,
            newWidth, newHeight);
        _loginButton.center = _imgView.center;
    }
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
