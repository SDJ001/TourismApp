//
//  placeModel.m
//  TourismApp
//
//  Created by ShenDeju on 16/1/26.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "placeModel.h"

@implementation placeModel
+(instancetype) initWithDictionary:(NSDictionary*) dict
{
    placeModel *model = [[placeModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.Pid = [NSString stringWithFormat:@"%@",value];
    }
}
-(NSString *)description
{
    return [NSString stringWithFormat:@"%@",_name];
}

@end
