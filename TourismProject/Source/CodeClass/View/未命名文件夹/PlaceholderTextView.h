//
//  PlaceholderTextView.h
//  TourismProject
//
//  Created by 鲁东阳 on 16/1/29.
//  Copyright © 2016年 鲁东阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceholderTextView : UITextView
@property (nonatomic, strong) UILabel * placeHolderLabel;

@property (nonatomic, copy) NSString * placeholder;

@property (nonatomic, strong) UIColor * placeholderColor;

- (void)textChanged:(NSNotification * )notification;


@end
