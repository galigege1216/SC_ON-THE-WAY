//
//  WikiCellLayout.h
//  ON THE WAY
//
//  Created by Apple on 16/10/26.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WikiCategoryModel;

#define cellTopViewHeight 50
#define spaceWidth 10
#define cellButtonHeight 30
#define lineSpace 3
#define verticalSpace 10

@interface WikiCellLayout : NSObject
//输入
@property(nonatomic,strong)WikiCategoryModel *wikiModel;

+(instancetype)layoutWithWikiModel:(WikiCategoryModel *)wikiModel;
//布局输出
@property(nonatomic,strong,readonly)NSArray *buttonFrameArr;

-(CGFloat)cellHeight;



@end
