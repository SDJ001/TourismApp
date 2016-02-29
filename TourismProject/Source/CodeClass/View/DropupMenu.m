//
//  DropupMenu.m
//  TourismProject
//
//  Created by 鲁东阳 on 16/1/25.
//  Copyright © 2016年 鲁东阳. All rights reserved.
//

#import "DropupMenu.h"

@interface DropupMenu ()
@property (nonatomic,strong)UIImageView * contentView;
@end
static DropupMenu * dm =nil;
@implementation DropupMenu
-(UIImageView *)contentView
{
    if (!_contentView) {
        UIImageView *conimgView = [[UIImageView alloc] init];
        conimgView.backgroundColor = [UIColor redColor];
        conimgView.userInteractionEnabled = YES;
        [self addSubview:conimgView];
        self.contentView = conimgView;
      
    }
    return _contentView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}
+ (instancetype)menu
{
    if (dm == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            dm = [DropupMenu new];
        });
    }
    return dm;
    
}
- (void)setContent:(UIView *)content
{
   _content = content;
    content.x = 10;
    content.y = 15;
    _contentView.height = CGRectGetMaxY(content.frame) + 11;
    _contentView.width =  CGRectGetMaxX(content.frame) + 10;
    [_contentView addSubview:content];
    
}
-(void)setContentController:(UIViewController *)contentController
{
    
    _contentController = contentController;
    self.content = contentController.view;
    
}
//显示
-(void)showFrom:(UIView *)from
{
    UIWindow * window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    self.frame = window.bounds;
    CGRect newFrame = [from convertRect:from.bounds toView:window];
    //    CGRect newFrame = [from.superview convertRect:from.frame toView:window];
    self.contentView.centerX = CGRectGetMidX(newFrame);
    self.contentView.y = CGRectGetMaxY(newFrame);
    
}
-(void)dismiss{
    
    [self removeFromSuperview];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self dismiss];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
