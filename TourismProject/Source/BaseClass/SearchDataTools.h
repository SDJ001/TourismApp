//
//  SearchDataTools.h
//  TourismApp
//
//  Created by ShenDeju on 16/1/22.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^PassSearchData) (NSMutableArray *dataArr);
typedef void (^PassSearchData2) (NSMutableArray *dataAr);
@interface SearchDataTools : NSObject
+(instancetype) sharePassSearchData;
-(void) getSearchDomainData:(PassSearchData) passDomainData;
-(void) getSearchOverseaData:(PassSearchData2)passOverseaData;@end
