//
//  DestinationView.m
//  ON THE WAY
//
//  Created by Apple on 16/10/20.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import "DestinationView.h"
#import "TopDestinationViewController.h"
#import "BaseDestinationViewController.h"


#define kHomeDestinationBGViewHeight 80
#define kLabelHeight 20
#define topSpaceHeight 10

@implementation DestinationView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
        
    }
    return self;
}

-(void)setDestinationModel:(DestinationModel *)destinationModel{
    
    if (_destinationModel != destinationModel) {
        _destinationModel = destinationModel;
        //加载图片
        
        [_bgImageView sd_setImageWithURL:_destinationModel.photo_url];
        _nameLabel.text = _destinationModel.name;
        _name_pinyinLabel.text = _destinationModel.name_en;
        
    }
    
    
}

-(void)createSubViews{
    //背景图片
//    self.backgroundColor = [UIColor grayColor];
    _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, kHomeDestinationBGViewHeight)];
//    _bgImageView.backgroundColor = [UIColor redColor];
    _bgImageView.layer.cornerRadius = 10.0;
    _bgImageView.layer.masksToBounds = YES;
    
    [self addSubview:_bgImageView];
    
    //label
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kHomeDestinationBGViewHeight, self.bounds.size.width, kLabelHeight)];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _name_pinyinLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kHomeDestinationBGViewHeight+kLabelHeight, self.bounds.size.width, kLabelHeight)];
    _name_pinyinLabel.textColor = [UIColor grayColor];
    _name_pinyinLabel.textAlignment = NSTextAlignmentCenter;
    _name_pinyinLabel.font = [UIFont systemFontOfSize:12];
//    _name_pinyinLabel.backgroundColor = [UIColor redColor];
    
    [self addSubview:_nameLabel];
    [self addSubview:_name_pinyinLabel];
    //添加触摸手势
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTapAction:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tap];
    
}

-(void)viewTapAction:(UITapGestureRecognizer *)tap{
    NSLog(@"被点击");
    TopDestinationViewController *destinationVC = [[TopDestinationViewController alloc]init];
    NSString *urlString = [NSString stringWithFormat:@"http://q.chanyouji.com/api/v3/destinations/%@.json",_destinationModel.destination_id];
    destinationVC.urlString = urlString;
    
    //使用响应者链查找导航控制器
    UIResponder *nextResponder =self.nextResponder;
    while (nextResponder) {
        //找到导航控制器 跳转界面跳出循环
        if ([nextResponder isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navi = (UINavigationController *)nextResponder;
            //跳转
            [navi pushViewController:destinationVC animated:YES];
            break;
        }
        nextResponder = nextResponder.nextResponder;
    }
    
}


@end
