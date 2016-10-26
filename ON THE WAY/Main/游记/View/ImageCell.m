//
//  ImageCell.m
//  ON THE WAY
//
//  Created by Apple on 16/10/26.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import "ImageCell.h"

@implementation ImageCell
- (void)setImageUrl:(NSURL *)imageUrl {
    if (_imageUrl != imageUrl) {
        _imageUrl = imageUrl;
    }
    [self.image_View sd_setImageWithURL:imageUrl];
}
- (void)awakeFromNib {
    // Initialization code
}

@end
