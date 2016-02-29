//
//  ElementModel.m
//  TourismApp
//
//  Created by ShenDeju on 16/1/20.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "ElementModel.h"

@implementation ElementModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"======%@",key);
}
-(NSString *)description
{
    return [NSString stringWithFormat:@"%@",_title];
}
+(instancetype)initWithDictionary:(NSDictionary*)dict{
    ElementModel * model =[ElementModel new];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
