//
//  RecommendModel.m
//  TourismApp
//
//  Created by lanou3g on 16/1/15.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "RecommendModel.h"

@implementation RecommendModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
 
}
+(instancetype)initWithDictionary:(NSDictionary*)dict{
    RecommendModel * model = [RecommendModel new];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
