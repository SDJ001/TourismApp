//
//  AccountLoginViewController.m
//  TourismProject
//
//  Created by 鲁东阳 on 16/1/19.
//  Copyright © 2016年 鲁东阳. All rights reserved.
//

#import "AccountLoginViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "LoginViewController.h"
#import "RootTabBarController.h"

@interface AccountLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwdTextField;

@end

@implementation AccountLoginViewController
-(void)viewDidAppear:(BOOL)animated
{
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
}

//立即登陆
- (IBAction)loginAction:(id)sender {
    
    [AVUser logInWithUsernameInBackground:self.userTextField.text password:self.passwdTextField.text block:^(AVUser *user, NSError *error) {
        if (user != nil) {
            NSLog(@"登陆成功");
             RootTabBarController * vc = [[RootTabBarController alloc] init];
            self.tabBarController.selectedIndex = 0;
            [self presentViewController:vc animated:YES completion:nil];
        } else {
            
        }
    }];

}
//返回
- (IBAction)return:(id)sender {
    
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
