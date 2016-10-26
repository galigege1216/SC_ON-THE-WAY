//
//  BaseDestinationViewController+LoadData.m
//  ON THE WAY
//
//  Created by Apple on 16/10/21.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import "BaseDestinationViewController+LoadData.h"
#import "TopBGView.h"

#define kTopBGViewHeight 220
#define kBgImageViewHeight 180
#define kLabelHeight 20
#define kBottomLabelHeight 40

#define kHomeFootViewHeight 40
#define kHomeHeadViewHeight 30


@implementation BaseDestinationViewController (LoadData)



-(void)loadData:(NSString *)urlString{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功");
        NSDictionary *regionDic = (NSDictionary *)responseObject;
        self.data = [regionDic[@"data"] copy];
        self.sections = self.data[@"sections"];
        self.destination = [DestinationModel yy_modelWithJSON:self.data[@"destination"]];
        self.topBGView.destinationModel = self.destination;
        [self.naviBGimageView sd_setImageWithURL:self.destination.photo_url];
        [self.table reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"失败");
    }];
    
    
}




@end
