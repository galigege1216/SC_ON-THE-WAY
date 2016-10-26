//
//  HomeRegion.h
//  ON THE WAY
//
//  Created by Apple on 16/10/20.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeRegion : NSObject
//标题
@property(copy,nonatomic)NSString *name;
//是否有按钮title
@property(copy,nonatomic)NSString *button_text;
//地区名
@property(copy,nonatomic)NSString *region;
//目的地
@property(copy,nonatomic)NSArray *destinations;

@end
