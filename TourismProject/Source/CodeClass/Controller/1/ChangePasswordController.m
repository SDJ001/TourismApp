//
//  ChangePasswordController.m
//  TourismProject
//
//  Created by 鲁东阳 on 16/1/26.
//  Copyright © 2016年 鲁东阳. All rights reserved.
//

#import "ChangePasswordController.h"

@interface ChangePasswordController ()

@end

@implementation ChangePasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改密码";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightAction:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@""] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
    
    
    
}
- (void)rightAction:(UIBarButtonItem *)sender{
    
    
    
    
    
    
}
- (void)leftAction:(UIBarButtonItem *)sender{
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
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
    // Pass the selected object to the new view controller.
}
*/

@end
