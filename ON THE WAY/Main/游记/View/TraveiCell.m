//
//  TraveiCell.m
//  ON THE WAY
//
//  Created by Apple on 16/10/24.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import "TraveiCell.h"
#import "UIImageView+WebCache.h"
#import "ContentModel.h"
@implementation TraveiCell
- (void)setModel:(TravelModel *)model {
    if (_model!= model) {
        _model = model;
    }
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:_model.activity.user.photo_url]];
    _userName.text =  _model.activity.user.name;
    if (!model.user) {
        _userCommand.hidden = YES;
    }else{
        _userCommand.text = [NSString stringWithFormat:@"由%@推荐",_model.user.name];
        _userCommand.hidden = NO;
    }
    
    _imageViewArr = [[NSMutableArray alloc]init];
    NSDictionary *dic = _model.activity.contents[0];
    NSString *str = dic[@"photo_url"];
    [_imageViewBig sd_setImageWithURL:[NSURL URLWithString:str]];
    [_imageViewArr addObject:_imageViewBig];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewTapAction:)];
    _imageViewBig.userInteractionEnabled = YES;
    [_imageViewBig addGestureRecognizer:tap];
    
    //滑动视图
    self.scrolView.contentSize = CGSizeMake(152 * (_model.activity.contents.count - 1)-2, kScrollViewHeight);
    self.scrolView.frame = CGRectMake(0, 250, kScreenWidth, kScrollViewHeight);
    for (int i = 0; i<_model.activity.contents.count - 1; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*152, 0, 150, kScrollViewHeight)];
        NSDictionary *contentDic = _model.activity.contents[i+1];
        NSString *imageUrl = contentDic[@"photo_url"];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
        [self.scrolView addSubview:imageView];
        [_imageViewArr addObject:imageView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewTapAction:)];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:tap];
    }
    //标题标签
    NSString *topic = _model.activity.topic;
    CGSize maxSize = CGSizeMake(kScreenWidth - 20, 9000);
    CGRect topicRect = [topic boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:nil];
    self.topicLabel.frame = CGRectMake(10, CGRectGetMaxY(_scrolView.frame)+10, kScreenWidth - 20, topicRect.size.height);
    self.topicLabel.text = topic;
    //详情标签
    NSString *des = _model.activity.des;
    CGRect desRect = [des boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    self.descriptionLabel.frame = CGRectMake(10, CGRectGetMaxY(_topicLabel.frame)+5, kScreenWidth - 20, desRect.size.height);
    self.descriptionLabel.text = des;
    //分割线视图
    self.lineImageView.frame = CGRectMake(0, CGRectGetMaxY(_descriptionLabel.frame)+10, kScreenWidth, 10);
}
#pragma mark - 覆写get方法，懒加载
- (UIScrollView *)scrolView {
    if (_scrolView == nil) {
        _scrolView = [[UIScrollView alloc]initWithFrame:CGRectZero];
        _scrolView.showsHorizontalScrollIndicator = NO;
        _scrolView.showsVerticalScrollIndicator = NO;
        [self.contentView addSubview:_scrolView];
    }
    
    return _scrolView;
}
- (UILabel *)topicLabel {
    if (_topicLabel == nil) {
        _topicLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _topicLabel.numberOfLines = 0;
        _topicLabel.font = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:_topicLabel];
    }
    return _topicLabel;
}
- (UILabel *)descriptionLabel {
    if (_descriptionLabel == nil) {
        _descriptionLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _descriptionLabel.numberOfLines = 0;
        _descriptionLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_descriptionLabel];
    }
    return _descriptionLabel;
}
-(UIImageView *)lineImageView {
    if (_lineImageView == nil) {
        _lineImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _lineImageView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_lineImageView];
    }
    return _lineImageView;
}
- (UIButton *)moreButton {
    if (_moreButton == nil) {
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreButton setTitle:@"...展开全文" forState:UIControlStateNormal];
        [_moreButton setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
        _moreButton.frame = CGRectZero;
        [self.contentView addSubview:_moreButton];
    }
    return _moreButton;
}
#pragma mark - 大图浏览
- (void)imageViewTapAction:(UIGestureRecognizer *)tap {
    UIImageView *imageView = (UIImageView *)tap.view;
    NSInteger imageIndex = [_imageViewArr indexOfObject:imageView];
    if (imageIndex == NSNotFound) {
        return;
    }
    [WXPhotoBrowser showImageInView:self.window selectImageIndex:imageIndex delegate:self];
}
//需要显示的图片个数
- (NSUInteger)numberOfPhotosInPhotoBrowser:(WXPhotoBrowser *)photoBrowser{
    return _model.activity.contents.count;
}
//返回需要显示的图片对应的Photo实例,通过Photo类指定大图的URL,以及原始的图片视图
- (WXPhoto *)photoBrowser:(WXPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    WXPhoto *photo = [[WXPhoto alloc]init];
    photo.srcImageView = _imageViewArr[index];
    NSDictionary *dic = _model.activity.contents[index];
    NSString *str = dic[@"photo_url"];
    photo.url = [NSURL URLWithString:str];
    return photo;
}
- (void)awakeFromNib {
    _iconImageView.layer.cornerRadius = 20;
    _iconImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
