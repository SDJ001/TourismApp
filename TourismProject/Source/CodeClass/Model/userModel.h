//
//  userModel.h
//  TourismApp
//
//  Created by ShenDeju on 16/1/26.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface userModel : NSObject
@property(strong,nonatomic) NSString *cover;
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSString *bio;
@property(strong,nonatomic) NSString *avatar_m;

+(instancetype) initWithDictionary:(NSDictionary *) dict;
@end
