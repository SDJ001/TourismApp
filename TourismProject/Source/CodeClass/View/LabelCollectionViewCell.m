//
//  LabelCollectionViewCell.m
//  TourismProject
//
//  Created by ShenDeju on 16/1/27.
//  Copyright © 2016年 鲁东阳. All rights reserved.
//

#import "LabelCollectionViewCell.h"

@implementation LabelCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)layoutSubviews{
    
    self.CityLabel.frame = self.bounds;
    
}
@end
