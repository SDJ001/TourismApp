//
//  URLHeader.h
//  ProjectMusic
//
//  Created by young on 15/7/31.
//  Copyright (c) 2015年 young. All rights reserved.
//  这里是URL信息

#ifndef Project_URLHeader_h
#define Project_URLHeader_h
#define kAllCategory @0
#define kScenic @11
#define kStay @10
#define kRestaurant @5
#define kLeisure @21
#define kShoping @6


#define kUrl @"http://api.breadtrip.com/v2/index/"//首页数据
#define kStroyUrl @"http://api.breadtrip.com/v2/new_trip/spot/hot/list/?start=0"//全部故事页面
#define kStoryDetailUrl @"http://api.breadtrip.com/v2/new_trip/spot/?spot_id=2387659900&spot_id=2387659900"

#define destinationUrl @"http://api.breadtrip.com/destination/v3/?last_modified=1450084799.625306"

//详情界面地址
#define kDetail @"http://api.breadtrip.com/destination/place/3/26772/"

//相机 图片地址
#define kPictureUrl @"http://api.breadtrip.com/destination/place/3/26772/photos/?start=0&count=21&gallery_mode=true"

//全部热门地址
#define kHotAddress @"http://api.breadtrip.com/destination/place/3/26772/pois/all/?start=0&count=20&sort=default&shift=false&latitude=40.029165185310625&longitude=116.33743947879032"
//住宿
#define kHotel @"http://api.breadtrip.com/destination/place/3/9990/pois/hotel/?start=0&count=20&sort=default&shift=false&latitude=40.02915618514533&longitude=116.33743247879028"
//餐厅
#define kRestaurants @"http://api.breadtrip.com/destination/place/3/9990/pois/restaurant/?start=0&count=20&sort=default&shift=false&latitude=40.02915618514533&longitude=116.33743247879028"
//休闲娱乐
#define kExperience @"http://api.breadtrip.com/destination/place/3/9990/pois/experience/?start=0&count=20&sort=default&shift=false&latitude=40.02915618514533&longitude=116.33743247879028"
//购物
#define kMall @"http://api.breadtrip.com/destination/place/3/9990/pois/mall/?start=0&count=20&sort=default&shift=false&latitude=40.02915618514533&longitude=116.33743247879028"
#endif
