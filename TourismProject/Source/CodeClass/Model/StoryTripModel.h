//
//  StoryTripModel.h
//  TourismApp
//
//  Created by lanou3g on 16/1/20.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoryTripModel : NSObject
@property (strong, nonatomic) NSString *date_added;
@property (strong, nonatomic) NSString *d_id;
@property (strong, nonatomic) NSString *version;
@property (strong, nonatomic) NSString* cover_image_w640 ;
@property (strong, nonatomic) NSString *cover_image_s;
@property (strong, nonatomic) NSString *d_default;
@property (strong, nonatomic) NSString *wifi_sync;
@property (strong, nonatomic) NSString *cover_image_1600;
@property (strong, nonatomic) NSString *cover_image;
@property (strong, nonatomic) NSString *is_author;
@property (strong, nonatomic) NSString *start_point;
@property (strong, nonatomic) NSString *share_url;
@property (strong, nonatomic) NSString *privacy;
@property (strong, nonatomic) NSString *timezone;
@property (strong, nonatomic) NSDictionary *user;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *day_count;
@property (strong, nonatomic) NSString *text;
+(instancetype)initWithDictionary:(NSDictionary *)dict;
@end
