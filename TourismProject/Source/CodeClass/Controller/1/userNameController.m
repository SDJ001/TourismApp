//
//  userNameController.m
//  TourismProject
//
//  Created by 鲁东阳 on 16/1/26.
//  Copyright © 2016年 鲁东阳. All rights reserved.
//

#import "userNameController.h"

@interface userNameController ()
@property (weak, nonatomic) IBOutlet UITextField *nametextField;

@end

@implementation userNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改用户名";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(saveAction:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconfont-fanhui-2"] style:(UIBarButtonItemStylePlain) target:self action:@selector(returnAcion:)];
    
}

- (void)returnAcion:(UIBarButtonItem *)sender{
  
    [self dismissViewControllerAnimated:YES completion:nil];
}

//保存用户名
- (void)saveAction:(UIBarButtonItem *)sender{
    AVQuery *query = [AVQuery queryWithClassName:@"_User"];
    [query whereKey:@"username" equalTo:[AVUser currentUser].username];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // 检索成功
            NSLog(@"成功");
//            [AVUser currentUser].username = self.nametextField.text;
            
        } else {
            // 输出错误信息
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
    
    
    
    
//    NSData *data = [self.nametextField.text dataUsingEncoding:NSUTF8StringEncoding];
//    AVFile *file = [AVFile fileWithName:@"username" data:data];
//    [file saveInBackground];
//    
//    AVObject *saveName = [AVObject objectWithClassName:@"_User"];
//    [saveName setObject:[AVUser currentUser].username forKey:@"username"];
//    [saveName setObject:file  forKey:@"saveName"];
//    [saveName saveInBackground];
    
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
