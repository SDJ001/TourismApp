//
//  MoreCityCollectionViewController.m
//  TourismApp
//
//  Created by ShenDeju on 16/1/21.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "MoreCityCollectionViewController.h"

@interface MoreCityCollectionViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(strong,nonatomic) NSMutableArray *dataArray;
@end

static NSString * const reuseIdentifier = @"Cell";

@implementation MoreCityCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.title = self.countryStr;
    NSString *str = [NSString stringWithFormat:@"http://api.breadtrip.com/destination/index_places/%ld/",self.urlIndex];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    self.dataArray = [NSMutableArray array];
    if (self.dataArray.count > 0) {
         [self.collectionView reloadData];
    }else
    {
        [[getMoreCityTools shareGetMoreCityTools] getMoreCityWithUrl:str Data:^(NSMutableArray *dataArr) {
            self.dataArray = dataArr;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
        }];
    }
    
    self.collectionView.bounces = NO;
    [self.collectionView registerClass:[DestinatioinCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

-(void) backAction
{
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DestinatioinCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    DestinationCityModel *model = self.dataArray[indexPath.row];
    //[cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.cover]];
      [cell.imgView setImageWithURL:[NSURL URLWithString:model.cover] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
    

    cell.imgView.layer.cornerRadius = 6;
    cell.imgView.layer.masksToBounds = YES;
    cell.titleLabel.text = model.name;

    return cell;
}

#pragma mark <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kWidth-30)/2, (kWidth-30)/2);
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
-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    ElementModel *model = self.dataArray[indexPath.section];
//    NSArray *dataArr = model.data;
//    DestinationCityModel *cityModel = [DestinationCityModel initWithDictionary:self.dataArray[indexPath.row]];
    DestinationCityModel *cityModel = self.dataArray[indexPath.row];
    NSString *str = [cityModel.url substringFromIndex:8];
    
    AllDestinationViewController *destinationVC = [[AllDestinationViewController alloc] init];
    destinationVC.urlStr = str;
    destinationVC.locationDict = cityModel.location;
    
    destinationVC.title =@"按热门排序";
    NSLog(@"%ld",indexPath.item);
    UINavigationController *destinationNC = [[UINavigationController alloc] initWithRootViewController:destinationVC];
    [self presentViewController:destinationNC animated:YES completion:nil];
}
-(BOOL) collectionView:(UICollectionView *)collectionView canFocusItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(BOOL) collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//    
//}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
