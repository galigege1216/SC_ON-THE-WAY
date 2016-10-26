//
//  ThemeManager.h
//  SinaWeibo_qtw
//
//  Created by 汇文教育17 on 16/10/10.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ThemeManager : NSObject{
    NSDictionary *ThemeDictionary;
    NSDictionary *colorConfig;
}

//当前使用的主题名字
@property (nonatomic , copy)NSString *currentThemeName;
//定义方法来获取图片
- (UIImage *)getThemeImageWithImageName:(NSString *)imageName;
//定义方法获取颜色
- (UIColor *)getColorWithColorName:(NSString *)colorName;

+ (ThemeManager *)shareManager; 
@end
