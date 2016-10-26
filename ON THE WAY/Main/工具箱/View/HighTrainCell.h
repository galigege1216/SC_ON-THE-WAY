//
//  HighTrainCell.h
//  ON THE WAY
//
//  Created by Apple on 16/10/20.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketModel.h"
@interface HighTrainCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *trainNum;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UILabel *toLabel;
@property (weak, nonatomic) IBOutlet UILabel *startLabel;
@property (weak, nonatomic) IBOutlet UILabel *endLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UILabel *businessSeat;
@property (weak, nonatomic) IBOutlet UILabel *oneLeveiSeat;
@property (weak, nonatomic) IBOutlet UILabel *twoLeveiSeat;
@property (nonatomic , strong)TicketModel *model;
@end
