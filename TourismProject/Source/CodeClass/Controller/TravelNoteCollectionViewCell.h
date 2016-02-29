//
//  TravelNoteCollectionViewCell.h
//  TourismApp
//
//  Created by lanou3g on 16/1/16.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TravelNoteCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayCount;
@property (weak, nonatomic) IBOutlet UILabel *viewCount;
@property (weak, nonatomic) IBOutlet UILabel *popular_place_str;
@property (weak, nonatomic) IBOutlet UILabel *first_Day;
@property (weak, nonatomic) IBOutlet UIImageView *userImgView;
@property (weak, nonatomic) IBOutlet UILabel *userName;

@end
