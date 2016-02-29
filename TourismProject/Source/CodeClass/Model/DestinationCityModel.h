//
//  DestinationCityModel.h
//  TourismApp
//
//  Created by ShenDeju on 16/1/20.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DestinationCityModel : NSObject
@property(strong,nonatomic) NSString *title;
@property(strong,nonatomic) NSString *more;
@property(strong,nonatomic) NSString *comments_count;
@property(strong,nonatomic) NSString *cover;
@property(strong,nonatomic) NSString *cover_route_map_cover;
@property(strong,nonatomic) NSString *cover_s;
@property(nonatomic) BOOL *has_experience;
@property(nonatomic) BOOL *has_route_maps;
@property(strong,nonatomic) NSString *icon;
@property(strong,nonatomic) NSString *Cid;
@property(strong,nonatomic) NSDictionary *location;
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSString *name_en;
@property(strong,nonatomic) NSString *name_orig;
@property(strong,nonatomic) NSString *name_zh;
@property(strong,nonatomic) NSString *rating;
@property(strong,nonatomic) NSString *rating_users;
@property(strong,nonatomic) NSString *slug_url;
@property(assign,nonatomic) NSInteger *type;
@property(strong,nonatomic) NSString *url;
@property(nonatomic) NSInteger *visited_count;
@property(assign,nonatomic) NSInteger *wish_to_go_count;

+(instancetype) initWithDictionary:(NSDictionary *) dict;


@end
