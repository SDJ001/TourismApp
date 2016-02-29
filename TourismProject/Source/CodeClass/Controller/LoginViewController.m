//
//  LoginViewController.m
//  TourismProject
//
//  Created by 鲁东阳 on 16/1/16.
//  Copyright © 2016年 鲁东阳. All rights reserved.
//

#import "LoginViewController.h"
#import "PhoneViewController.h"
#import "registerViewController.h"
#import "AccountLoginViewController.h"
#import "regetController.h"
#import "phonerRegisterController.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *returnbutton;

@end

@implementation LoginViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.returnbutton setImage:[UIImage imageNamed:@"iconfont-chacha.png"] forState:(UIControlStateNormal)];
    [self.returnbutton setImage:[UIImage imageNamed:@"iconfont-chacha-2.png"] forState:(UIControlStateSelected)];
    
    
}

//返回按钮

- (IBAction)returnAction:(id)sender {
    

    self.callback();
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
//微信登录
- (IBAction)weChar:(id)sender {
    
    
    

    
}

//新浪

- (IBAction)sinaLogin:(id)sender {
    
    [AVOSCloudSNS setupPlatform:AVOSCloudSNSSinaWeibo withAppKey:@"3596147721" andAppSecret:@"8d37b836375982fcce269c94b1d08a0e" andRedirectURI:@"http://weibo.com"];
//    [AVOSCloudSNS setupPlatform:AVOSCloudSNSSinaWeibo withAppKey:@"2396032573" andAppSecret:@"2d35c353927b14ba88507360e2c6af04" andRedirectURI:@"http://weibo.com"];
    [AVOSCloudSNS loginWithCallback:^(id object, NSError *error) {
        if (error) {
        } else {
            NSString *accessToken = object[@"access_token"];
            NSString *username = object[@"username"];
            NSString *avatar = object[@"avatar"];
            NSDictionary *rawUser = object[@"raw-user"]; // 性别等第三方平台返回的用户信息
            NSLog(@"登陆成功",username);
            [AVUser loginWithAuthData:object platform:AVOSCloudSNSPlatformWeiBo block:^(AVUser *user, NSError *error) {
                if (error) {
                    // 登录失败，可能为网络问题或 authData 无效
                } else {
                    NSLog(@"成功");
                    
                }
            }];
            //...
        }
    } toPlatform:AVOSCloudSNSSinaWeibo];
    
}




//qq登录
- (IBAction)QQLogin:(id)sender {
    
//    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
//    
//    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
//        
//        //          获取微博用户名、uid、token等
//        
//        if (response.responseCode == UMSResponseCodeSuccess) {
//            
//            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
//            
//            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
//            
//        }});
//    [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToQQ  completion:^(UMSocialResponseEntity *response){
//        NSLog(@"SnsInformation is %@",response.data);
//        
//        
//
//      
//        
//    }];
    
    
    [AVOSCloudSNS setupPlatform:AVOSCloudSNSQQ withAppKey:@"1105117832" andAppSecret:@"UrUzDhtnHEYQS6Kd" andRedirectURI:@"http://qq.com"];
    
    [AVOSCloudSNS loginWithCallback:^(id object, NSError *error) {
        if (error) {
        } else {
            NSString *accessToken = object[@"access_token"];
            NSString *username = object[@"username"];
            NSString *avatar = object[@"avatar"];
            NSDictionary *rawUser = object[@"raw-user"]; // 性别等第三方平台返回的用户信息
            //...
            [AVUser loginWithAuthData:object platform:AVOSCloudSNSPlatformQQ block:^(AVUser *user, NSError *error) {
                if (error) {
                    // 登录失败，可能为网络问题或 authData 无效
                } else {
                    NSLog(@"成功");
                    
                }
            }];
            
            
        }
    } toPlatform:AVOSCloudSNSQQ];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
//更多社交平台登录
- (IBAction)moreLogin:(id)sender {
    
    
}
//通过手机号码登录
- (IBAction)phoneNumberLogin:(id)sender {
    
    PhoneViewController * phoneVC = [[PhoneViewController alloc] init];
    
    [self presentViewController:phoneVC animated:YES completion:nil];
    
    
    
    
    
}

//忘记密码
- (IBAction)forgetPassword:(id)sender {
    
    regetController * regetVC = [[regetController alloc] init];
    
    
    [self presentViewController:regetVC animated:YES completion:nil];
    
    
    
}

//账号登陆
- (IBAction)AccountLogin:(id)sender {
    
    
    AccountLoginViewController * accountVC = [[AccountLoginViewController alloc] init];
    [self presentViewController:accountVC animated:YES completion:nil];
    
    
    
}




//注册账号

- (IBAction)register:(id)sender {
    
    
    registerViewController * registerVC = [[registerViewController alloc] init];
    [self presentViewController:registerVC animated:YES completion:nil];
    
    
    
    
}

//手机号注册

- (IBAction)phoneNumberRegister:(id)sender {
    
    phonerRegisterController * registerVC =[[phonerRegisterController alloc] init];
    [self presentViewController:registerVC animated:YES completion:nil];
    
    
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
