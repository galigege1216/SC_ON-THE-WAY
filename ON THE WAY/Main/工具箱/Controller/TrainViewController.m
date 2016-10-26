//
//  TrainViewController.m
//  ON THE WAY
//
//  Created by Apple on 16/10/19.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import "TrainViewController.h"
#import "DateViewController.h"
@interface TrainViewController ()

@end

@implementation TrainViewController
- (IBAction)dateSelect:(UIButton *)sender {
    DateViewController *date = [[DateViewController alloc]init];
    [self.navigationController pushViewController:date animated:YES];
    //实现Block
    date.Block = ^(NSInteger reday, NSInteger remonth, NSInteger reyear){
        [sender setTitle:[NSString stringWithFormat:@"%li-%02li-%02li", reyear,remonth,reday] forState:UIControlStateNormal];
    };
}
- (IBAction)search:(UIButton *)sender {
    NSDictionary *params = @{@"version":@"1.0",
                             @"from":_fromTextField.text,
                             @"to":_toTextField.text,
                             @"date":_dateButton.currentTitle};
    [[NSNotificationCenter defaultCenter]postNotificationName:@"params" object:nil userInfo:params];
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
