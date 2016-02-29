//
//  ExpandHeader.h
//  TourismProject
//
//  Created by ShenDeju on 16/1/29.
//  Copyright © 2016年 鲁东阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExpandHeader : NSObject <UIScrollViewDelegate>
//类方法
//生成一个CExpandHeader  ; expandView 可以伸展的北京view; return ExpandHeader对象
+(id) expandWithScrollView:(UIScrollView *) scrollView expandView:(UIView *) expandView;
//成员方法
-(void) expandWithScrollView:(UIScrollView *) scrollView expandView:(UIView *) expandView;
//监听scrollViewDidScroll方法
-(void) scrollViewDidScroll:(UIScrollView *)scrollView;


@end
