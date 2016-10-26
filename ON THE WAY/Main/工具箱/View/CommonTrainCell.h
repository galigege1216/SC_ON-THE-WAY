//
//  CommonTrainCell.h
//  ON THE WAY
//
//  Created by Apple on 16/10/20.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketModel.h"
@interface CommonTrainCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *TrainNum;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UILabel *toLabel;
@property (weak, nonatomic) IBOutlet UILabel *startLabel;
@property (weak, nonatomic) IBOutlet UILabel *endLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationTime;
@property (weak, nonatomic) IBOutlet UILabel *sleepHigh;
@property (weak, nonatomic) IBOutlet UILabel *sleepLow;
@property (weak, nonatomic) IBOutlet UILabel *seat;
@property (weak, nonatomic) IBOutlet UILabel *noSeat;
@property (nonatomic , strong)TicketModel *model;
@end
