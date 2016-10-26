//
//  TicketModel.h
//  ON THE WAY
//
//  Created by Apple on 16/10/20.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TicketModel : NSObject
@property (nonatomic , copy)NSString *trainNo;
@property (nonatomic , copy)NSString *from;
@property (nonatomic , copy)NSString *to;
@property (nonatomic , copy)NSString *startTime;
@property (nonatomic , copy)NSString *endTime;
@property (nonatomic , copy)NSString *duration;
@property (nonatomic, strong)NSArray *seatInfos;
@end
