//
//  WikiCell.h
//  ON THE WAY
//
//  Created by Apple on 16/10/25.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WikiCategoryModel;

@interface WikiCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *title_enLabel;

@property(nonatomic,strong)UIButton *subButton;
@property(nonatomic,strong)NSArray *cellButtons;
@property(nonatomic,strong)WikiCategoryModel *wikiModel;
@property(nonatomic,copy)NSArray *titleArr;
@property(nonatomic,copy)NSArray *titlt_enArr;

@end
