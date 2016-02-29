//
//  RecommendCollectionViewCell.h
//  TourismApp
//
//  Created by lanou3g on 16/1/15.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;

@end
