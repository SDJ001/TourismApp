//
//  getDestinationTools.m
//  TourismApp
//
//  Created by ShenDeju on 16/1/20.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "getDestinationTools.h"

@implementation getDestinationTools
+(instancetype) shareGetDestinationTools
{
    static getDestinationTools *getDT = nil;
    if (getDT == nil) {
        static dispatch_once_t token;
        dispatch_once(&token, ^{
             getDT = [[getDestinationTools alloc] init];
        });
    }
    return getDT;
}

-(void)getBannerData:(PassValue)passBanner
{
     dispatch_queue_t global = dispatch_get_global_queue(0, 0);
     dispatch_async(global, ^{
         NSMutableArray *tempArr = [NSMutableArray array];
         NSURLSessionConfiguration *configuratioin = [NSURLSessionConfiguration defaultSessionConfiguration];
         AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuratioin];
         NSURL *url =[NSURL URLWithString:destinationUrl];
         NSURLRequest *request = [NSURLRequest requestWithURL:url];
         NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
             if (error) {
                 NSLog(@"数据解析错误error:%@",error);
                 passBanner(nil,NO);
             }else{
                 for (NSDictionary *dict in responseObject[@"banners"]) {
                     scorllDataModel *model = [scorllDataModel initWithDictionary:dict];
                     [tempArr addObject:model];
                 }
                 passBanner(tempArr, YES);
             }
         }];
         [dataTask resume];
     });
}

-(void) getSectionData:(PassElement)passElement
{
    dispatch_queue_t global = dispatch_get_global_queue(0, 0);
    dispatch_async(global, ^{
        
        NSMutableArray *tempArr = [NSMutableArray array];
        NSURLSessionConfiguration *configuratioin = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuratioin];
        NSURL *url =[NSURL URLWithString:destinationUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLSessionDataTask *dataTask1 = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            if (error) {
                NSLog(@"数据解析错误error:%@",error);
                passElement(nil,NO);
                
            }else{
                passElement(responseObject,YES);
            }
            
        }];
        [dataTask1 resume];
    });
                   
}
-(void) getWithUrl:(NSString *)urls DestAdd:(PassDestAdd)passDestAddress
{
    dispatch_queue_t global = dispatch_get_global_queue(0, 0);
    dispatch_async(global, ^{
        NSMutableDictionary *tempDict = [NSMutableDictionary dictionary];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        NSURL *url = [NSURL URLWithString:urls];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLSessionDataTask *dataTask2 = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            if (error) {
                NSLog(@"数据解析错误error:%@",error);
                passDestAddress(nil,NO);
            }else
            {
                [tempDict setObject:responseObject[@"name"] forKey:@"name"];
                [tempDict setObject:responseObject[@"wish_to_go_count" ] forKey:@"wish_to_go_count"];
                [tempDict setObject:responseObject[@"visited_count"] forKey:@"visited_count"];
                [tempDict setObject:responseObject[@"hottest_places"][0][@"photo"] forKey:@"photo"];
                passDestAddress(tempDict,YES);
            }
        }];
        [dataTask2 resume];
    });
}
-(void) getWithUrl:(NSString *)urlstr AllDest:(PassAllDest)passAllDest
{
//    dispatch_queue_t global = dispatch_get_global_queue(0, 0);
//    dispatch_async(global, ^{
        NSMutableArray *tempArr = [NSMutableArray array];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        NSURL *url = [NSURL URLWithString:urlstr];
    
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
        NSURLSessionDataTask *dataTask3 = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
              if (error) {
                NSLog(@"数据解析错误error:%@",error);
                passAllDest(nil,NO);
            }else
            {
                for (NSDictionary *dict in responseObject[@"items"]) {
                    NearByModel *dest = [NearByModel initWithDictionary:dict];
                    [tempArr addObject:dest];
                }
                NSLog(@"==================%@",responseObject);
                passAllDest(tempArr,YES);
            }
        }];
        [dataTask3 resume];
    
    
    
    
    
    
    
    
//    });
}


@end

