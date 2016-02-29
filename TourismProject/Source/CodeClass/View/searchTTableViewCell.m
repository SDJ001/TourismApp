//
//  searchTTableViewCell.m
//  TourismApp
//
//  Created by ShenDeju on 16/1/26.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "searchTTableViewCell.h"

@implementation searchTTableViewCell

- (void)awakeFromNib {
    self.timgView.layer.cornerRadius = 10;
    self.timgView.layer.masksToBounds = YES;
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
