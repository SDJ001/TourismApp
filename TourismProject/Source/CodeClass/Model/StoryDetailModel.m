//
//  StoryDetailModel.m
//  TourismApp
//
//  Created by lanou3g on 16/1/17.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "StoryDetailModel.h"

@implementation StoryDetailModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
+(instancetype)initWithDictionary:(NSDictionary *)dict{
    StoryDetailModel * model = [StoryDetailModel new];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
