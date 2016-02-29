//
//  StoryUserModel.m
//  TourismApp
//
//  Created by lanou3g on 16/1/20.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "StoryUserModel.h"

@implementation StoryUserModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

}
+(instancetype)initWithDictionary:(NSDictionary *)dict{
    StoryUserModel * model = [StoryUserModel new];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
