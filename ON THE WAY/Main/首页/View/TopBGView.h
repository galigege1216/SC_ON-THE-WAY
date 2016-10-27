//
//  TopBGView.h
//  ON THE WAY
//
//  Created by Apple on 16/10/24.
//  Copyright © 2016年 qtw. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface TopBGView : UIView{
    NSString *_wikiDestinationID;
}

@property(nonatomic,strong)UIImageView *bgImageView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *name_pinyinLabel;
@property(nonatomic,strong)UILabel *bottomLabel;

@property(nonatomic,copy)NSDictionary *data;
@property(nonatomic,strong)DestinationModel *destinationModel;




@end
