//
//  registerViewController.m
//  TourismProject
//
//  Created by 鲁东阳 on 16/1/18.
//  Copyright © 2016年 鲁东阳. All rights reserved.
//

#import "registerViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "AccountLoginViewController.h"
#import "SHEmailValidationTextField.h"
#import "SHEmailValidator.h"
@interface registerViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet SHEmailValidationTextField *EmailTextField;

@end

@implementation registerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userNameTextField.clearsOnBeginEditing = YES;
    self.userNameTextField.delegate = self;
    //    密码样式
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.delegate = self;
    
    //    email形式
    self.EmailTextField.keyboardType = UIKeyboardTypeEmailAddress;
    self.EmailTextField.delegate = self;
    
    
    self.EmailTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.EmailTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.EmailTextField.returnKeyType = UIReturnKeyNext;
    self.EmailTextField.autoresizingMask = (UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth);
//    self.EmailTextField.placeholder = @"";
    [self.EmailTextField setMessage:@"邮箱输入错误,请重新输入" forErrorCode:SHInvalidSyntaxError];

    
    
    
    
    
    
    
    
    
    
//    [self isvalidateEmail:self.EmailTextField.text];
    
    //    添加手势点击空白处回收键盘
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    
    [self.view addGestureRecognizer:tap];
}
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
    [self.EmailTextField hostWillAnimateRotationToInterfaceOrientation:interfaceOrientation];
}

//手势点击事件
- (void)tapAction:(UITapGestureRecognizer *)tap {
    
    [self.view endEditing:YES];
    
}

//注册按钮
- (IBAction)registerAction:(id)sender {
    AVUser *user = [AVUser user];
    user.username = self.userNameTextField.text;
    user.password =  self.passwordTextField.text;
    user.email = self.EmailTextField.text;
    //    [user setObject:@"186-1234-0000" forKey:@"phone"];
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"注册成功");
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"注册成功" message:@"是否登陆" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                
            }];
            
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                AccountLoginViewController * accountVC = [[AccountLoginViewController alloc] init];
                [self presentViewController:accountVC  animated:YES completion:nil];
                
            }];
            
            // Add the actions.
            [alertController addAction:cancelAction];
            [alertController addAction:otherAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
        } else {
            NSLog(@"注册失败");
            if (self.passwordTextField.text.length == 0) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注册失败" message:@"没有输入密码,请输入密码" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                [alert addAction:confirm];
                
                [self presentViewController:alert animated:YES completion:nil];
            }
            

                        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"注册失败" message:@"该用户名已存在或邮箱不匹配" preferredStyle:UIAlertControllerStyleAlert];
        
                        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
                        }];
        
                        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
                        }];
        
                        [alertVC addAction:cancel];
                        [alertVC addAction:confirm];
                        [self presentViewController:alertVC animated:YES completion:nil];
                    }
        
        
        
    }];
    
    
    
    
}



- (BOOL)isvalidateEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
    
}


//取消
- (IBAction)cancelAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



//回收键盘代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.userNameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.EmailTextField resignFirstResponder];
    
    return YES;
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
