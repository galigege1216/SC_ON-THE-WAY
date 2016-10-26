//
//  UserModel.m
//  ON THE WAY
//
//  Created by Apple on 16/10/24.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"userID":@"id"};
}
@end
