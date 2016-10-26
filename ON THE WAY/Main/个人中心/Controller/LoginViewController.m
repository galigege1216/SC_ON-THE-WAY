//
//  LoginViewController.m
//  ON THE WAY
//
//  Created by Apple on 16/10/13.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "DBManager.h"
#import "User.h"
@class DBManager;
@interface LoginViewController ()<NSFetchedResultsControllerDelegate,UIAlertViewDelegate>{
    NSFetchedResultsController *_fetchdeCtrl;
}

@end

@implementation LoginViewController
- (IBAction)cancleAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)loginAction:(UIButton *)sender {
    [self judgeIsNullString];
//    [self createFetchedResultsController];
//    [self fetchUserInfomation];
}
//判断输入是否为空
- (void)judgeIsNullString {
    if ([_userName.text isEqualToString:@""]&&[_password.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"请输入用户名和密码!" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"返回", nil];
        [alert show];
        return;
    }else if ([_password.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"密码不能为空!" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"返回", nil];
        [alert show];
        return;
    }else if ([_userName.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"用户名不能为空!" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"返回", nil];
        [alert show];
        return;
    }
    [self createFetchedResultsController];
    [self fetchUserInfomation];
}

//创建查询结果控制器
- (void)createFetchedResultsController {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"userName" ascending:YES];
    
    request.sortDescriptors = @[sort];
    
    _fetchdeCtrl = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:[[DBManager shareManager]managedObjectContext] sectionNameKeyPath:@"userName"cacheName:nil];
    
    _fetchdeCtrl.delegate = self;
    
    [_fetchdeCtrl performFetch:nil];
}
//查询用户名和密码是否正确
- (void)fetchUserInfomation {
    for (id <NSFetchedResultsSectionInfo> sectionObject in _fetchdeCtrl.sections) {
        for (User *user in sectionObject.objects) {
            if (user.userName == _userName.text && user.password == _password.text) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"登录成功!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
                return;
            }
        }
    }
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"用户名或密码错误!" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"返回登录", nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)register:(UIButton *)sender {
    RegisterViewController *regi = [[RegisterViewController alloc]init];
    self.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:regi animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _userName.text = nil;
    _password.text = nil;
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
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
