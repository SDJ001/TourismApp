//
//  PhoneViewController.m
//  TourismProject
//
//  Created by 鲁东阳 on 16/1/16.
//  Copyright © 2016年 鲁东阳. All rights reserved.
//

#import "PhoneViewController.h"
#import "SectionViewController.h"
@interface PhoneViewController ()
//
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTF;
@property (weak, nonatomic) IBOutlet UITextField *PasswordTF;

@end

@implementation PhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

//返回页面

- (IBAction)return:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}
//找回密码

- (IBAction)retrievePassword:(id)sender {
    
    
    
}

- (IBAction)Login:(id)sender {
    
    
    
    
    
}
//国家和地区

- (IBAction)countryregion:(id)sender {

    SectionViewController * sectionVC = [[SectionViewController alloc] init];
    [self presentViewController:sectionVC animated:YES completion:nil];
    
    
    
    
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
