//
//  ListTableViewCell.h
//  ON THE WAY
//
//  Created by Apple on 16/10/21.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DestinationModel;

@interface ListTableViewCell : UITableViewCell

@property(nonatomic,strong)DestinationModel *destination;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *name_enLabel;





@end
