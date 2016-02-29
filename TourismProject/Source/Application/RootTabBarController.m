//
//  RootTabBarController.m
//  TourismProject
//
//  Created by 鲁东阳 on 16/1/16.
//  Copyright © 2016年 鲁东阳. All rights reserved.
//

#import "RootTabBarController.h"
#import "FriendsListController.h"
@interface RootTabBarController ()

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    RecommandCollectionViewController * recommandVC = [[RecommandCollectionViewController alloc]initWithCollectionViewLayout:flowLayout];
    
    
    
    UINavigationController * NV = [[UINavigationController alloc]initWithRootViewController:recommandVC];
    NV.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"推荐" image:[UIImage imageNamed:@"iconfont-hand"] selectedImage:[UIImage imageNamed:@""]];
    
    
    DestinationViewController * destinationVC = [[DestinationViewController alloc] init];
    UINavigationController * destinationNC = [[UINavigationController alloc] initWithRootViewController:destinationVC];
    destinationNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"城市猎人" image:[UIImage imageNamed:@"iconfont-youxishoubing"] selectedImage:[UIImage imageNamed:@""]];
    
    
    FriendController * friendVC = [[FriendController alloc] init];
    UINavigationController * friendNC = [[UINavigationController alloc] initWithRootViewController:friendVC];
    friendNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"朋友圈" image:[UIImage imageNamed:@"iconfont-users"] selectedImage:[UIImage imageNamed:@""]];
    
    
    UserController * userVC = [[UserController alloc] init];
   
   
    userVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"iconfont-wode"] selectedImage:[UIImage imageNamed:@""]];
    
    FriendsListController * friendlistVC = [[FriendsListController alloc] init];
    UINavigationController * friendlistNC = [[UINavigationController alloc] initWithRootViewController:friendlistVC];
    friendlistNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"好友列表" image:[UIImage imageNamed:@"iconfont-xiaoxi"] selectedImage:nil];
    
    
    self.viewControllers = @[NV,destinationNC,friendlistNC,friendNC,userVC];
   
     

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
