//
//  phonerRegisterController.m
//  TourismProject
//
//  Created by 鲁东阳 on 16/1/18.
//  Copyright © 2016年 鲁东阳. All rights reserved.
//

#import "phonerRegisterController.h"

@interface phonerRegisterController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;

@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *regetNumber;
@end

@implementation phonerRegisterController
- (IBAction)getNumber:(id)sender {
    
//    AVUser *user = [AVUser user];
//    user.username = self.userName.text;
//    [user setObject:self.phoneTextField.text forKey:@"phone"];
//    user.password =  self.passwordTF.text;
//    user.email = self.email.text;
//    user.mobilePhoneNumber = self.phoneTextField.text;
//    NSError *error = nil;
//    [user signUp:&error];
//    [AVUser verifyMobilePhone:@"123456" withBlock:^(BOOL succeeded, NSError *error) {
//        //验证结果
//    }];
    
    NSLog(@"111");
    
}
- (IBAction)getAction:(id)sender {
    AVUser *user = [AVUser user];
        user.username = self.userName.text;
        [user setObject:self.phoneTextField.text forKey:@"phone"];
        user.password =  self.passwordTF.text;
        user.email = self.email.text;
        user.mobilePhoneNumber = self.phoneTextField.text;
        NSError *error = nil;
        [user signUp:&error];
    NSLog(@"11");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)returnAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
