//
//  DestinationModel.m
//  ON THE WAY
//
//  Created by Apple on 16/10/20.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import "DestinationModel.h"

@implementation DestinationModel

+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{
             //model类中的属性作为key json字典中的key作为value
             @"destination_id":@"id"
             };
}

@end
