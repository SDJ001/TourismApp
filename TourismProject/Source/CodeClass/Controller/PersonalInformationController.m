//
//  PersonalInformationController.m
//  TourismProject
//
//  Created by 鲁东阳 on 16/1/22.
//  Copyright © 2016年 鲁东阳. All rights reserved.
//

#import "PersonalInformationController.h"
#import "infoOneCell.h"
#import "infoTwoCell.h"
#import "headPhotoController.h"
#import "userNameController.h"
#import "DateViewController.h"
#import "PersonalInformationController.h"
#import "SignatureViewController.h"
#import "GenderController.h"
#import "UIViewController+MJPopupViewController.h"

@interface PersonalInformationController ()<genderDelegate,DateDelegate>
@property (nonatomic,strong)NSMutableArray * headArray;
@property (nonatomic,strong)NSMutableArray * nameArray;
@property (nonatomic,strong)NSMutableArray * numberArray;
@property (nonatomic,strong)NSMutableArray * infoArray;

@property (nonatomic, retain) NSIndexPath *selectedIndexPath;
@property (nonatomic,strong)GenderController * gVC;
@property (nonatomic,strong)DateViewController * dataVC;

@end

@implementation PersonalInformationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人信息";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"iconfont-fanhui-2"] style:(UIBarButtonItemStylePlain) target:self action:@selector(returnAction:)];
    
    self.infoArray = @[@"手机号码",@"电子邮箱"].mutableCopy;
    self.nameArray = @[@"用户名"].mutableCopy;
    self.numberArray = @[@"地区",@"性别",@"生日",@"个性签名"].mutableCopy;
    [self.tableView registerNib:[UINib nibWithNibName:@"infoOneCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"infoTwoCell" bundle:nil] forCellReuseIdentifier:@"cell2"];
    

    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    infoTwoCell  * cell1= [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:2]];
       cell1.setLabel.text = [[AVUser currentUser] objectForKey:@"gender"];
    
   
    infoTwoCell * cell2 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:2]];
    
    cell2.setLabel.text = [[AVUser currentUser] objectForKey:@"date"];
//    
    infoTwoCell * cell3 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    cell3.setLabel.text = [[AVUser currentUser] objectForKey:@"username"];
    
    
    
    infoTwoCell * cell4 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:2]];
    cell4.setLabel.text = [[AVUser currentUser] objectForKey:@"signature"];
    

    
    
}

- (void)returnAction:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 1) {
        return self.nameArray.count;
    }else if (section == 2){
        return self.numberArray.count;
        
    }
    return 1;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section ==0) {
        
        infoOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        AVQuery *query = [AVQuery queryWithClassName:@"headerImage"];
        [query whereKey:@"username" equalTo:[AVUser currentUser].username];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (objects.count > 0) {
                AVObject * obj = [objects lastObject];
                AVFile * imageFile = [obj valueForKey:@"headerimage"];
                [cell.headImg sd_setImageWithURL:[NSURL URLWithString:imageFile.url]];
            }
        }];
        
        return cell;
        
    }else if (indexPath.section ==1){
        infoTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        
        
        
        cell.nameLabel.text = self.nameArray[indexPath.row];
        
        return cell;
        
    }else if(indexPath.section == 2){
        infoTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        cell.nameLabel.text = self.numberArray[indexPath.row];
        if (indexPath.row == 1) {
        
                
       
        }
        
        
        
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 110;
    }else if (indexPath.section == 1){
        
        return 80;
    }else {
        return 80;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    if (indexPath.section== 0) {
        headPhotoController * headVC = [[headPhotoController alloc] init];
        UINavigationController * headNC = [[UINavigationController alloc] initWithRootViewController:headVC];
        [self presentViewController:headNC animated:YES completion:nil];
        
    }else if (indexPath.section == 1){
        userNameController * userVC = [[userNameController alloc] init];
        UINavigationController * userNC = [[UINavigationController alloc] initWithRootViewController:userVC];
        [self presentViewController:userNC animated:YES completion:nil];
        
        
        
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            
        
        }else if(indexPath.row == 1) {
            //            性别
            self.gVC = [[GenderController alloc] init];
            self.gVC.delegate = self;
            //
          
            [self presentPopupViewController:self.gVC animationType:(MJPopupViewAnimationSlideBottomTop)];
        }else if (indexPath.row == 2){
            
            
            self.dataVC = [[DateViewController alloc] init];
            self.dataVC.delegate = self;
            [self presentPopupViewController:self.dataVC animationType:(MJPopupViewAnimationSlideBottomTop)];

        }else if (indexPath.row == 3){
           
            
          SignatureViewController  * signatureVC = [[SignatureViewController alloc] init];
            
            UINavigationController * signaNC = [[UINavigationController alloc] initWithRootViewController:signatureVC];
            
            [self presentViewController:signaNC animated:YES completion:nil];
            
        }
    }
    
}
-(void)selectGender:(BOOL)gender
{
    NSLog(@"===%d",gender);
    
    infoTwoCell  * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:2]];
    cell.setLabel.text = gender == 1 ?@"男":@"女";
    [ [AVUser currentUser] setObject:cell.setLabel.text forKey:@"gender"];
    [[AVUser currentUser] saveInBackground];
    
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}
//日期代理方法
-(void)selectDate:(NSDate *)adate
{
    
//    NSLog(@"%@",adate);
    infoTwoCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:2]];
    NSString * string = [NSString stringWithFormat:@"%@",adate];
  string =  [string substringToIndex:9];
    
    cell.setLabel.text = string;
    NSLog(@"%@",cell.setLabel.text);
    
   [ [AVUser currentUser] setObject:cell.setLabel.text forKey:@"date"];
    
    [[AVUser currentUser] saveInBackground];
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    
    
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
