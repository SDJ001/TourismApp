//
//  TourismTableViewCell.m
//  TourismApp
//
//  Created by lanou3g on 16/1/19.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "TourismTableViewCell.h"

@implementation TourismTableViewCell
-(void)setModel:(TourismModel *)model{
    _model = model;

  
    
   [self.imgView yy_setImageWithURL:[NSURL URLWithString:model.photo] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
    self.detailLabel.text = model.text;

}
- (void)awakeFromNib {

}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat scale= [_model.photo_info[@"h"]floatValue]/[self.model.photo_info[@"w"]floatValue];
    if (!isnan(scale)) {
        self.imgView.frame = CGRectMake(0, 0, kWidth-kGap, (kWidth-kGap)*scale);
    }
    CGRect  rect = [self.model.text boundingRectWithSize:CGSizeMake(kWidth-kGap, 10000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    self.detailLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imgView.frame)+5, kWidth-kGap, rect.size.height);
  
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
}
@end
