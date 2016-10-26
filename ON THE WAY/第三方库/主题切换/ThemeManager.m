//
//  ThemeManager.m
//  SinaWeibo_qtw
//
//  Created by 汇文教育17 on 16/10/10.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import "ThemeManager.h"
#define kCurrentThemeName @"kCurrentThemeName"
@implementation ThemeManager
#pragma mark - 创建单例
+(ThemeManager *)shareManager {
    static ThemeManager *instence = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instence == nil) {
            instence = [[super allocWithZone:nil]init];
        }
    });
    return instence;
}
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    return [self shareManager];
}
-(id)copy{
    return self;
}

#pragma mark - 读取配置文件
- (instancetype)init {
    if (self = [super init]) {
        NSString *filePath = [[NSBundle mainBundle]pathForResource:@"theme" ofType:@"plist"];
        ThemeDictionary = [[NSDictionary alloc]initWithContentsOfFile:filePath];
        //本地主题持久化
        NSString *name = [[NSUserDefaults standardUserDefaults]objectForKey:kCurrentThemeName];
        if (name == nil) {
            //设置默认主题名
            _currentThemeName = @"猫爷";
        }
        else{
            _currentThemeName = name;
        }
        [self loadColorConfig];
    }
    return self;
}
//切换主题
- (void)setCurrentThemeName:(NSString *)currentThemeName{
    if ([currentThemeName isEqualToString:_currentThemeName]) {
        return;
    }
    NSString *themePath = ThemeDictionary[currentThemeName];
    if (themePath == nil) {
        
        return;
    }
    _currentThemeName = [currentThemeName copy];
    //发送通知
    [[NSNotificationCenter defaultCenter]postNotificationName:kThemeChangeNotificationName object:nil];
    //保存当前主题名
    [[NSUserDefaults standardUserDefaults]setObject:_currentThemeName forKey:kCurrentThemeName];
    [self loadColorConfig];
    
    
}

//获取图片
- (UIImage *)getThemeImageWithImageName:(NSString *)imageName{
    return [UIImage imageNamed:imageName];
}
//获取颜色
- (UIColor *)getColorWithColorName:(NSString *)colorName {
    NSDictionary *colorDic = colorConfig[colorName];
    
    NSNumber *R = colorDic[@"R"];
    NSNumber *G = colorDic[@"G"];
    NSNumber *B = colorDic[@"B"];
    NSNumber *A = colorDic[@"alpha"];
    
    CGFloat red = [R floatValue];
    CGFloat green = [G floatValue];
    CGFloat blue = [B floatValue];
    CGFloat alpha = [A floatValue];
    if (alpha == 0) {
        alpha = 1;
    }
    
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
    
}
#pragma mark - 读取颜色数据
- (void)loadColorConfig {
    //获取根目录路径
    NSString *bundlePath = [[NSBundle mainBundle]resourcePath];
    //获取当前主题对应的路径
    NSString *filePath = ThemeDictionary[_currentThemeName];
    //获取完整的路径
    NSString *path = [NSString stringWithFormat:@"%@/%@/config.plist",bundlePath,filePath];
    
    colorConfig = [NSDictionary dictionaryWithContentsOfFile:path];
    
}
@end
