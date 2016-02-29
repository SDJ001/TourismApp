
//
//  SetupTableViewController.m
//  TourismProject
//
//  Created by 鲁东阳 on 16/1/19.
//  Copyright © 2016年 鲁东阳. All rights reserved.
//


//设置页面

#import "SetupTableViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "ChangePasswordController.h"
@interface SetupTableViewController ()
@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,strong)NSMutableArray * daArray;

@end

@implementation SetupTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightAction:)];
    self.tableView.backgroundColor = [UIColor colorWithRed:235 green:235 blue:235 alpha:1];
    
    

    
//    self.tableView.backgroundColor = [UIColor clearColor];
    self.dataArray = @[@"更改头像",@"设置新密码",@"推送通知设置",@"清空缓存"].mutableCopy;
    self.daArray = @[@"关于我们",@"检查更新",@"意见反馈"].mutableCopy;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

    
    
}
//左button
- (void)leftAction:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//又button 注销账户
- (void)rightAction:(UIBarButtonItem *)sender{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要退出当前用户吗？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction * confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [AVUser logOut];
    }];
    
    [alertVC addAction:confirm];
    [alertVC addAction:cancel];
    
    
    
    [self presentViewController:alertVC animated:YES completion:nil];
    
    
    
    
    
    
    
}
//标题头宽度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 40;
    }else {
        return 20;
    }
    
}
//设置区头标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        return @"设置账户";
    }else {
        
        return nil;
    }
  
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return self.dataArray.count;
        
    }else {
        
        return self.daArray.count;
    }
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
     
     
     cell.backgroundColor = [UIColor clearColor];
     if (indexPath.section == 0) {
         cell.textLabel.text = self.dataArray[indexPath.row];
     }else if (indexPath.section ==1){
         
         cell.textLabel.text = self.daArray[indexPath.row];
         
     }
    return cell;
 }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            headPhotoController * headVC  = [[headPhotoController alloc] init];
            [self.navigationController pushViewController:headVC animated:YES];
        }else if(indexPath.section == 1){
            
            ChangePasswordController * changeVC = [[ChangePasswordController alloc] init];
            UINavigationController * changeNC = [[UINavigationController alloc] initWithRootViewController:changeVC];
            [self presentViewController:changeNC animated:YES completion:nil];
            
            
        }
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
