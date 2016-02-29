//
//  infoOneCell.m
//  TourismProject
//
//  Created by 鲁东阳 on 16/1/23.
//  Copyright © 2016年 鲁东阳. All rights reserved.
//

#import "infoOneCell.h"

@implementation infoOneCell

- (void)awakeFromNib {
    
    self.headImg.layer.masksToBounds = YES;
    self.headImg.layer.cornerRadius = 40;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
