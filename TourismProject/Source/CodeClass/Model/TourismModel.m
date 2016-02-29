//
//  TourismModel.m
//  TourismApp
//
//  Created by lanou3g on 16/1/19.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "TourismModel.h"

@implementation TourismModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _d_Id = value;
    }

}
+(instancetype)initWithDictionary:(NSDictionary * )dict{
    TourismModel * model = [TourismModel new];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
