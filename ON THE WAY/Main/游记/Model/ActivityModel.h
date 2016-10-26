//
//  ActivityModel.h
//  ON THE WAY
//
//  Created by Apple on 16/10/24.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
@interface ActivityModel : NSObject
@property (nonatomic , strong)NSNumber *activityID;
@property (nonatomic,strong)NSNumber *likes_count;

@property (nonatomic , copy)NSString *topic;                  //标题
@property (nonatomic , strong)NSNumber *favorites_count;      //五角星
@property (nonatomic , strong)NSNumber *level;
@property (nonatomic , copy)NSString *des;                    //描述
@property (nonatomic , copy)NSMutableArray *contents;         //图片数组
@property (nonatomic , strong)UserModel *user;
@end
