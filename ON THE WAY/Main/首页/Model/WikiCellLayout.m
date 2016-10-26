//
//  WikiCellLayout.m
//  ON THE WAY
//
//  Created by Apple on 16/10/26.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import "WikiCellLayout.h"
#import "WikiCategoryModel.h"

@interface WikiCellLayout ()
{
    CGFloat _cellHeight;
}

@end

@implementation WikiCellLayout

+(instancetype)layoutWithWikiModel:(WikiCategoryModel *)wikiModel{
    WikiCellLayout *layout = [[WikiCellLayout alloc]init];
    if (layout) {
        layout.wikiModel = wikiModel;
    }
    return layout;
}

-(void)setWikiModel:(WikiCategoryModel *)wikiModel{
    _wikiModel = wikiModel;
    //初始化高度
    _cellHeight = 0;
    _cellHeight +=cellTopViewHeight;
    _cellHeight +=spaceWidth;
    
    NSInteger buttonCount = _wikiModel.pages.count;
    CGFloat buttonWidth = (kScreenWidth -4*spaceWidth)/2;
    CGFloat top = cellTopViewHeight +spaceWidth;
    NSMutableArray *mArr = [[NSMutableArray alloc]init];
    
    for (int i = 0; i <buttonCount; i++) {
        //行列
        NSInteger row = i/2;
        NSInteger col = i%2;
        CGFloat subButtonX = col *(buttonWidth +2*spaceWidth) +spaceWidth;
        CGFloat subButtonY = row *(cellButtonHeight + lineSpace) +top;
        CGRect frame = CGRectMake(subButtonX, subButtonY, buttonWidth, cellButtonHeight);
        [mArr addObject:[NSValue valueWithCGRect:frame]];
        if (i == buttonCount - 1) {
            _cellHeight +=(row *lineSpace +(row + 1) * cellButtonHeight);
        }
    }
    _buttonFrameArr = [mArr copy];
    
    _cellHeight += 2*spaceWidth;
}
//获取总高度
-(CGFloat)cellHeight{
    return _cellHeight;
}

//-(void)layoutButtonsWithButtonCount:(NSInteger)buttonCount
//                                   top:(CGFloat)top{
//    
//}

@end
