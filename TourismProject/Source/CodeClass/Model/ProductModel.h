//
//  ProductModel.h
//  TourismApp
//
//  Created by lanou3g on 16/1/19.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductModel : NSObject
@property (strong, nonatomic) NSString*cover_mask;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *cover;
@property (strong, nonatomic) NSString *sub_title;


+(instancetype)initWithDictionary:(NSDictionary *)dict;
@end
