//
//  ToolViewController.m
//  ON THE WAY
//
//  Created by Apple on 16/10/12.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import "ToolViewController.h"
#import "SearchViewController.h"
#import "MoneyViewController.h"
#import "ThemeImageView.h"
#import "TrainViewController.h"

#define klocationLabel @"locationLabel"
#define kminTem @"minTem"
#define kmaxTem @"maxTem"
#define ktimeLabel @"timeLabel"
#define kairLever @"airLever"
#define kweatherImage @"kweatherImage"
#define kWeatherDefKey @"kWeatherDefKey"
@interface ToolViewController ()

@end

@implementation ToolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNaviRightItem];
    
}
- (IBAction)buttonAction:(UIButton *)sender {
    if (sender.tag == 102){
        //货币换算视图
        MoneyViewController *money = [[MoneyViewController alloc]init];
        [self.navigationController pushViewController:money animated:YES];
    }else if (sender.tag == 103){
        
    }else{
        //地图
    }
}

- (void)createNaviRightItem {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 39, 39);
    [button setImage:[UIImage imageNamed:@"main_callcenter_glass@3x.png"] forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = item;
}
- (void)buttonAction {
    SearchViewController *search = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:search animated:YES];
    
    //接收数据，设置数据
    search.block = ^(NSString *location,NSString *minTem,NSString *maxTem,NSString *time,NSString *air,NSString *wea){
        NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
        NSDictionary *dataDic = [userDef objectForKey:kWeatherDefKey];
        if (dataDic != nil){
            [userDef removeObjectForKey:kWeatherDefKey];
        }
        self.locationLabel.text = location;
        self.minTem.text = [NSString stringWithFormat:@"%@℃",minTem];
        self.maxTem.text = [NSString stringWithFormat:@"%@℃",maxTem];
        self.timeLabel.text = time;
        self.airLever.text = air;
        [self isMatchWeather:wea];
        [self saveData];
    };
}
//设置天气图片
- (void)isMatchWeather:(NSString *)weaStr {
    NSArray *sunny = @[@"晴",@"晴转多云"];
    for (NSString *str in sunny) {
        if ([weaStr isEqualToString:str]) {
            _weatherImageView.imageName = @"晴天.jpg";
            return;
        }
    }
    NSArray *rain = @[@"阵雨",@"雷阵雨",@"小雨",@"中雨",@"大雨",@"暴雨",@"大暴雨",@"特大暴雨"];
    for (NSString *str in rain) {
        if ([weaStr isEqualToString:str]) {
            _weatherImageView.imageName = @"下雨.jpg";
            return;
        }
    }
    NSArray *snow = @[@"冰雹",@"雨夹雪",@"阵雪",@"小雪",@"中雪",@"大雪",@"暴雪",@"小到中雪",@"中到大雪",@"大到暴雪"];
    for (NSString *str in snow) {
        if ([weaStr isEqualToString:str]) {
            _weatherImageView.imageName = @"下雪.jpg";
            return;
        }
    }
    NSArray *cloudy = @[@"多云",@"多云转晴",@"阴"];
    for (NSString *str in cloudy) {
        if ([weaStr isEqualToString:str]) {
            _weatherImageView.imageName = @"多云.jpg";
            return;
        }
    }
    NSArray *wu = @[@"雾",@"冻雨",@"沙尘暴",@"浮尘",@"扬沙",@"沙尘暴",@"强沙尘暴",@"特强沙尘暴",@"轻雾",@"浓雾",@"强浓雾",@"轻微霾",@"轻度霾",@"中度霾",@"重度霾",@"特强霾",@"霰",@"飑线"];
    for (NSString *str in wu) {
        if ([weaStr isEqualToString:str]) {
            _weatherImageView.imageName = @"雾霾.jpeg";
            return;
        }
    }
    _weatherImageView.imageName = @"其他.jpg";
}
#pragma 处理数据
//保存数据
- (void)saveData {
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    [dataDic setObject:_locationLabel.text forKey:klocationLabel];
    [dataDic setObject:_minTem.text forKey:kminTem];
    [dataDic setObject:_maxTem.text forKey:kmaxTem];
    [dataDic setObject:_timeLabel.text forKey:ktimeLabel];
    [dataDic setObject:_airLever.text forKey:kairLever];
    [dataDic setObject:_weatherImageView.imageName forKey:kweatherImage];
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    [userDef setObject:dataDic forKey:kWeatherDefKey];
    [userDef synchronize];
//    NSLog(@"userDef:%@",NSHomeDirectory());
}
//读取数据
- (BOOL)readData {
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSDictionary *dataDic = [userDef objectForKey:kWeatherDefKey];
    if (dataDic != nil) {
        if ([dataDic objectForKey:klocationLabel]||[dataDic objectForKey:kminTem]||[dataDic objectForKey:kmaxTem]||[dataDic objectForKey:ktimeLabel]||[dataDic objectForKey:kairLever]) {
            _locationLabel.text = [dataDic objectForKey:klocationLabel];
            _minTem.text = [dataDic objectForKey:kminTem];
            _maxTem.text = [dataDic objectForKey:kmaxTem];
            _timeLabel.text = [dataDic objectForKey:ktimeLabel];
            _airLever.text = [dataDic objectForKey:kairLever];
            _weatherImageView.imageName = [dataDic objectForKey:kweatherImage];
            return YES;
        }else{
            [userDef removeObjectForKey:kWeatherDefKey];
            return NO;
        }
    }else{
        return NO;
    }
    return YES;
}
-(void)viewWillAppear:(BOOL)animated {
    [self readData];
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
