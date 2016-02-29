//
//  userModel.m
//  TourismApp
//
//  Created by ShenDeju on 16/1/26.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "userModel.h"

@implementation userModel
+(instancetype) initWithDictionary:(NSDictionary *) dict
{
    userModel *model = [[userModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@",_name];
}

@end

