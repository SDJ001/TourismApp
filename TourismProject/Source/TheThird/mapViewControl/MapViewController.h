//
//  MapViewController.h
//  项目高德导航
//
//  Created by lanou3g on 16/1/29.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^MapBlock)(CLLocation *location,AMapLocationReGeocode *regeocode,NSError * error);
@interface MapViewController : UIViewController
@property (nonatomic, strong) NSSet * dataSet;
@property (nonatomic, assign) double scale;
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapLocationManager * manager;

/**
 *  创建单例
 *
 *  @return
 */
+(instancetype)shareMapManagerControl;

// 规划路线,并开始导航
- (void)routeCalWithStartPoint:(AMapNaviPoint*)startPint AndEndPoint:(AMapNaviPoint*)endPoint;

/**
 *  开始定位,定位结束后将数据出传出去
 *
 *  @param CLLocationAccuracy 定位精度
 *  @param mapBlock           如果定位结束传出去的定位数据(逆地理信息)
 */
-(void)startLocationWithAccuracy:(CLLocationAccuracy)CLLocationAccuracy MapBlock:(MapBlock)mapBlock;
// !!!:添加标注
-(void)addAnnotations:(NSSet *)objects;
//清除地图信息
-(void)clearMapView;
@end
