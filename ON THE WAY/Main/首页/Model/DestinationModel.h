//
//  DestinationModel.h
//  ON THE WAY
//
//  Created by Apple on 16/10/20.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DestinationModel : NSObject

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *name_en;
@property(nonatomic,copy)NSURL *photo_url;
@property(nonatomic,copy)NSString *destination_id;  //id:109
@property(nonatomic,copy)NSString *path;    //.1.5.109.
@property(nonatomic,copy)NSString *level;   //3

@end
