//
//  DataBaseTool.h
//  TourismApp
//
//  Created by lanou3g on 16/1/15.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Block)(NSDictionary * dict,NSError * error);
@interface DataBaseTool : NSObject

+(instancetype)shareDataBaseTool;

-(void)getDataSourceByUrlString:(NSString*)urlString passData:(Block)blockData;


//故事详情页下载数据
-(void)getdataSourceBySpot_id:(NSNumber*)spot_id passData:(Block)blockData;
//全部故事页面加载更多数据
-(void)getdataSourceByStartIndex:(NSInteger)index passData:(Block)blockData;

//游记详情页数据
-(void)getdataSourceByTourism_id:(NSNumber*)Tourism_id passData:(Block)blockData;
//主页加载数据
-(void)getDataSourceByNestStart:(NSNumber *)nestStart passData:(Block)blockData;
//附近加载数据
-(void)getDtaWithCategory:(NSNumber*)category location:(CLLocation*)location passData:(Block)blockData;
//附近加载更多数据
-(void)getDtaWithCategory:(NSNumber*)category location:(CLLocation*)location dataIndex:(NSUInteger)dataIndex passData:(Block)blockData;

@end
