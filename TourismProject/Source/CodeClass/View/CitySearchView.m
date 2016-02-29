//
//  CitySearchView.m
//  TourismApp
//
//  Created by ShenDeju on 16/1/21.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "CitySearchView.h"

@interface CitySearchView () <UISearchBarDelegate>

@property(strong,nonatomic) UIScrollView *maskView;
//@property(assign,nonatomic) CGRect frame;
@end

@implementation CitySearchView
{
    CGRect _frame;
}
-(instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, kWidth, 44);
        _frame = self.frame;
        self.userInteractionEnabled = YES;
        [self addSubview:self.searchBar];
    }
    return self;
}

-(UISearchBar *) searchBar
{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width-80, 44)];
        _searchBar.delegate = self;
        _searchBar.backgroundColor = [UIColor redColor];
        _searchBar.placeholder = @"搜索目的地,游记,故事集,用户";
        [_searchBar setBackgroundColor:[UIColor clearColor]];
        _searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
        _searchBar.autocapitalizationType = UITextAutocorrectionTypeNo;
        [[[_searchBar.subviews objectAtIndex:0].subviews objectAtIndex:0] removeFromSuperview];
    }
    return _searchBar;
}
-(UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.backgroundColor = [UIColor greenColor];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    //[_cancelBtn addTarget:self action:@selector(HiddenMaskView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

-(UIView *)  maskView
{
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight-100)];
        _maskView.userInteractionEnabled = YES;
        _maskView.backgroundColor = [UIColor whiteColor];
    }
    return _maskView;
}

-(UITableView *) searchResultTableView
{
    if (!_searchResultTableView) {
        _searchResultTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kWidth, kHeight-100) style:UITableViewStylePlain];
        _searchResultTableView.delegate = _searchResultsDelegate;
        _searchResultTableView.dataSource = _searchResultsDataSource;
    }
    return _searchResultTableView;
}

-(void) setShowCancelButton:(BOOL)showCancelButton
{
    _showCancelButton = showCancelButton;
    if (_showCancelButton == YES) {
        _cancelBtn.frame = CGRectMake(self.frame.size.width-50, 0, 50, 44);
        _cancelBtn.backgroundColor = [UIColor brownColor];
        [self addSubview:_cancelBtn];
    }
    else{
        
    }
}
-(void) showMaskView
{
    [self.superview addSubview:[self maskView]];
    NSLog(@"_____________%@ %@",self.superview,self);
    _maskView.frame = CGRectMake(0, 44, kWidth, kHeight-100);
    [UIView animateWithDuration:.2 animations:^{
        self.frame = CGRectMake(0, 0, kWidth, 64);
        _cancelBtn.frame = CGRectMake(kWidth-50, 0, 50, 44);
        
        id object = [self nextResponder];
        while (![object isKindOfClass:[UIViewController class]] && object != nil) {
            object = [object nextResponder];
        }
        NSLog(@"~~~~~~%@",object);
                UIViewController *VC =(UIViewController*)object;
         VC.navigationController.navigationBarHidden = YES;
    } completion:^(BOOL finished) {
        
    }];
}

-(void) HiddenMaskView
{
    [UIView animateWithDuration:.2 animations:^{
        self.frame = _frame;
        [self setShowCancelButton:self.showCancelButton];
        
    } completion:^(BOOL finished) {
        [_searchBar resignFirstResponder];
        _searchBar.text = @"";
        [_maskView removeFromSuperview];
        [self.cancelBtn removeFromSuperview];
        [_searchResultTableView removeFromSuperview];
    }];
}

#pragma mark UISearchBarDelegate
-(BOOL) searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [self showMaskView];
    return YES;
}

-(void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (_delegate) {
        if (searchBar.text.length != 0) {
             [self setShowCancelButton:self.showCancelButton];
            [_maskView addSubview:[self searchResultTableView]];
            [_delegate searchBar:searchBar textDidChange:searchText];
        }
    }
}
@end
















