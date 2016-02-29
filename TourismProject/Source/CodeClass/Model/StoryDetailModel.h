//
//  StoryDetailModel.h
//  TourismApp
//
//  Created by lanou3g on 16/1/17.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoryDetailModel : NSObject
@property (strong, nonatomic) NSString *photo_1600;
@property (strong, nonatomic) NSString *photo_date_created;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *photo_w640;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSNumber *photo_width;
@property (strong, nonatomic) NSString *photo_s;
@property (strong, nonatomic) NSString *timezone;
@property (strong, nonatomic) NSNumber *photo_height;
@property (strong, nonatomic) NSNumber *detail_id;
@property (strong, nonatomic) NSString *photo;

+(instancetype)initWithDictionary:(NSDictionary *)dict;
@end
