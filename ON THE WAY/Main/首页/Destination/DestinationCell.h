//
//  DestinationCell.h
//  ON THE WAY
//
//  Created by Apple on 16/10/27.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DestinationCell : UITableViewCell

@property(nonatomic,copy)NSArray *models;


-(void)setContentView:(NSArray *)models;

@end
