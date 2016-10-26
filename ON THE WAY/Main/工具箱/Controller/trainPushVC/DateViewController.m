//
//  DateViewController.m
//  ON THE WAY
//
//  Created by Apple on 16/10/20.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import "DateViewController.h"
#import "MyCalendarItem.h"
@interface DateViewController ()
@property(nonatomic,strong)MyCalendarItem *calendarView2;
@end

@implementation DateViewController

-(MyCalendarItem *)calendarView2{
    if (!_calendarView2) {
        _calendarView2 = [[MyCalendarItem alloc] init];
        _calendarView2.frame = CGRectMake(0, 64, kScreenWidth, 200);
//        _calendarView2.center = self.view.center;
    }
    return _calendarView2;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.calendarView2.date = [NSDate date];
    self.title = @"选择出发日期";
    [self.view addSubview:self.calendarView2];
    __weak DateViewController *weakSelf = self;
    _calendarView2.calendarBlock =  ^(NSInteger day, NSInteger month, NSInteger year){
        if (weakSelf.Block) {
            weakSelf.Block(day,month,year);
        }
//        NSLog(@"%li-%02li-%02li", year,month,day);
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
//    NSLog(@"%@", [self nsdateToString:[NSDate date]]);
    // Do any additional setup after loading the view, typically from a nib.
}
//将NSDate按yyyy-MM-dd格式时间输出
-(NSString*)nsdateToString:(NSDate *)date
{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString* string=[dateFormat stringFromDate:date];
    return string;
}

//将时间戳转换成NSDate,加上时区偏移。这个转换之后是北京时间
-(NSDate*)zoneChange:(NSString*)spString
{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[spString intValue]];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:confromTimesp];
    NSDate *localeDate = [confromTimesp  dateByAddingTimeInterval: interval];
    NSLog(@"%@",localeDate);
    return localeDate;
}
//将yyyy-MM-dd格式时间转换成时间戳
-(long)changeTimeToTimeSp:(NSString *)timeStr
{
    long time;
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *fromdate=[format dateFromString:timeStr];
    time= (long)[fromdate timeIntervalSince1970];
    NSLog(@"%ld",time);
    return time;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
