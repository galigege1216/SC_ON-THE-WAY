//
//  TopBGView.m
//  ON THE WAY
//
//  Created by Apple on 16/10/24.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import "TopBGView.h"
#import "WikiDestinationViewController.h"


#define kBgImageViewHeight 180
#define kLabelHeight 20
#define kBottomLabelHeight 40



@implementation TopBGView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
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
        NSString *string = [NSString stringWithFormat:@"查看%@攻略",_destinationModel.name];
        _bottomLabel.text = string;
    }
    
}

-(void)setData:(NSDictionary *)data{
    if (_data != data) {
        _data = data;
        NSArray *goods = _data[@"goods"];
        NSDictionary *wikiDic = goods[0][@"wiki_destination"];
        _wikiDestinationID = [NSString stringWithFormat:@"%@",wikiDic[@"id"]] ;
        
    }
}

-(void)createSubViews{
    //背景图片
    //    self.backgroundColor = [UIColor grayColor];
    _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, kBgImageViewHeight)];
//    _bgImageView.backgroundColor = [UIColor greenColor];

    
    [self addSubview:_bgImageView];
    
    //label
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kBgImageViewHeight/2, self.bounds.size.width, kLabelHeight)];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.textColor = [UIColor blackColor];
    _name_pinyinLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kBgImageViewHeight/2+kLabelHeight, self.bounds.size.width, kLabelHeight)];
    _name_pinyinLabel.textColor = [UIColor grayColor];
    _name_pinyinLabel.textAlignment = NSTextAlignmentCenter;
    _name_pinyinLabel.font = [UIFont systemFontOfSize:12];
//    _name_pinyinLabel.backgroundColor = [UIColor redColor];
    
    [self addSubview:_nameLabel];
    [self addSubview:_name_pinyinLabel];
    
    _bottomLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kBgImageViewHeight, self.bounds.size.width, kBottomLabelHeight)];
    _bottomLabel.textAlignment = NSTextAlignmentCenter;
    _bottomLabel.textColor = [UIColor cyanColor];
    _bottomLabel.backgroundColor = [UIColor whiteColor];
    //添加触摸手势
    [self addSubview:_bottomLabel];
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTapAction:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tap];
    
}

-(void)viewTapAction:(UITapGestureRecognizer *)tap{
    NSLog(@"被点击");
    WikiDestinationViewController *wikiVC = [[WikiDestinationViewController alloc]init];
    wikiVC.hidesBottomBarWhenPushed = YES;
    wikiVC.urlString = [NSString stringWithFormat:@"http://chanyouji.com/api/wiki/destinations/%@.json",_wikiDestinationID];
    
    //使用响应者链查找导航控制器
    UIResponder *nextResponder =self.nextResponder;
    while (nextResponder) {
        //找到导航控制器 跳转界面跳出循环
        if ([nextResponder isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navi = (UINavigationController *)nextResponder;
            //跳转
            [navi pushViewController:wikiVC animated:YES];
            break;
        }
        nextResponder = nextResponder.nextResponder;
    }
    
}

@end
