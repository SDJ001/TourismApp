//
//  scorllDataModel.h
//  TourismApp
//
//  Created by ShenDeju on 16/1/20.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface scorllDataModel : NSObject
@property(strong,nonatomic) NSString *html_url;
@property(strong,nonatomic) NSString *image_url;
@property(strong,nonatomic) NSString *platform;
+(instancetype)initWithDictionary:(NSDictionary*)dict;
@end
