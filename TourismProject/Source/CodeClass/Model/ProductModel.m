//
//  ProductModel.m
//  TourismApp
//
//  Created by lanou3g on 16/1/19.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "ProductModel.h"

@implementation ProductModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
}
+(instancetype)initWithDictionary:(NSDictionary *)dict{
    ProductModel * model = [ProductModel new];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
