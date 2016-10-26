//
//  ToolViewController.h
//  ON THE WAY
//
//  Created by Apple on 16/10/12.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import "BaseViewController.h"
#import "ThemeImageView.h"
@interface ToolViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *minTem;
@property (weak, nonatomic) IBOutlet UILabel *maxTem;
@property (weak, nonatomic) IBOutlet UILabel *airLever;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet ThemeImageView *weatherImageView;

@end
