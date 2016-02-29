//
//  carouselModel.m
//  TourismApp
//
//  Created by lanou3g on 16/1/16.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "carouselModel.h"

@implementation carouselModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

}
+(instancetype)initWithDictionary:(NSDictionary * )dict{
    carouselModel * model = [carouselModel new];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
