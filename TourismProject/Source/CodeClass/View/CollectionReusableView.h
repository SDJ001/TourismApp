//
//  CollectionReusableView.h
//  TourismApp
//
//  Created by lanou3g on 16/1/20.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *decripLabel;

@end
