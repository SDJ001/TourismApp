//
//  getMoreCityTools.m
//  TourismApp
//
//  Created by ShenDeju on 16/1/21.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "getMoreCityTools.h"

@implementation getMoreCityTools
+(instancetype) shareGetMoreCityTools
{
    static getMoreCityTools *getMCT = nil;
    if (getMCT == nil) {
        static dispatch_once_t token;
        dispatch_once(&token, ^{
            getMCT = [[getMoreCityTools alloc] init];
        });
    }
    return getMCT;
}

-(void) getMoreCityWithUrl:(NSString *) url Data:(PassCity) passCity
{
    NSMutableArray *tempArr = [NSMutableArray array];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURL *urlS = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlS];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            NSLog(@"数据解析错误:%@",error);
        }
        else
        {
            for (NSDictionary *dict in responseObject[@"data"]) {
                DestinationCityModel *model = [DestinationCityModel initWithDictionary:dict];
                [tempArr addObject:model];
            }
        }
        passCity(tempArr);
    }];
    [dataTask resume];
}
-(void) getAllCityWithUrl:(NSString *)url CityData:(PassAllCity)passCityData
{
    dispatch_queue_t global = dispatch_get_global_queue(0, 0);
    dispatch_async(global, ^{
        NSMutableArray *tempArr = [NSMutableArray array];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        NSURL *urls = [NSURL URLWithString:url];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:urls];
        NSURLSessionDataTask *dataTask1 = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            if (error) {
                NSLog(@"数据解析错误%@",error);
            }else
            {
                for (NSDictionary *dict in responseObject[@"items"]) {
                    NearByModel *model = [NearByModel initWithDictionary:dict];
                    [tempArr addObject:model];
                }
                passCityData(tempArr);
            }
        }];
        [dataTask1 resume];
    });
}
@end
