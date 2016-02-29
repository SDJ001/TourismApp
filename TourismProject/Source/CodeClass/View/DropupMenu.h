//
//  DropupMenu.h
//  TourismProject
//
//  Created by 鲁东阳 on 16/1/25.
//  Copyright © 2016年 鲁东阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropupMenu : UIView
+ (instancetype)menu;
//显示
- (void)showFrom:(UIView *)from;
//销毁
- (void)dismiss;
//内容
@property(nonatomic,strong)UIView * content;
//内容控制器
@property (nonatomic,strong)UIViewController * contentController;


@end
