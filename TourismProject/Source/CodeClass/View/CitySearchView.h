//
//  CitySearchView.h
//  TourismApp
//
//  Created by ShenDeju on 16/1/21.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CitySearchViewDelegate <NSObject>

-(void) searchBar:(nonnull UISearchBar *) searchBar textDidChange:(nonnull NSString *)searchText;

@end

@interface CitySearchView : UIView
@property(strong,nonatomic,nonnull) UISearchBar *searchBar;
@property(nonatomic) BOOL showCancelButton;
@property(strong,nonatomic,nonnull) UIButton *cancelBtn;
@property(nonatomic,strong,nonnull) UITableView *searchResultTableView;
@property(strong,nonatomic,nonnull) UIView * buttonView;
@property(strong,nonatomic,nonnull) id <UITableViewDataSource> searchResultsDataSource;
@property(strong,nonatomic,nonnull) id <UITableViewDelegate> searchResultsDelegate;
@property(strong,nonatomic,nonnull) id <CitySearchViewDelegate> delegate;


-(void) showMaskView;
@end
