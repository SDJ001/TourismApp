//
//  DestinationMoreViewController.m
//  TourismProject
//
//  Created by ShenDeju on 16/2/24.
//  Copyright © 2016年 鲁东阳. All rights reserved.
//

#import "DestinationMoreViewController.h"

@interface DestinationMoreViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(strong,nonatomic) UICollectionView *collectioView;
@property(strong,nonatomic) ExpandHeader *header;
@property(nonatomic,strong) NSMutableDictionary *dataDic;
@property(nonatomic,strong) NSMutableArray *dataArr;
@end
static NSString *const collectionReuseID = @"collectionReuseidentifier";
static NSString *const collectionHeaderID = @"collectionHeaderReuseidentifier";
static NSString *const collectionHeader2ID = @"collectionHeader2Reuseidentifier";

@implementation DestinationMoreViewController

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
    
    NSString *urlStr = @"http://api.breadtrip.com/destination/place/";
    urlStr = [urlStr stringByAppendingString:self.urlKeyStr];
    self.dataDic = [NSMutableDictionary dictionary];
    [[getDestinationTools shareGetDestinationTools] getWithUrl:urlStr DestAdd:^(NSMutableDictionary *dataDict, BOOL success) {
        self.dataDic = dataDict;
        dispatch_async(dispatch_get_main_queue(), ^{
          
              [imageView   setImageWithURL:[NSURL URLWithString:self.dataDic[@"photo"]] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
            
            [self.collectioView reloadData];
        });
    }];
    
    
    NSString *urlStrr = @"http://api.breadtrip.com/destination/place/";
    urlStrr = [urlStrr stringByAppendingString:self.urlKeyStr];
    NSString *stri = [NSString stringWithFormat:@"pois/all/?start=0&count=20&sort=default&shift=false&latitude=%@&longitude=%@",self.locationS[@"lat"],self.locationS[@"lng"]];
    urlStrr = [urlStrr stringByAppendingString:stri];
    NSLog(@"%@",urlStrr);
    self.dataArr = [[NSMutableArray alloc] init];
    [[getDestinationTools shareGetDestinationTools] getWithUrl:urlStrr AllDest:^(NSMutableArray *allDestArr, BOOL sucess) {
        self.dataArr = allDestArr;
            NSLog(@"--------------%@",self.dataArr);
            [self.collectioView reloadData];
    }];

    //关键步骤 设置可变化背景view属性
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    imageView.clipsToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [customView addSubview:imageView];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectioView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight) collectionViewLayout:flowLayout];
    self.collectioView.dataSource = self;
    self.collectioView.delegate = self;
    self.collectioView.backgroundColor = [UIColor whiteColor];
    
    [self.collectioView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:collectionReuseID];
    [self.collectioView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionHeaderID];
    [self.collectioView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionHeader2ID];
    _header =[ExpandHeader expandWithScrollView:self.collectioView expandView:customView];
    [self.view addSubview:self.collectioView];
    // Do any additional setup after loading the view.
}

-(void) backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView

{
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithBgColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:self.collectioView.contentOffset.y / 100]] forBarMetrics:UIBarMetricsDefault];
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

 -(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
 {
 return 3;
 }
 
 -(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
 {
     if (section == 0 || section == 1 ) {
         return 6;
     }
     else
     {
         return 1;
     }
 }

-(UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionHeaderID forIndexPath:indexPath];
        UILabel *addressL = [[UILabel alloc] initWithFrame:CGRectMake(0,5, kWidth-100, 20)];
        addressL.text = self.dataDic[@"name"];
        UILabel *moreL = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(addressL.frame), kWidth-100, 20)];
        NSString *str = [self.dataDic[@"visited_count"] stringValue];
        str = [str stringByAppendingString:@" 去过 / "];
        NSString *strr = [self.dataDic[@"wish_to_go_count"] stringValue];
        str =[str stringByAppendingString:strr];
        str = [str stringByAppendingString:@"喜欢"];
        moreL.text = str;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(kWidth-60, 20, 30, 20);
        button.backgroundColor = [UIColor greenColor];
        [button setTitle:@"相册" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(pictureAction:) forControlEvents:UIControlEventTouchUpInside];
    
        [header addSubview:addressL];
        [header addSubview:moreL];
        [header addSubview:button];
        return header;
    }
    else
    {
        UICollectionReusableView *header1 = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionHeader2ID forIndexPath:indexPath];
        UILabel *hotAddr = [[UILabel alloc] initWithFrame:CGRectMake(0, 6, kWidth, 20)];
        hotAddr.text = @"热门地点";
        hotAddr.textAlignment = NSTextAlignmentCenter;
        [header1 addSubview:hotAddr];
        return header1;
    }
  
}

-(void) pictureAction:(UIButton *) button
{
    
}

 -(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
 {
     DestinatioinCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionReuseID forIndexPath:indexPath];
      NearByModel *model = self.dataArr[indexPath.row];
        [cell.imgView  setImageWithURL:[NSURL URLWithString:model.cover] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
     
  
     cell.titleLabel.text = model.name;
     
     return cell;
 }
 
 #pragma mark---collectionFlowlayoutDelegate---------
 - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
 {
     if (indexPath.section == 0) {
         return CGSizeMake(kWidth/5, kWidth/5);
     }
     else if (indexPath.section == 1)
     {
         return CGSizeMake((kWidth-30)/2, (kWidth-30)/2);
     }
     else
     {
         return CGSizeMake(kWidth-100, 50);
     }
 }
 - (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
 {
 return UIEdgeInsetsMake(10, 10, 10, 10);
 
 }
 - (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
 {
 return 10;
 }
 - (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
 return 10;
 }


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(kWidth, 50);
    }
    else if (section == 1)
    {
        return CGSizeMake(kWidth, 30);
    }
    else
    {
        return CGSizeMake(0, 0);
    }
    
}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//
//}


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
