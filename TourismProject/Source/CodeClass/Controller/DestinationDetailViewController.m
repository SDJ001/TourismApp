//
//  DestinationDetailViewController.m
//  TourismProject
//
//  Created by ShenDeju on 16/1/29.
//  Copyright © 2016年 鲁东阳. All rights reserved.
//

#import "DestinationDetailViewController.h"

@interface DestinationDetailViewController () <UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic) ExpandHeader *header;
@property(strong,nonatomic) UITableView *tablView;
@end

static NSString *const collectionReuseID = @"collectionReuseidentifier";
@implementation DestinationDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    UIBarButtonItem *right1 = [[UIBarButtonItem alloc] initWithTitle:@"收藏" style:UIBarButtonItemStylePlain target:self action:@selector(right1Action:)];
    UIBarButtonItem *right2 = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(right2Action:)];
    self.navigationItem.rightBarButtonItems = @[right2,right1];
    
    [self.navigationController.navigationBar  setBackgroundImage:[self imageWithBgColor: [ UIColor colorWithRed:1 green:1 blue:1 alpha:0]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[self imageWithBgColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0]]];
    
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 180)];
    customView.backgroundColor = [UIColor redColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 180)];
    [imageView setImage:[UIImage imageNamed:@"image"]];
     //关键步骤 设置可变化背景view属性
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    imageView.clipsToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [customView addSubview:imageView];
    
    self.tablView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight) style:UITableViewStylePlain];
    self.tablView.dataSource = self;
    self.tablView.delegate = self;
    [self.tablView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    _header =[ExpandHeader expandWithScrollView:self.tablView expandView:customView];
    [self.view addSubview:self.tablView];
    

    // Do any additional setup after loading the view.
}
-(void) backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView

{
    
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithBgColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:self.tablView.contentOffset.y / 100]] forBarMetrics:UIBarMetricsDefault];
    
}

-(UIImage *)imageWithBgColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}


/*
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  30;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = @"eqeqeqweqew";
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  50;
}
*/





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
