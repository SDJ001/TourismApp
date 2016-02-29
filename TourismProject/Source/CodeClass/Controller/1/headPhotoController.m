//
//  headPhotoController.m
//  TourismProject
//
//  Created by 鲁东阳 on 16/1/23.
//  Copyright © 2016年 鲁东阳. All rights reserved.
//

#import "headPhotoController.h"


@interface headPhotoController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong)UIButton * upload;
@end

@implementation headPhotoController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.navigationItem.title = @"上传头像";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconfont-fanhui-2"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
    [self p_setupView];
    
    // 获取该用户的头像文件对应的url
    // 查询是否已有改用户
    
    AVQuery *query = [AVQuery queryWithClassName:@"headerImage"];
    [query whereKey:@"username" equalTo:[AVUser currentUser].username];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects.count > 0) {
            AVObject * obj = [objects lastObject];
            AVFile * imageFile = [obj valueForKey:@"headerimage"];
            [self.imgView sd_setImageWithURL:[NSURL URLWithString:imageFile.url]];
        }
    }];
}
- (void)p_setupView{
    
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0 , 100, 100)];
    
    self.imgView.backgroundColor = [UIColor redColor];
    //    self.self.imgView.center = Cg(self.view.frame.size.width, self.view.frame.size.height);
    
    self.imgView.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2-150);
    self.imgView.layer.masksToBounds = YES;
    self.imgView.layer.cornerRadius = 50;
    
    self.upload = [UIButton buttonWithType:UIButtonTypeSystem];
    self.upload.frame = CGRectMake(0, 0, 200, 50);
    [self.upload setTitle:@"上传头像" forState:(UIControlStateNormal)];
    self.upload.backgroundColor = [UIColor cyanColor];
    self.upload.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2 -60);
    [self.upload addTarget:self action:@selector(uploadAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:self.upload];
    
    [self.view addSubview:self.imgView];
}
//上传头像
- (void)uploadAction:(UIButton *)sender
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"设置背景图片" message:nil  preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
    UIAlertAction * photo = [UIAlertAction actionWithTitle:@"相册" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController * imgController = [[UIImagePickerController alloc] init];
        imgController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //        imgController.allowsEditing = YES;
        imgController.delegate = self;
        [self presentViewController:imgController animated:YES completion:nil
         ];
    }];
    UIAlertAction * camera = [UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypeCamera)]) {
            UIImagePickerController * cameraController = [[UIImagePickerController alloc] init];
            cameraController.sourceType = UIImagePickerControllerSourceTypeCamera;
            cameraController.delegate = self;
            cameraController.allowsEditing = YES;
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
    
    self.imgView.image = info[@"UIImagePickerControllerOriginalImage"];
    
    // 将图片缩小
    // xxxxxx
    
    [self saveImg];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)saveImg{
    
    // 查询是否已有改用户
    AVQuery *query = [AVQuery queryWithClassName:@"headerImage"];
    [query whereKey:@"username" equalTo:[AVUser currentUser].username];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects.count > 0) {
            // 找到了该用户
            NSData *imageData = UIImagePNGRepresentation(self.imgView.image);
            AVFile *imageFile = [AVFile fileWithName:@"image.png" data:imageData];
            [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                
            } progressBlock:^(NSInteger percentDone) {
                NSLog(@"%lu",(long)percentDone);
            }];
            
            AVObject *userPost = [objects lastObject];
            [userPost setObject:[AVUser currentUser].username forKey:@"username"];
            [userPost setObject:imageFile            forKey:@"headerimage"];
            [userPost saveInBackground];
        } else if(!error) {
            // 输出错误信息
            NSData *imageData = UIImagePNGRepresentation(self.imgView.image);
            AVFile *imageFile = [AVFile fileWithName:@"image.png" data:imageData];
            [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                
            } progressBlock:^(NSInteger percentDone) {
                NSLog(@"%lu",(long)percentDone);
            }];
            
            AVObject *userPost = [AVObject objectWithClassName:@"headerImage"];
            [userPost setObject:[AVUser currentUser].username forKey:@"username"];
            [userPost setObject:imageFile            forKey:@"headerimage"];
            [userPost saveInBackground];
        }else
        {
            NSLog(@"发生了错误");
        }
    }];
    
    
    
    
    
    
}

- (void)leftAction:(UIBarButtonItem *)sender{
    
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
