//
//  DestinatioinCollectionViewCell.m
//  TourismApp
//
//  Created by ShenDeju on 16/1/20.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "DestinatioinCollectionViewCell.h"

@implementation DestinatioinCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self drawView];
    }
    return self;
}

-(void) drawView
{
    [self addSubview:self.imgView];
    [self addSubview:self.titleLabel];
    
}

-(UIImageView *)imgView
{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (kWidth-30)/2, (kWidth-30)/2)];
    }
    return _imgView;
}

-(UILabel *) titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.frame.size.height-30,self.frame.size.width-50,20)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.text = @"测试数据";
    }
    return _titleLabel;
}

@end

