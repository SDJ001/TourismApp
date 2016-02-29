//
//  travelNoteModel.m
//  TourismApp
//
//  Created by lanou3g on 16/1/16.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "travelNoteModel.h"

@implementation travelNoteModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _d_Id = value;
    }else if ([key isEqualToString:@"default"]){
        _d_Default = value;
    }else if ([key isEqualToString:@"description"]){
        _d_Description = value;
    }
}
+(instancetype)initWithDictionary:(NSDictionary * )dict{
    travelNoteModel * model = [travelNoteModel new];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
