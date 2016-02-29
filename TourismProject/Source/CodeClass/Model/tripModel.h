//
//  tripModel.h
//  TourismApp
//
//  Created by ShenDeju on 16/1/26.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface tripModel : NSObject
@property(strong,nonatomic) NSString *cover_image;
@property(strong,nonatomic) NSString *cover_image_1600;
@property(strong,nonatomic) NSString *cover_image_default;
@property(strong,nonatomic) NSString *cover_image_w640;
@property(strong,nonatomic) NSString *date_added;
@property(strong,nonatomic) NSString *date_complete;
@property(strong,nonatomic) NSNumber *day_count;
@property(strong,nonatomic) NSString *tid;
@property(strong,nonatomic) NSString *last_modified;
@property(strong,nonatomic) NSNumber *liked_count;
@property(strong,nonatomic) NSString *mileage;
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSString *privacy;
@property(strong,nonatomic) NSString *recommendations;
@property(strong,nonatomic) NSNumber *spot_count;
@property(strong,nonatomic) NSNumber *total_comments_count;
@property(strong,nonatomic) NSString *version;
@property(assign,nonatomic) NSNumber *view_count;
@property(strong,nonatomic) NSNumber *waypoints;

+(instancetype) initWithDictionary:(NSDictionary *) dict;
@end
