//
//  LoginViewController.h
//  TourismProject
//
//  Created by 鲁东阳 on 16/1/16.
//  Copyright © 2016年 鲁东阳. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^passAction) ();
@interface LoginViewController : UIViewController
@property(nonatomic,copy)passAction callback;
@end