//
//  UserModel.h
//  ON THE WAY
//
//  Created by Apple on 16/10/24.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property (nonatomic , strong)NSNumber *userID;       //用户id
@property (nonatomic , copy)NSString *name;         //用户昵称
@property (nonatomic , strong)NSNumber *gender;       //性别
@property (nonatomic , strong)NSNumber *level;        //等级
@property (nonatomic , copy)NSString *photo_url;    //头像地址

@end
