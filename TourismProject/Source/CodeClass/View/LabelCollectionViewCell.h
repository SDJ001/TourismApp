//
//  LabelCollectionViewCell.h
//  TourismProject
//
//  Created by ShenDeju on 16/1/27.
//  Copyright © 2016年 鲁东阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabelCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *CityLabel;
@property(nonatomic,strong)NSString * str;
@end
