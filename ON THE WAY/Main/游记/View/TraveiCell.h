//
//  TraveiCell.h
//  ON THE WAY
//
//  Created by Apple on 16/10/24.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TravelModel.h"
@interface TraveiCell : UITableViewCell<PhotoBrowerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userCommand;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewBig;

@property (nonatomic , strong)TravelModel *model;
@property (nonatomic , copy)NSMutableArray *imageViewArr;//存放图片视图

@property (nonatomic , strong)UIScrollView *scrolView;   //滑动视图
@property (nonatomic , strong)UILabel *topicLabel;       //标题
@property (nonatomic , strong)UILabel *descriptionLabel; //详情描述
@property (nonatomic , strong)UIButton *moreButton;

@property (nonatomic , strong)UIImageView *lineImageView;
@end
