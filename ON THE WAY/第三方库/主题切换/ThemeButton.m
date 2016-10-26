//
//  ThemeButton.m
//  SinaWeibo_qtw
//
//  Created by 汇文教育17 on 16/10/10.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import "ThemeButton.h"
#import "ThemeManager.h"
@implementation ThemeButton

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeDidChanged) name:kThemeChangeNotificationName object:nil];
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeDidChanged) name:kThemeChangeNotificationName object:nil];
}

-(void)setImageName:(NSString *)imageName{
    _imageName = [imageName copy];
    [self themeDidChanged];
}
-(void)setBackgroundImgName:(NSString *)backgroundImgName{
    _backgroundImgName = [backgroundImgName copy];
    [self themeDidChanged];
}
- (void)themeDidChanged {
    [self setImage:[[ThemeManager shareManager]getThemeImageWithImageName:self.imageName]forState:UIControlStateNormal];
    
    [self setBackgroundImage:[[ThemeManager shareManager]getThemeImageWithImageName:self.backgroundImgName] forState:UIControlStateNormal];
}
@end
