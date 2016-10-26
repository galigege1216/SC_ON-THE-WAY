//
//  RegisterViewController.m
//  ON THE WAY
//
//  Created by Apple on 16/10/13.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import "RegisterViewController.h"
#import "DBManager.h"
#import "User.h"
@class DBManager;
@interface RegisterViewController ()<NSFetchedResultsControllerDelegate,UIAlertViewDelegate>{
    NSFetchedResultsController *_fetchdeCtrl;
}

@end

@implementation RegisterViewController
- (IBAction)cancleAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)registerAction:(UIButton *)sender {
    [self judgeIsNullString];
//    [self createFetchedResultsController];
//    [self fetchUserName];
}
//判断输入是否为空
- (void)judgeIsNullString {
    if ([_userNewName.text isEqualToString:@""]&&[_passwordNew.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"请输入用户名和密码!" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"返回", nil];
        [alert show];
        return;
    }else if ([_passwordNew.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"密码不能为空!" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"返回", nil];
        [alert show];
        return;
    }else  if ([_userNewName.text isEqualToString:@""]&&[_passwordNew.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"请输入用户名和密码!" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"返回", nil];
        [alert show];
        return;
    }
    [self createFetchedResultsController];
    [self fetchUserName];
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
//查询用户名是否重复,不重复才保存
- (void)fetchUserName {
    for (id <NSFetchedResultsSectionInfo> sectionObject in _fetchdeCtrl.sections) {
        for (User *user in sectionObject.objects) {
            if (user.userName == _userNewName.text) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名已存在!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
                return;
            }
        }
    }
    [self saveUserInfomation];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"注册成功" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"返回登录", nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
//存储用户信息
- (void)saveUserInfomation {
    NSLog(@"%@",NSHomeDirectory());
    
    NSManagedObjectContext *context = [[DBManager shareManager]managedObjectContext];
    
    User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
    user.userName = _userNewName.text;
    user.password = _passwordNew.text;
    
    [[DBManager shareManager]saveContext];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
