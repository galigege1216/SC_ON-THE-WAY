//
//  DestinationCell.m
//  ON THE WAY
//
//  Created by Apple on 16/10/27.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import "DestinationCell.h"
#import "DestinationView.h"



#define destinationCellHeight (80+20*2+15*2)
#define subItemWidth 80
#define labelHeight 20
#define spaceWidth 15

@interface DestinationCell ()
{
    UIScrollView *_backScrollView;
    NSInteger _count;
}

@end

@implementation DestinationCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addContentView];
    }
    return self;
}

#pragma mark - 滑动视图
-(void)addContentView{
    _backScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, destinationCellHeight)];
    //滑动速度
    _backScrollView.decelerationRate = 0.8;
    _backScrollView.userInteractionEnabled = YES;
    _backScrollView.directionalLockEnabled = YES;
    _backScrollView.pagingEnabled = NO;
    _backScrollView.bounces = NO;
    _backScrollView.showsHorizontalScrollIndicator = NO;
    _backScrollView.showsVerticalScrollIndicator = NO;
    
    [self.contentView addSubview:_backScrollView];
    
    
}

#pragma mark - 子视图

-(void)setModels:(NSArray *)models{
    //创建子视图
    _models = models;
    for (int i = 0; i < models.count; i++) {
        CGFloat subItemX = spaceWidth + (spaceWidth + subItemWidth)*i;
        CGRect frame = CGRectMake(subItemX, spaceWidth, subItemWidth, subItemWidth);
        DestinationView *subView = [[DestinationView alloc]initWithFrame:frame];
        //图片边框
        subView.bgImageView.layer.masksToBounds = NO;
        //字体大小
        subView.nameLabel.font = [UIFont systemFontOfSize:14];
        subView.name_pinyinLabel.font = [UIFont systemFontOfSize:12];
        subView.destinationModel = models[i];
        [_backScrollView addSubview:subView];
    }
    _backScrollView.contentSize = CGSizeMake((_models.count + 1)*spaceWidth + _models.count *subItemWidth, 0);
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
