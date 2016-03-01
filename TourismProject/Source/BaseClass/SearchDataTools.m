//
//  SearchDataTools.m
//  TourismApp
//
//  Created by ShenDeju on 16/1/22.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "SearchDataTools.h"

@implementation SearchDataTools
+(instancetype) sharePassSearchData
{
    static SearchDataTools *searchDT = nil;
    if (searchDT == nil) {
        static dispatch_once_t token;
        dispatch_once(&token, ^{
            searchDT = [[SearchDataTools alloc] init];
        });
    }
    return searchDT;
}

-(void) getSearchOverseaData:(PassSearchData2)passOverseaData
{
        NSMutableArray *tempAr = [NSMutableArray array];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager =[[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        NSURL *url = [NSURL URLWithString:destinationUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLSessionDataTask *dataTask1 = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            if (error ) {
                NSLog(@"数据解析错误,错误代码是%@",error);
            }
            else
            {
                for (NSDictionary *dict in responseObject[@"search_data"][1][@"elements"]) {
                    DestinationCityModel *model = [DestinationCityModel initWithDictionary:dict];
                    [tempAr addObject:model];
                }
                passOverseaData(tempAr);
            }
        }];
        [dataTask1 resume];
}


-(void)getSearchDomainData:(PassSearchData)passDomainData
{
        NSMutableArray *tempArr = [NSMutableArray array];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        NSURL *url = [NSURL URLWithString:destinationUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            if (error) {
                NSLog(@"数据解析错误%@",error);
            }
            else
            {
                for (NSDictionary *dict in responseObject[@"search_data"][0][@"elements"]) {
                    DestinationCityModel *model = [DestinationCityModel initWithDictionary:dict];
                    [tempArr addObject:model];
                }
                passDomainData(tempArr);
            }
        }];
        [dataTask resume];
}
@end
