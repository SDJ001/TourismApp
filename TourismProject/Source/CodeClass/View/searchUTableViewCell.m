//
//  searchUTableViewCell.m
//  TourismApp
//
//  Created by ShenDeju on 16/1/26.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "searchUTableViewCell.h"

@implementation searchUTableViewCell

- (void)awakeFromNib {
    self.uimgView.layer.cornerRadius = self.uimgView.frame.size.width/2;
    self.uimgView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
