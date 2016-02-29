//
//  DataBaseTool.m
//  TourismApp
//
//  Created by lanou3g on 16/1/15.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "DataBaseTool.h"
@interface DataBaseTool()
@property(nonatomic,strong)NSMutableArray *dataArray;
@end
@implementation DataBaseTool

+ (instancetype)shareDataBaseTool{
    static DataBaseTool * tool = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!tool) {
            tool = [[DataBaseTool alloc]init];
           
            [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
               
            }];
            [[AFNetworkReachabilityManager sharedManager]startMonitoring];
        }
    });return tool;
}

//主页数据
- (void)getDataSourceByUrlString:(NSString *)urlString passData:(Block)blockData{
   
    NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager * manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];
    NSURL * url = [NSURL URLWithString:urlString];

    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask * dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        blockData(responseObject,error);
    }];
    [dataTask resume];
}
//主页加载数据
- (void)getDataSourceByNestStart:(NSNumber *)nestStart passData:(Block)blockData{
    
    NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager * manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.breadtrip.com/v2/index/?next_start=%@",nestStart]];

    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask * dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
      
            blockData(responseObject,error);
 
    }];
    [dataTask resume];
}

//全部故事页面加载更多数据
- (void)getdataSourceByStartIndex:(NSInteger)index passData:(Block)blockData{
    
    NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager * manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.breadtrip.com/v2/new_trip/spot/hot/list/?start=%ld",(index*12)]];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask * dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
       
            blockData(responseObject,error);
            
     
    }];
    [dataTask resume];
    
    
    
    
}

//故事详情页数据
- (void)getdataSourceBySpot_id:(NSNumber*)spot_id passData:(Block)blockData{
    NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager * manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.breadtrip.com/v2/new_trip/spot/?spot_id=2387659900&spot_id=%@",spot_id]];

    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask * dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
     
            blockData(responseObject,error);
        
    }];
    [dataTask resume];
}
// !!!:游记详情页
- (void)getdataSourceByTourism_id:(NSNumber*)Tourism_id passData:(Block)blockData{
    NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager * manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.breadtrip.com/trips/%@/waypoints/",Tourism_id]];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];

    NSURLSessionDataTask * dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
      
            blockData(responseObject,error);
 
    }];
    [dataTask resume];
}
//附近数据
- (void)getDtaWithCategory:(NSNumber*)category location:(CLLocation*)location passData:(Block)blockData{
    NSLog(@"=====11======%@",category);
    NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager * manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.breadtrip.com/place/pois/nearby/?category=%@&start=0&count=20&latitude=%lf&longitude=%lf",category,location.coordinate.latitude,location.coordinate.longitude]];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    NSLog(@"%@",url);
    NSURLSessionDataTask * dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
       
            blockData(responseObject,error);
      
    }];
    [dataTask resume];
    
}
//附近加载更多数据

- (void)getDtaWithCategory:(NSNumber*)category location:(CLLocation*)location dataIndex:(NSUInteger)dataIndex passData:(Block)blockData{
  
    NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager * manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.breadtrip.com/place/pois/nearby/?category=%@&start=%ld&count=20&latitude=%lf&longitude=%lf",category,dataIndex*20,location.coordinate.latitude,location.coordinate.longitude]];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];

    NSURLSessionDataTask * dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
       
            blockData(responseObject,error);
    
    }];
    [dataTask resume];
    
}


@end
