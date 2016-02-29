//
//  tripModel.m
//  TourismApp
//
//  Created by ShenDeju on 16/1/26.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "tripModel.h"

@implementation tripModel
+(instancetype) initWithDictionary:(NSDictionary *) dict
{
    tripModel *model = [[tripModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.tid = [NSString stringWithFormat:@"%@",value];
    }
}
-(NSString *)description
{
    return [NSString stringWithFormat:@"%@",_name];
}
@end

