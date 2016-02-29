//
//  NearbyMainViewController.h
//  TourismApp
//
//  Created by lanou3g on 16/1/23.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "WMPageController.h"

@interface NearbyMainViewController : WMPageController

+(instancetype)shareNerbyMainViewController;
-(void)startLocate;//定位动作(定位若成功,直接下载本页数据)
@end
