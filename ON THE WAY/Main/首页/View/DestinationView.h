//
//  DestinationView.h
//  ON THE WAY
//
//  Created by Apple on 16/10/20.
//  Copyright © 2016年 qtw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DestinationModel;

@interface DestinationView : UIView

/*
 "destinations": [
 {
 "id": 109,
 "lat": 25.0454006195,
 "lng": 102.7099990845,
 "district_id": 100007,
 "parent_id": 5,
 "name": "云南",
 "name_en": "Yunnan",
 "name_pinyin": "yun nan|yn",
 "score": 1165,
 "level": 3,
 "path": ".1.5.109.",
 "published": true,
 "is_in_china": true,
 "inspiration_activities_count": 0,
 "activity_collections_count": 0,
 "wishes_count": 0,
 "wiki_destination_id": null,
 "photo_url": "http://inspiration.chanyouji.cn/Destination/109/2b85ab3d7ebda3c321436a6147153f09.jpg",
 "title": "",
 "description": "",
 "tip": "最新云南游玩指南，含徒步、租车自驾及美食购物等攻略",
 "time_cost": "",
 "wiki_page_id": null,
 "has_airport": false,
 "visit_tip": "",
 "is_top_destination": true,
 "is_in_grouping": false,
 "alias_name": null,
 "travel_tip": null,
 "photo": {
 "id": 66760,
 "width": 1192,
 "height": 1067,
 "url": "http://inspiration.chanyouji.cn/Destination/109/2b85ab3d7ebda3c321436a6147153f09.jpg",
 "file_size": 1088794,
 "photo_url": "http://inspiration.chanyouji.cn/Destination/109/2b85ab3d7ebda3c321436a6147153f09.jpg"
 */

//@property(nonatomic,copy)NSString *name;
//
//@property(nonatomic,copy)NSString *name_pinyin;
//
//@property(nonatomic,copy)NSString *photo_url;


@property(nonatomic,strong)UIImageView *bgImageView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *name_pinyinLabel;

@property(nonatomic,strong)DestinationModel *destinationModel;



//-(instancetype)initWithFrame:(CGRect)frame
//                 destination:(DestinationModel *)destination;


@end
