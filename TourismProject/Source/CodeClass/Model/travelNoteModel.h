//
//  travelNoteModel.h
//  TourismApp
//
//  Created by lanou3g on 16/1/16.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface travelNoteModel : NSObject
@property (strong, nonatomic) NSString *title;
//@property (strong, nonatomic) NSString *cover_mask;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *cover;
@property (strong, nonatomic) NSString *sub_title;
@property (strong, nonatomic) NSNumber *day_count;
@property (strong, nonatomic) NSString *device;
@property (strong, nonatomic) NSString *summary;
@property (strong, nonatomic) NSString *spot_count;
@property (strong, nonatomic) NSString *cover_image;
@property (strong, nonatomic) NSString *cover_image_w640;
@property (strong, nonatomic) NSString *start_point;
@property (strong, nonatomic) NSString *is_hot_trip;
@property (strong, nonatomic) NSString *first_day;
@property (strong, nonatomic) NSString *version;
@property (strong, nonatomic) NSString *privacy;

@property (strong, nonatomic) NSString *date_complete;
@property (strong, nonatomic) NSString *waypoints;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *wifi_sync;
@property (strong, nonatomic) NSString *last_day;
@property (strong, nonatomic) NSString *share_url;
@property (strong, nonatomic) NSString *cover_image_default;
@property (strong, nonatomic) NSString *index_title;
@property (strong, nonatomic) NSNumber *view_count;
@property (strong, nonatomic) NSString *date_added;
@property (strong, nonatomic) NSString *comment_count;
@property (strong, nonatomic) NSString *popular_place_str;
@property (strong, nonatomic) NSString *recommendations;
@property (strong, nonatomic) NSDictionary *user;
@property (strong, nonatomic) NSString *is_featured_trip;
@property (strong, nonatomic) NSString *last_modified;
@property (strong, nonatomic) NSString *recommended;
@property (strong, nonatomic) NSString *cover_image_1600;
@property (strong, nonatomic) NSString *mileage;
@property (strong, nonatomic) NSString *d_Description;
@property (strong, nonatomic) NSNumber *d_Id;
@property (strong, nonatomic) NSString *d_Default;

+(instancetype)initWithDictionary:(NSDictionary * )dict;
@end
