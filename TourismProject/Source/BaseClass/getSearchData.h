//
//  getSearchData.h
//  TourismApp
//
//  Created by ShenDeju on 16/1/26.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^PassSearchDict) (NSMutableDictionary * dataDict);
@interface getSearchData : NSObject
+(instancetype) shareGetSearchData;
-(void) getSearchDataWithUrl:(NSString *) url  Data:(PassSearchDict) passSearchDic;

@end
