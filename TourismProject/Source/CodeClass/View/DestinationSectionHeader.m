//
//  DestinationSectionHeader.m
//  TourismApp
//
//  Created by ShenDeju on 16/1/20.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "DestinationSectionHeader.h"

@implementation DestinationSectionHeader
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self drawView];
    }
    return self;
}

-(void) drawView
{
    [self addSubview:self.imgView1];
    [self addSubview:self.destinationLabel];
    [self addSubview:self.allButton];
}

-(UIImageView *) imgView1
{
    if (!_imgView1) {
        _imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 10, self.frame.size.height-10)];
        _imgView1.backgroundColor = [UIColor cyanColor];
    }
    return _imgView1;
}

-(UILabel *) destinationLabel
{
    if (!_destinationLabel) {
        _destinationLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imgView1.frame)+10, 5, 200, self.frame.size.height-10)];
        _destinationLabel.backgroundColor = [UIColor clearColor];
        _destinationLabel.text = @"测试数据1";
    }
    return _destinationLabel;
}

-(UIButton *) allButton
{
    if (!_allButton) {
        _allButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 60, 5, 60,self.frame.size.height-10)];
        [_allButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_allButton setTitle:@"全部 〉" forState:UIControlStateNormal];
    }
    return  _allButton;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
