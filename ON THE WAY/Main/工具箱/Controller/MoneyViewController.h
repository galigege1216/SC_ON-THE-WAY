//
//  MoneyViewController.h
//  ON THE WAY
//
//  Created by Apple on 16/10/17.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface MoneyViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *CNYtextField;   //人民币
@property (weak, nonatomic) IBOutlet UITextField *DollarTextField;//美元
@property (weak, nonatomic) IBOutlet UITextField *EuroTextFiled;  //欧元
@property (weak, nonatomic) IBOutlet UITextField *KRWtextField;   //韩元
@property (weak, nonatomic) IBOutlet UITextField *THBtextField;   //泰铢

@end
