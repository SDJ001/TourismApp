//
//  CountryAndAreaCode.h
//  TourismProject
//
//  Created by 鲁东阳 on 16/1/18.
//  Copyright © 2016年 鲁东阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountryAndAreaCode : NSObject

@property(nonatomic,copy) NSString* countryName;

/**
 * @brief 国家码
 */
@property(nonatomic,copy) NSString* areaCode;

/**
 * @brief 国家拼音名字
 */
@property(nonatomic,copy) NSString* pinyinName;
@end
