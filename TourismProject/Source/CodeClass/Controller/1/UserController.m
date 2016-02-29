
//
//  UserController.m
//  TourismProject
//
//  Created by 鲁东阳 on 16/1/16.
//  Copyright © 2016年 鲁东阳. All rights reserved.
//

#import "UserController.h"
#import "LoginViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "SetupTableViewController.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kGap 40
#define kBWith 30

@interface UserController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong)UIScrollView * scrollView;
@property (nonatomic,strong)UIView * backgroundView;
//设置
@property (nonatomic,strong)UIButton * setButton;
@property (nonatomic,strong)UIButton * photoButton;
@property (nonatomic,strong)UIImageView * headPhotoImgview;
@property (nonatomic,strong)UILabel * signaturelb;


@end

@implementation UserController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    
    
    
   [self p_setupView];
    AVUser * curUser = [AVUser currentUser];
    
    if (curUser !=  nil){
    AVQuery *query = [AVQuery queryWithClassName:@"headerImage"];
    [query whereKey:@"username" equalTo:[AVUser currentUser].username];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects.count > 0) {
            AVObject * obj = [objects lastObject];
            AVFile * imageFile = [obj valueForKey:@"headerimage"];
            [self.headPhotoImgview sd_setImageWithURL:[NSURL URLWithString:imageFile.url]];
        }
    }];
    
    }
    self.signaturelb.text = [[AVUser currentUser] objectForKey:@"signature"];
    
}
- (void)p_setupView{
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.view.frame.size.height);
    self.scrollView.scrollEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = YES;
    
    [self.view addSubview:self.scrollView];
    
    self.backgroundView = [[UIView alloc] init];
    
    self.backgroundView.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, 270);
    
    self.backgroundView.backgroundColor = [UIColor cyanColor];
    self.backgroundView.userInteractionEnabled = YES;
    [self.scrollView addSubview:self.backgroundView];
    
    self.setButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.setButton.frame = CGRectMake(kWidth-kGap, kGap/2, kGap-10, kGap -10);
    UIImage * setImg = [UIImage imageNamed:@"iconfont-shezhi-2"];
    setImg = [setImg imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    
    
    [self.setButton setImage:setImg forState:(UIControlStateNormal)];
    
    [self.setButton addTarget:self action:@selector(setAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.backgroundView addSubview:self.setButton];
    
    // 更改背景button
    self.photoButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    
    self.photoButton.frame = CGRectMake(20, kGap/2, CGRectGetWidth(self.setButton.frame), CGRectGetHeight(self.setButton.frame));
    UIImage * photoImg = [UIImage imageNamed:@"iconfont-13"];
    photoImg = [photoImg imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    
    
    
    [self.photoButton setImage:photoImg forState:(UIControlStateNormal)];
    [self.photoButton addTarget:self action:@selector(backgroundViewAcition:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.backgroundView addSubview:self.photoButton];
    self.headPhotoImgview = [[UIImageView alloc] init];
    self.headPhotoImgview.frame = CGRectMake(0, 0, 100,100);
    self.headPhotoImgview.center = self.backgroundView.center;
    self.headPhotoImgview.layer.masksToBounds = YES;
    self.headPhotoImgview.layer.cornerRadius = 50;
    self.headPhotoImgview.userInteractionEnabled = YES;
    [self.scrollView addSubview:self.headPhotoImgview];
    
    self.signaturelb = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headPhotoImgview.frame)+10, CGRectGetWidth(self.headPhotoImgview.frame)*2, 60)];
    self.signaturelb.numberOfLines = 0;
    self.signaturelb.center = CGPointMake(self.backgroundView.frame.size.width/2,self.backgroundView.frame.size.height -50);
    self.signaturelb.textAlignment = NSTextAlignmentCenter;
//    self.signaturelb.backgroundColor = [UIColor redColor];
    [self.scrollView addSubview:self.signaturelb];
    //    头像添加点击手势
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headPhotoTap:)];
    [self.headPhotoImgview addGestureRecognizer:tap];
    
    

    
}
//点击头像设置个人信息
- (void)headPhotoTap:(UITapGestureRecognizer *)tap {
    
    PersonalInformationController * perVC = [[PersonalInformationController alloc] initWithStyle:(UITableViewStyleGrouped)];
    UINavigationController * perNC = [[UINavigationController alloc] initWithRootViewController:perVC];
    [self presentViewController:perNC animated:YES completion:nil];
    
    
}


//设置事件，弹出设置页面

- (void)setAction:(UIButton *)sender{
    
    SetupTableViewController * setVC = [[SetupTableViewController alloc] init];
    UINavigationController * setNC =[[UINavigationController alloc] initWithRootViewController:setVC];
    [self presentViewController:setNC animated:YES completion:nil];
    
    
}
//改变背景图片
- (void)backgroundViewAcition:(UIButton *)sender{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"设置背景图片" message:nil  preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
    UIAlertAction * photo = [UIAlertAction actionWithTitle:@"相册" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController * imgController = [[UIImagePickerController alloc] init];
        imgController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imgController.delegate = self;
        [self presentViewController:imgController animated:YES completion:nil
         ];
        
    }];
    UIAlertAction * camera = [UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypeCamera)]) {
            UIImagePickerController * cameraController = [[UIImagePickerController alloc] init];
            cameraController.sourceType = UIImagePickerControllerSourceTypeCamera;
            cameraController.delegate = self;
            [self presentViewController:cameraController animated:YES completion:nil];
        }else {
            
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"没有找到您的摄像头" message:@"请您检查摄像头" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            
        }
        
    }];
    [alertVC addAction: camera];
    [alertVC addAction:cancel];
    [alertVC addAction:photo];
    //    [alertVC addAction:];
    
    [self presentViewController:alertVC animated:YES completion:nil];
    
    
    
}
//调用相机 相册代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    NSLog(@"===========%@",info);
    UIImage * img = [[UIImage alloc] init];
    
    img  = info[@"UIImagePickerControllerOriginalImage"];
    self.backgroundView.backgroundColor = [UIColor colorWithPatternImage:img];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


-(void)viewDidAppear:(BOOL)animated
{
   

    __block NSUInteger index = [[[NSUserDefaults standardUserDefaults] valueForKey:@"selectedIndex"] integerValue];
    
    AVUser * curUser = [AVUser currentUser];
    
    if (curUser ==  nil) {
        
        LoginViewController * lv = [[LoginViewController alloc] init];
        lv.callback = ^{
            self.tabBarController.selectedIndex = index;
        };
        
        [self presentViewController:lv animated:YES completion:nil];
    }else
    {
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
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
