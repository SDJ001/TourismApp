//
//  getSearchData.m
//  TourismApp
//
//  Created by ShenDeju on 16/1/26.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "getSearchData.h"

@implementation getSearchData
+(instancetype) shareGetSearchData
{
    static getSearchData *getSD = nil;
    if (getSD == nil) {
        static dispatch_once_t token;
        dispatch_once(&token, ^{
            getSD = [[getSearchData alloc] init];
        });
    }
    return getSD;
}

-(void) getSearchDataWithUrl:(NSString *) url  Data:(PassSearchDict) passSearchDic
{
    NSMutableDictionary *AllData = [NSMutableDictionary dictionary];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURL *urlStr = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlStr];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            NSLog(@"数据解析错误error:%@",error);
        }
        else
        {
            [AllData addEntriesFromDictionary:responseObject[@"data"]];
            passSearchDic(responseObject);
        }
        
    }];
    [dataTask resume];
    
}


@end
