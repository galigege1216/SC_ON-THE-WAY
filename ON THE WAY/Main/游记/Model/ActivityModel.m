//
//  ActivityModel.m
//  ON THE WAY
//
//  Created by Apple on 16/10/24.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import "ActivityModel.h"

@implementation ActivityModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"activityID":@"id",
             @"des":@"description"};
}
@end
