//
//  DestinationViewController.h
//  TourismApp
//
//  Created by ShenDeju on 16/1/20.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DestinationViewController : UIViewController
-(BOOL) searchBarShouldBeginEditing:(UISearchBar *)searchBar;
@property(strong,nonatomic) UIButton *nearbyButton;
@end
