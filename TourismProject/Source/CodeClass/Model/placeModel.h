//
//  placeModel.h
//  TourismApp
//
//  Created by ShenDeju on 16/1/26.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface placeModel : NSObject
@property(strong,nonatomic) NSDictionary *country;
@property(nonatomic) BOOL  has_experience;
@property(nonatomic) BOOL has_route_maps;
@property(strong,nonatomic) NSString *icon;
@property(strong,nonatomic) NSString *Pid;
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSDictionary *province;
@property(assign,nonatomic) NSInteger *type;
@property(strong,nonatomic) NSString *url;

+(instancetype) initWithDictionary:(NSDictionary*) dict;

@end
