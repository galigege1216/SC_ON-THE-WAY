//
//  TravelModel.h
//  ON THE WAY
//
//  Created by Apple on 16/10/24.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
#import "ActivityModel.h"
@interface TravelModel : NSObject

@property (nonatomic , copy)NSString *event_type;
@property (nonatomic , strong)UserModel *user;
@property (nonatomic , strong)ActivityModel *activity;
@end
