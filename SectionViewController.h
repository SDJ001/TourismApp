//
//  SectionViewController.h
//  TourismProject
//
//  Created by 鲁东阳 on 16/1/17.
//  Copyright © 2016年 鲁东阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountryAndAreaCode.h"
@class SectionViewController;
@protocol SectionDelegate <NSObject>

- (void)setSecondData:(CountryAndAreaCode*)data;


@end


@interface SectionViewController : UIViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)UISearchBar * search;
@property (nonatomic,strong)NSMutableDictionary * names;
@property (nonatomic,strong)NSDictionary * allNames;

@property (nonatomic,strong)NSMutableArray * keys;
@property (nonatomic,assign)BOOL isSearching;
@property (weak,nonatomic)id<SectionDelegate>delegate;
@property (nonatomic,strong)UIToolbar * toolbar;

- (void)resetSearch;
- (void)setAreaArray:(NSMutableArray *)array;

- (void)handleSearchForTerm:(NSString *)searchTerm;



@end
