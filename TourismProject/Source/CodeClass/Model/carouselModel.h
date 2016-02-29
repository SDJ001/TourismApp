//
//  carouselModel.h
//  TourismApp
//
//  Created by lanou3g on 16/1/16.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface carouselModel : NSObject
@property (strong, nonatomic) NSString * platform;
@property (strong, nonatomic) NSString * html_url;
@property (strong, nonatomic) NSString * image_url;
+(instancetype)initWithDictionary:(NSDictionary * )dict;
@end
