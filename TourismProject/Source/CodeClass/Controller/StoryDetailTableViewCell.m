//
//  StoryDetailTableViewCell.m
//  TourismApp
//
//  Created by lanou3g on 16/1/25.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "StoryDetailTableViewCell.h"

@implementation StoryDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setModel:(StoryDetailModel *)model{
    
    _model = model;
    _descripLabel.text = model.text;
    [self.imgView yy_setImageWithURL:[NSURL URLWithString:model.photo] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat scale  = [self.model.photo_width floatValue]/[self.model.photo_height floatValue];
    
    if (!isnan(scale)) {
        self.imgView.frame = CGRectMake(kGap, 0, kWidth-2*kGap, (kWidth-2*kGap)/scale);
    }
    
    CGRect  rect = [self.model.text boundingRectWithSize:CGSizeMake(kWidth-2*kGap, 10000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    self.descripLabel.frame= CGRectMake(kGap, CGRectGetMaxY(self.imgView.frame), kWidth-2*kGap, rect.size.height);
    
}
@end
