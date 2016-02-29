//
//  ElementModel.h
//  TourismApp
//
//  Created by ShenDeju on 16/1/20.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ElementModel : NSObject
@property(strong,nonatomic) NSArray  *data;
@property(strong,nonatomic) NSString  * title;
@property(assign,nonatomic) NSInteger index;
@property(nonatomic) BOOL  more;

+(instancetype)initWithDictionary:(NSDictionary*)dict;
@end
