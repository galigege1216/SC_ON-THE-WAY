//
//  DateViewController.h
//  ON THE WAY
//
//  Created by Apple on 16/10/20.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^dateBlock)(NSInteger reday, NSInteger remonth, NSInteger reyear);

@interface DateViewController : BaseViewController
@property (nonatomic,strong) dateBlock Block;
@end
