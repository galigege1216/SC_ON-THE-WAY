//
//  HighTrainCell.m
//  ON THE WAY
//
//  Created by Apple on 16/10/20.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import "HighTrainCell.h"

@implementation HighTrainCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setModel:(TicketModel *)model {
    if (_model != model) {
        _model = model;
    }
    self.trainNum.text = _model.trainNo;
    self.fromLabel.text = _model.from;
    self.toLabel.text = _model.to;
    self.startLabel.text = _model.startTime;
    self.endLabel.text = _model.endTime;
    self.durationLabel.text = _model.duration;
    NSArray *seatInfo = _model.seatInfos;
    NSDictionary *dic = seatInfo[0];
    NSString *remainNum = dic[@"remainNum"];
    NSString *seatPrice = dic[@"seatPrice"];
    self.twoLeveiSeat.text = [NSString stringWithFormat:@"二等座:%@张/%@元",remainNum,seatPrice];
    dic = seatInfo[1];
    remainNum = dic[@"remainNum"];
    seatPrice = dic[@"seatPrice"];
    self.oneLeveiSeat.text = [NSString stringWithFormat:@"一等座:%@张/%@元",remainNum,seatPrice];
    dic = seatInfo[2];
    remainNum = dic[@"remainNum"];
    seatPrice = dic[@"seatPrice"];
    self.businessSeat.text = [NSString stringWithFormat:@"商务:%@张/%@元",remainNum,seatPrice];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
