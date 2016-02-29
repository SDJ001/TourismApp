//
//  regetController.m
//  TourismProject
//
//  Created by 鲁东阳 on 16/1/26.
//  Copyright © 2016年 鲁东阳. All rights reserved.
//

#import "regetController.h"

@interface regetController ()
@property (weak, nonatomic) IBOutlet UITextField *regetTextField;

@end

@implementation regetController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)returnAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)regetAction:(id)sender {
    [AVUser requestPasswordResetForEmailInBackground:self.regetTextField.text block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"已发送到邮箱" message:@"请到您的邮箱进行重置" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
            
        } else {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"您输入的邮箱不正确" message:@"请到您重新输入" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }
    }];
    
    
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
