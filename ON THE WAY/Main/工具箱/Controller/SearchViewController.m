//
//  SearchViewController.m
//  ON THE WAY
//
//  Created by Apple on 16/10/15.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import "SearchViewController.h"
#import "AFNetworking.h"
@class AFHTTPSessionManager;
@interface SearchViewController ()

@end

@implementation SearchViewController
- (IBAction)searchAction:(UIButton *)sender {
    [self searchData];
}

- (void)searchData {
    [self.navigationController popViewControllerAnimated:YES];
    //保存记录
    
//    NSString *urlWeatherStr = @"http://apis.baidu.com/apistore/weatherservice/weather";
    NSString *urlWeatherStr = @"http://apis.baidu.com/heweather/weather/free";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager.requestSerializer setValue:@"86713d64e814e3a2a9392d7f4e43c06e" forHTTPHeaderField:@"apikey"];
    
    NSDictionary *weatherDic = @{@"city":_searchText.text};
    
    [manager GET:urlWeatherStr parameters:weatherDic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dataDic = (NSDictionary *)responseObject;
        NSArray *retData = dataDic[@"HeWeather data service 3.0"];
        NSDictionary *basic = retData[0];
        
        NSDictionary *basic1 = basic[@"basic"];

        NSString *location = basic1[@"city"];
        
        NSArray *temp = [basic objectForKey:@"daily_forecast"];
        NSDictionary *dic = [temp[0] objectForKey:@"tmp"];
        NSString *maxTem = dic[@"max"];
        NSString *minTem = dic[@"min"];
        
        NSString *air = [[[basic objectForKey:@"aqi"] objectForKey:@"city"] objectForKey:@"qlty"];
        //处理时间
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
        NSDate *currentTime = [formatter dateFromString:[basic1[@"update"] objectForKey:@"loc"]];
        [formatter setDateFormat:@"yyyy年M月d日"];
        [formatter setLocale:[NSLocale currentLocale]];
        NSString *time = [formatter stringFromDate:currentTime];
        
        NSString *wea = [[[basic objectForKey:@"now"] objectForKey:@"cond"] objectForKey:@"txt"];
        if (location != nil && minTem != nil && maxTem != nil && time != nil && air != nil && wea != nil) {
            //block传值
            if (self.block) {
                self.block(location,minTem,maxTem,time,air,wea);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
