//
//  ThemeImageView.m
//  SinaWeibo_qtw
//
//  Created by 汇文教育17 on 16/10/10.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import "ThemeImageView.h"
#import "ThemeManager.h"
@implementation ThemeImageView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeDidChanged) name:kThemeChangeNotificationName object:nil];
    }
    return self;
}
//移除通知
-(void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

//从StoryBoard中加载不会调用initWithFrame
-(void)awakeFromNib {
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeDidChanged) name:kThemeChangeNotificationName object:nil];
}
- (void)setImageName:(NSString *)imageName {
    _imageName = [imageName copy];
    [self themeDidChanged];

}
- (void)themeDidChanged{
//    //获取图片名
//    NSString *kImagePath = noti.userInfo[@"kImagePath"];
//    //拼接完成的图片路径
//    NSString *imageName = [NSString stringWithFormat:@"%@%@",kImagePath,_imageName];
//    //设置图片
//    self.image = [UIImage imageNamed:imageName];
    UIImage *image = [[ThemeManager shareManager]getThemeImageWithImageName:self.imageName];
    self.image = [image stretchableImageWithLeftCapWidth:self.leftCapWidth topCapHeight:self.topCapHeight];
}
@end
