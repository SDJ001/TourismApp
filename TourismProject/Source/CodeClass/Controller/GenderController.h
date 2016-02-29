//
//  genderController.h
//  TourismProject
//
//  Created by 鲁东阳 on 16/1/25.
//  Copyright © 2016年 鲁东阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GenderController;


@protocol genderDelegate <NSObject>
- (void)selectGender:(BOOL)gender;
@end


typedef void(^passvalue)(NSString * string);
@interface GenderController : UIViewController

@property (nonatomic,weak)id<genderDelegate>delegate;
@property (nonatomic,strong)passvalue ps;

+ (instancetype)share;

@end
