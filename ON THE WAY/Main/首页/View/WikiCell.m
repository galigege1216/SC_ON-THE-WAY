//
//  WikiCell.m
//  ON THE WAY
//
//  Created by Apple on 16/10/25.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import "WikiCell.h"
#import "WikiCategoryModel.h"
#import "WikiCellLayout.h"

@implementation WikiCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setWikiModel:(WikiCategoryModel *)wikiModel{
    _wikiModel = wikiModel;
    NSInteger index = [_wikiModel.category_type integerValue];
    //单元格title
    _titleLabel.text = _titleArr[index];
    _title_enLabel.text = _titlt_enArr[index];
    NSString *imageName = [NSString stringWithFormat:@"CategoryIcon%li@2x",index];
    _iconImageView.image = [UIImage imageNamed:imageName];
    //布局对象
    WikiCellLayout *layout = [WikiCellLayout layoutWithWikiModel:_wikiModel];
    //按钮布局
    for (int i = 0; i < _wikiModel.pages.count; i++) {
        UIButton *button = self.cellButtons[i];
        NSValue *val = layout.buttonFrameArr[i];
        button.frame = [val CGRectValue];
        NSDictionary *dic = _wikiModel.pages[i];
        [button setTitle:dic[@"title"] forState:UIControlStateNormal];
    }
    
    
}

//-(void)setTitleArr:(NSArray *)titleArr{
//    _titleArr = titleArr;
//}
//
//-(void)setTitlt_enArr:(NSArray *)titlt_enArr{
//    _titlt_enArr = titlt_enArr;
//}

//按钮初始化 以及tag 点击
-(NSArray *)cellButtons{
    if (_cellButtons == nil) {
        NSMutableArray *mArr = [[NSMutableArray alloc]init];
        for (int i = 0; i < 9; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectZero;
            button.backgroundColor = [UIColor greenColor];
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = i;
            [button setBackgroundColor:[UIColor grayColor]];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.contentView addSubview:button];
            [mArr addObject:button];
        }
        _cellButtons = [mArr copy];
    }
    return _cellButtons;
}

#pragma mark - 按钮点击操作
-(void)buttonAction:(UIButton *)button{
    
    NSLog(@"按钮%li被点击",button.tag);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
