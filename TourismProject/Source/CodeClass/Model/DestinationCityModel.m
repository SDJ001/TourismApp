//
//  DestinationCityModel.m
//  TourismApp
//
//  Created by ShenDeju on 16/1/20.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "DestinationCityModel.h"

@implementation DestinationCityModel
+(instancetype) initWithDictionary:(NSDictionary *) dict
{
    DestinationCityModel *model = [[DestinationCityModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}


-(NSString *)description
{
    return [NSString stringWithFormat:@"%@",_name];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.Cid =[NSString stringWithFormat:@"%@",value];
    }
}
@end
