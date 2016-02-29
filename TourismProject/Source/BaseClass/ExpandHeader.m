//
//  ExpandHeader.m
//  TourismProject
//
//  Created by ShenDeju on 16/1/29.
//  Copyright © 2016年 鲁东阳. All rights reserved.
//

#import "ExpandHeader.h"
#define ExpandContentOffset @"contentOffset"
@interface ExpandHeader ()
//scrollView或者子类
@property(strong,nonatomic) UIScrollView *scrollView;
//背景可以伸展的View
@property(strong,nonatomic) UIView *expandView;
@property(assign,nonatomic) CGFloat expandHeight;
@end

@implementation ExpandHeader
-(void) dealloc
{
    if (_scrollView) {
        [_scrollView removeObserver:self forKeyPath:ExpandContentOffset];
        _scrollView = nil;
    }
    _scrollView = nil;
}

+(id) expandWithScrollView:(UIScrollView *)scrollView expandView:(UIView *)expandView
{
    ExpandHeader *expandHeader = [ExpandHeader new];
    [expandHeader expandWithScrollView:scrollView expandView:expandView];
    return expandHeader;
}

-(void) expandWithScrollView:(UIScrollView *)scrollView expandView:(UIView *)expandView
{
    _expandHeight = CGRectGetHeight(expandView.frame);
    _scrollView = scrollView;
    _scrollView.contentInset = UIEdgeInsetsMake(_expandHeight, 0, 0, 0);
    [_scrollView insertSubview:expandView aboveSubview:0];
    [_scrollView addObserver:self forKeyPath:ExpandContentOffset options:NSKeyValueObservingOptionNew context:nil];
    [_scrollView setContentOffset:CGPointMake(0, -180)];
    _expandView = expandView;
    //使view可以伸展效果 重要属性
    _expandView.contentMode = UIViewContentModeScaleAspectFill;
    _expandView.clipsToBounds = YES;
    [self reSizeView];
}

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (![keyPath isEqualToString:ExpandContentOffset]) {
        return ;
    }
    [self scrollViewDidScroll:_scrollView];
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < _expandHeight *-1) {
        CGRect currentFrame = _expandView.frame;
        currentFrame.origin.y = offsetY ;
        currentFrame.size.height = -1*offsetY;
        _expandView.frame = currentFrame;
    }
}

-(void) reSizeView
{
  //充值_expandView位置
    [_expandView setFrame:CGRectMake(0, -1*_expandHeight, CGRectGetWidth(_expandView.frame), _expandHeight)];
    
}













@end
