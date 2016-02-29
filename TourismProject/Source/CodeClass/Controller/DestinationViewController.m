//
//  DestinationViewController.m
//  TourismApp
//
//  Created by ShenDeju on 16/1/20.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "DestinationViewController.h"

@interface DestinationViewController () <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CitySearchViewDelegate,UISearchBarDelegate>
@property(strong,nonatomic) UICollectionView *collectionView;

@property(strong,nonatomic) UICollectionViewFlowLayout *flowLayout;
@property(strong,nonatomic) SDCycleScrollView *sdScrollView;
@property(strong,nonatomic) NSMutableArray *bannersArr;
@property(strong,nonatomic) NSMutableArray *elementsArr;
@property(strong,nonatomic) NSMutableArray *sectionArr;
@property(strong,nonatomic) NSMutableDictionary *dataDict;
@property(assign,nonatomic) NSInteger index;
@property(strong,nonatomic) NSArray *dataSource;
@property(strong,nonatomic) UISearchBar *searchBar;
@property(strong,nonatomic) NSMutableArray *searchResult;
@property(strong,nonatomic) NSMutableArray *searchDomain;
@property(strong,nonatomic) NSMutableArray *searchOversea;

@end

static NSString *const cellReuseID = @"collectionViewCellReuseIdentifier";
static NSString *const headerReuseID = @"headerReuseIdentifier";
static NSString *const headerReuseID2 = @"headerReuseIdentifier2";
static NSString *const destinationReuseID = @"destinationCollectionReuseIdentifier";

@implementation DestinationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.backgroundColor = [UIColor cyanColor];
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.flowLayout.itemSize = CGSizeMake((kWidth -30)/2, (kWidth-30)/2);
    self.flowLayout.minimumLineSpacing = 10;
    self.flowLayout.minimumInteritemSpacing = 10;
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight) collectionViewLayout:self.flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.bounces = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator =  NO;
    [self.collectionView registerClass:[DestinatioinCollectionViewCell class] forCellWithReuseIdentifier:destinationReuseID];
    
   self.sdScrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 170)];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseID];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseID2];
    [self.view addSubview:self.collectionView];
    self.collectionView.bounces = YES;
    
    [self drawNavigationView];
    
    [self getAllData];

    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       //进入刷新转态后会自动调用这个Block
        [self updata];
    }];

//    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//       //进入刷新状态后自动调用这个BLOCK
//        [self updata2];
//    }];
    
}
-(void)updata{
    dispatch_after(2, dispatch_get_main_queue(), ^{
        [self.collectionView.mj_header endRefreshing];
    });
}
//-(void) updata2
//{
//    dispatch_after(2, dispatch_get_main_queue(), ^{
//        [self.collectionView.mj_footer endRefreshing];
//    });
//}

-(void) drawNavigationView
{
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10,0, kWidth-80, 44)];
    self.searchBar.delegate = self;
    self.searchBar.placeholder= @"搜索";
    [_searchBar setBackgroundColor:[UIColor clearColor]];
    _searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    _searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [[[_searchBar.subviews objectAtIndex:0].subviews objectAtIndex:0] removeFromSuperview];
    [self.navigationController.navigationBar addSubview:self.searchBar];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor cyanColor]];
    
     self.nearbyButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.nearbyButton.frame = CGRectMake(kWidth-60, 0, 50, 40);
    [self.nearbyButton setTitle:@"附近" forState:UIControlStateNormal];
    [self.nearbyButton addTarget:self action:@selector(nearbyAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:self.nearbyButton];
    
    _searchResult = [NSMutableArray array];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
   // NSLog(@"22");
}
 
-(void)changeAction:(UIButton*)sender{
    NSLog(@"221");
}
-(void) nearbyAction:(UIButton*) sender
{
}

-(void) getAllData
{
    self.dataDict = [NSMutableDictionary new];
    self.bannersArr = [NSMutableArray array];
    self.elementsArr = [NSMutableArray array];
    self.sectionArr = [NSMutableArray array];
    
    [[getDestinationTools shareGetDestinationTools] getBannerData:^(NSMutableArray *dataArray, BOOL success) {
        if (success == YES) {
            self.bannersArr = dataArray;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
        }
    }];
    
[[getDestinationTools shareGetDestinationTools] getSectionData:^(NSMutableDictionary *dataDict, BOOL success) {
    for (NSDictionary * dic in dataDict[@"elements"]) {
        ElementModel * model = [ElementModel initWithDictionary:dic];
        [self.elementsArr addObject:model];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }
 }];


}
//        [self.dataDict setValue:self.bannersArr forKey:@"banners"];
//        [self.dataDict setValue:self.elementsArr forKey:@"elements"];



-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return  self.elementsArr.count;
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
       ElementModel *mode = self.elementsArr[section];
    NSArray *dataArr = mode.data;
    return dataArr.count;
}

-(UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
        ElementModel *model = self.elementsArr[indexPath.section];
        self.index = indexPath.section;
    
        UICollectionReusableView *header1 = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseID forIndexPath:indexPath];
        if (indexPath.section == 0) {
            UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseID2 forIndexPath:indexPath];
            NSMutableArray *dataAr = [NSMutableArray array];
            for (scorllDataModel *mode in self.bannersArr) {
                NSString *imgUR = mode.image_url;
                [dataAr addObject:imgUR];
            }
            self.sdScrollView.imageURLStringsGroup = dataAr;
            
            DestinationSectionHeader *destihead = [[DestinationSectionHeader alloc] initWithFrame:CGRectMake(0, 170, kWidth, 30)];
            destihead.allButton.hidden = YES;
            destihead.destinationLabel.text = model.title;
            
            [header addSubview:self.sdScrollView];
            [header addSubview:destihead];
            return header;
        }else{
            
            DestinationSectionHeader *destihead = [[DestinationSectionHeader alloc] initWithFrame:CGRectMake(0, 0, kWidth, 30)];
            if (model.more == 0) {
                [destihead.allButton removeFromSuperview];
            }else{
                destihead.allButton.tag = 1111+indexPath.section;
                [destihead.allButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            }
            NSArray * arr = header1.subviews;
            for (UIView * view in arr) {
                [view removeFromSuperview];
            }
            destihead.destinationLabel.text = model.title;
            [header1 addSubview:destihead];
            
            return header1;
        }
    return nil;
}

-(void) buttonAction:(UIButton*) sender
{
    ElementModel *model = self.elementsArr[sender.tag-1111];
    UICollectionViewFlowLayout *flowlayout = [UICollectionViewFlowLayout new];
    MoreCityCollectionViewController *moreVC = [[MoreCityCollectionViewController alloc] initWithCollectionViewLayout:flowlayout];
        moreVC.urlIndex = model.index;
        moreVC.countryStr = model.title;
    UINavigationController *moreNC = [[UINavigationController alloc] initWithRootViewController:moreVC];
    [self presentViewController:moreNC animated:NO completion:nil];
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DestinatioinCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:destinationReuseID forIndexPath:indexPath];
    ElementModel *model = self.elementsArr[indexPath.section];
    NSArray *dataArr = model.data;
    DestinationCityModel *cityModel = [DestinationCityModel initWithDictionary:dataArr[indexPath.row]];
    [cell.imgView   setImageWithURL:[NSURL URLWithString:cityModel.cover] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
    
    cell.imgView.layer.cornerRadius = 6;
    cell.imgView.layer.masksToBounds = YES;
    
    cell.titleLabel.text = cityModel.name;
    return cell;
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(kWidth, 200);
    }
    return CGSizeMake(kWidth, 30);
}
-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kWidth-30)/2, (kWidth-30)/2);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //DestinationDetailViewController *destinationVC = [[DestinationDetailViewController alloc] init];
   // DestinationMoreViewController *destinationVC = [[DestinationMoreViewController alloc] init];
    
    ElementModel *model = self.elementsArr[indexPath.section];
    NSArray *dataArr = model.data;
    DestinationCityModel *cityModel = [DestinationCityModel initWithDictionary:dataArr[indexPath.row]];
    NSString *str = [cityModel.url substringFromIndex:8];
    
    AllDestinationViewController *destinationVC = [[AllDestinationViewController alloc] init];
    destinationVC.urlStr = str;
    destinationVC.locationDict = cityModel.location;
    
    destinationVC.title =@"按热门排序";
    UINavigationController *destinationNC = [[UINavigationController alloc] initWithRootViewController:destinationVC];

    [self presentViewController:destinationNC animated:YES completion:nil];
    
}

#pragma mark----UISearchBarDelegate----------
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    UICollectionViewFlowLayout *flayout = [[UICollectionViewFlowLayout alloc] init];
    SearchCollectionViewController *searchVC = [[SearchCollectionViewController alloc] initWithCollectionViewLayout:flayout];
    UINavigationController * nav= [[UINavigationController alloc]initWithRootViewController:searchVC];
    nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:nav animated:YES completion:nil];
    return YES;
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
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
