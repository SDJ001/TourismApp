//
//  scorllDataModel.m
//  TourismApp
//
//  Created by ShenDeju on 16/1/20.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "scorllDataModel.h"

@implementation scorllDataModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%@",key);
}
+(instancetype)initWithDictionary:(NSDictionary*)dict{
    scorllDataModel * model = [scorllDataModel new];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
