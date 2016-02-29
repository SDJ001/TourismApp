//
//  getDestinationTools.h
//  TourismApp
//
//  Created by ShenDeju on 16/1/20.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^PassValue) (NSMutableArray * dataArray, BOOL success);
typedef void (^PassElement) (NSMutableDictionary *dataDict,BOOL success);
typedef  void(^PassDestAdd) (NSMutableDictionary * dataDict, BOOL success);
typedef void (^PassAllDest) (NSMutableArray *allDestArr,BOOL sucess);
@interface getDestinationTools : NSObject
+(instancetype) shareGetDestinationTools;
-(void) getBannerData:(PassValue) passBanner;
-(void) getSectionData:(PassElement) passElement;
-(void) getWithUrl:(NSString *) urls DestAdd:(PassDestAdd) passDestAddress;
-(void) getWithUrl:(NSString *) urlstr AllDest:(PassAllDest) passAllDest;
@end
