//
//  BaseDestinationViewController.h
//  ON THE WAY
//
//  Created by Apple on 16/10/21.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import "BaseViewController.h"
@class DestinationModel;
@class TopBGView;


@interface BaseDestinationViewController : BaseViewController

@property(nonatomic,copy)NSDictionary *data;
@property(nonatomic,copy)NSArray *sections;
@property(nonatomic,copy)NSString *urlString;
@property(nonatomic,strong)DestinationModel *destination;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)UIImageView *naviBGimageView;
@property(nonatomic,strong)TopBGView *topBGView;

@end
