//
//  NearByModel.m
//  TourismApp
//
//  Created by lanou3g on 16/1/22.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "NearByModel.h"

@implementation NearByModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _d_ID = value;
    }if ([key isEqualToString:@"description"]) {
        _d_Description = value;
    }
}
+(instancetype)initWithDictionary:(NSDictionary*)dict{
    NearByModel * model = [[NearByModel alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@ %@", self.name,self.d_Description,self.d_ID];
}
@end
