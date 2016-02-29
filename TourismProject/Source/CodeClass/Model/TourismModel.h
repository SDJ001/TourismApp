//
//  TourismModel.h
//  TourismApp
//
//  Created by lanou3g on 16/1/19.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TourismModel : NSObject
+(instancetype)initWithDictionary:(NSDictionary * )dict;
@property (strong, nonatomic) NSString *recommended;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSString *photo_s;
@property (strong, nonatomic) NSString *province;
@property (strong, nonatomic) NSString *place;
@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSString *photo_1600;
@property (strong, nonatomic) NSString *photo_w640;
@property (strong, nonatomic) NSDictionary *photo_info;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *day;
@property (strong, nonatomic) NSString *poi;
@property (strong, nonatomic) NSString *cover;
@property (strong, nonatomic) NSString *track;
@property (strong, nonatomic) NSString *local_time;
@property (strong, nonatomic) NSString *shared;
@property (strong, nonatomic) NSString *photo_webtrip;
@property (strong, nonatomic) NSString *d_Id;
@property (strong, nonatomic) NSString *recommendations;
@property (strong, nonatomic) NSString *trip_id;
@property (strong, nonatomic) NSString *timezone;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *comments;
@property (strong, nonatomic) NSString *photo;
@property (strong, nonatomic) NSString *privacy;
@property (strong, nonatomic) NSString *photo_weblive;
@property (strong, nonatomic) NSString *hotel;
@property (strong, nonatomic) NSString *device;
@property (strong, nonatomic) NSString *date_added;
@property (strong, nonatomic) NSString *model;
@end
