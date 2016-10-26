//
//  ImageCell.h
//  ON THE WAY
//
//  Created by Apple on 16/10/26.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image_View;
@property (nonatomic , strong)NSURL *imageUrl;
@end
