//
//  DateViewController.h
//  TourismProject
//
//  Created by 鲁东阳 on 16/1/27.
//  Copyright © 2016年 鲁东阳. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DateViewController;

@protocol DateDelegate <NSObject>

- (void)selectDate:(NSDate *)adate;


@end

@interface DateViewController : UIViewController

@property (nonatomic,strong)id<DateDelegate>delegate;



@end
