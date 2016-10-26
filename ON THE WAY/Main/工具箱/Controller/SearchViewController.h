//
//  SearchViewController.h
//  ON THE WAY
//
//  Created by Apple on 16/10/15.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
typedef void(^resultTextBlock)(NSString *location,NSString *minTem,NSString *maxTem,NSString *time,NSString *air,NSString *wea);

@interface SearchViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *searchText;
@property (strong,nonatomic)resultTextBlock block;
@end
