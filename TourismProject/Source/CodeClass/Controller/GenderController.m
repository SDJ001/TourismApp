
//
//  genderController.m
//  TourismProject
//
//  Created by 鲁东阳 on 16/1/25.
//  Copyright © 2016年 鲁东阳. All rights reserved.
//

#import "GenderController.h"

@interface GenderController ()
@property (nonatomic,strong)UILabel * lb;
@property (nonatomic,strong)UIButton * manlb;
@property (nonatomic,strong)UIButton * femalelb;


@end
static GenderController * VC  = nil;

@implementation GenderController
+(instancetype)share
{
    if (VC == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            VC = [[GenderController alloc] init];
        });
    }
    return VC;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-30, 180);
    self.lb = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 50, 40)];
    self.lb.text = @"性别";
    
    self.manlb = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.manlb setTitle:@"男" forState:(UIControlStateNormal)];
    
    
    self.manlb.backgroundColor = [UIColor whiteColor];
    self.manlb.frame = CGRectMake(CGRectGetMinX(self.lb.frame), CGRectGetMaxY(self.lb.frame)+2, self.view.bounds.size.width-20, 50);
    [self.manlb addTarget:self action:@selector(manlbAction:) forControlEvents:(UIControlEventTouchUpInside)];


    self.femalelb = [UIButton buttonWithType:(UIButtonTypeSystem)];
   
    self.femalelb.frame = CGRectMake(CGRectGetMinX(self.lb.frame), CGRectGetMaxY(self.manlb.frame)+30, CGRectGetWidth(self.manlb.frame), 50);
    
    [self.femalelb setTitle:@"女" forState:(UIControlStateNormal)];
    [self.femalelb addTarget:self action:@selector(femalelbAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.femalelb.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.manlb];
    [self.view addSubview:self.femalelb];
    [self.view addSubview:self.lb];
    self.view.layer.masksToBounds = YES;
    self.view.layer.cornerRadius = 10;
    
    
    self.view.backgroundColor = [UIColor cyanColor];
    
}





- (void)manlbAction:(UIButton *)sender{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(selectGender:)]) {
        [self.delegate selectGender:YES];
    }
  
}

- (void)femalelbAction:(UIButton *)sender {
    if (self.delegate &&[self.delegate respondsToSelector:@selector(selectGender:)]) {
        [self.delegate selectGender:NO];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass t
 
 
 
 he selected object to the new view controller.
}
*/

@end
