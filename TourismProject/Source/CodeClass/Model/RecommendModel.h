//
//  RecommendModel.h
//  TourismApp
//
//  Created by lanou3g on 16/1/15.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendModel : NSObject
@property (strong, nonatomic) NSString *cover_image_1600;
@property (strong, nonatomic) NSString *recommendations_count;
@property (strong, nonatomic) NSString *location_alias;
@property (strong, nonatomic) NSString *cover_image_s;
@property (strong, nonatomic) NSString *date_tour;
@property (strong, nonatomic) NSString *cover_image_height;
@property (strong, nonatomic) NSString *index_title;
@property (strong, nonatomic) NSString *is_hiding_location;
@property (strong, nonatomic) NSString *region;
@property (strong, nonatomic) NSString *comments_count;
@property (strong, nonatomic) NSString *is_liked;
@property (strong, nonatomic) NSString *poi;
@property (strong, nonatomic) NSString *share_url;
@property (strong, nonatomic) NSString *center_point;
@property (strong, nonatomic) NSDictionary *user;
@property (strong, nonatomic) NSNumber *spot_id;
@property (strong, nonatomic) NSString *cover_image_width;
@property (strong, nonatomic) NSString *trip_id;
@property (strong, nonatomic) NSString *timezone;
@property (strong, nonatomic) NSString *view_count;
@property (strong, nonatomic) NSString *is_author;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *index_cover;
@property (strong, nonatomic) NSString *cover_image_w640;
@property (strong, nonatomic) NSString *cover_image;

+(instancetype)initWithDictionary:(NSDictionary*)dict;
@end
