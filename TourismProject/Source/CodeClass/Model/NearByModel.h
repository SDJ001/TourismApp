//
//  NearByModel.h
//  TourismApp
//
//  Created by lanou3g on 16/1/22.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NearByModel : NSObject
@property (strong, nonatomic) NSString *recommended;
@property (strong, nonatomic) NSString *rating_users;
@property (strong, nonatomic) NSString *website;
@property (strong, nonatomic) NSString *has_route_maps;
@property (strong, nonatomic) NSString *cover;
@property (strong, nonatomic) NSString *opening_time;

@property (strong, nonatomic) NSString *name_en;
@property (strong, nonatomic) NSString *distance;
@property (strong, nonatomic) NSString *comments_count;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *time_consuming_min;
@property (strong, nonatomic) NSString *arrival_type;
@property (strong, nonatomic) NSString *date_added;
@property (strong, nonatomic) NSString *province;
@property (strong, nonatomic) NSString *fee;
@property (strong, nonatomic) NSString *time_consuming;
@property (strong, nonatomic) NSString *extra1;
@property (strong, nonatomic) NSString *cover_s;
@property (strong, nonatomic) NSNumber *popularity;
@property (strong, nonatomic) NSString *has_experience;
@property (strong, nonatomic) NSString *slug_url;
@property (strong, nonatomic) NSString *is_nearby;
@property (strong, nonatomic) NSString *tips;
@property (strong, nonatomic) NSString *rating;
@property (strong, nonatomic) NSString *tips_count;
@property (strong, nonatomic) NSString *timezone;
@property (strong, nonatomic) NSString *verified;
@property (strong, nonatomic) NSString *icon;
@property (strong, nonatomic) NSString *time_consuming_max;
@property (strong, nonatomic) NSString *spot_region;
@property (strong, nonatomic) NSString *d_ID;
@property (strong, nonatomic) NSString *cover_route_map_cover;
@property (strong, nonatomic) NSString *currency;
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSString *recommended_reason;
@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSDictionary *location;
@property (strong, nonatomic) NSString *visited_count;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *wish_to_go_count;
@property (strong, nonatomic) NSString *tel;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *d_Description;
@property (nonatomic,assign)  float scale;
+(instancetype)initWithDictionary:(NSDictionary*)dict;

@end
