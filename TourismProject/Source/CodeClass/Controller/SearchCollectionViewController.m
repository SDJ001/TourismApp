//
//  SearchCollectionViewController.m
//  TourismApp
//
//  Created by ShenDeju on 16/1/25.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "SearchCollectionViewController.h"
@interface SearchCollectionViewController () <UISearchResultsUpdating ,UISearchBarDelegate,UICollectionViewDelegateFlowLayout>
@property(strong,nonatomic) UICollectionViewController *searchResultsController;
@property(strong,nonatomic) UISearchController *SearchController;
@property(strong,nonatomic) NSMutableArray *collectionArray; // 数据
@property(strong,nonatomic) NSMutableArray *allData;
@property(strong,nonatomic) NSMutableArray *domainArray;
@property(strong,nonatomic) NSMutableArray *overSeaArray;
@property(strong,nonatomic) NSMutableArray *searchArray; //搜索后的数据

@property(strong,nonatomic) UISearchBar *searchBar;

@end

static NSString *const hearderReuseID = @"reuseIdentifier";
static NSString *const hearderReuseID2 = @"reuseIdentifier2";
static NSString *const hearderReuseID3 = @"reuseIdentifier3";
static NSString * const reuseIdentifier = @"Cell";
static NSString *const reuseIdentifier1 = @"cell1";

@implementation SearchCollectionViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
       
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.hidesBackButton  = YES;
    self.navigationController.navigationBar.tintColor = [UIColor redColor];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10,0, kWidth-80, 44)];
    self.searchBar.delegate = self;
    self.searchBar.placeholder= @"搜索";
    [_searchBar setBackgroundColor:[UIColor clearColor]];
    
    [self loadSearchController];

    
    _searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    _searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [[[_searchBar.subviews objectAtIndex:0].subviews objectAtIndex:0] removeFromSuperview];
    [self.navigationController.navigationBar addSubview:self.searchBar];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor cyanColor]];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:hearderReuseID];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:hearderReuseID2];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:hearderReuseID3];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"LabelCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"labelCollection"];

    NSLog(@"%s",__FUNCTION__);
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self loadData];
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //进入刷新转态后会自动调用这个Block
        [self updata];
    }];
}

-(void)updata{
    [self.collectionView reloadData];
    dispatch_after(2, dispatch_get_main_queue(), ^{
        [self.collectionView.mj_header endRefreshing];
    });
}

-(void) viewWillAppear:(BOOL)animated
{
    //[self.collectionView reloadData];
}

-(void)  viewDidAppear:(BOOL)animated
{
     [self.collectionView reloadData];
}

-(void) cancelAction
{
    [self.searchBar resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void) loadData
{
    self.domainArray = [NSMutableArray array];
    self.overSeaArray = [NSMutableArray array];
    self.collectionArray = [NSMutableArray array];
   
    [[SearchDataTools sharePassSearchData] getSearchOverseaData:^(NSMutableArray *dataAr) {
        self.overSeaArray = dataAr;
        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"-------%@",self.overSeaArray);
            [self.collectionView reloadData];
        });
    }];
    
    [[SearchDataTools sharePassSearchData] getSearchDomainData:^(NSMutableArray *dataArr) {
        self.domainArray = dataArr;
        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"+++++%@",self.domainArray);
            [self.collectionView reloadData];
        });

    }];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.searchArray = [NSMutableArray arrayWithArray:[defaults objectForKey:@"lishi"]];
}

-(void) loadSearchController
{
    self.SearchController=[[UISearchController alloc]initWithSearchResultsController:nil];
    self.SearchController.searchResultsUpdater=self;
    self.SearchController.view.backgroundColor = [UIColor whiteColor];
    self.SearchController.dimsBackgroundDuringPresentation = false;
    self.SearchController.hidesNavigationBarDuringPresentation = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 3;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
        if (section == 0) {
            return self.searchArray.count;
        }
        else if (section == 1)
        {
            return self.domainArray.count;
        }
       else
        {
            return self.overSeaArray.count;
        }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
     LabelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"labelCollection" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        
         cell.CityLabel.text = self.searchArray[indexPath.row];
            return cell;
    }
    else if (indexPath.section == 1)
    {
        
            DestinationCityModel *model = self.domainArray[indexPath.row];
            cell.CityLabel.text = model.name;
            return cell;
        }
        else
        {
           
            DestinationCityModel *model = self.overSeaArray[indexPath.row];
            cell.CityLabel.text = model.name;
            return cell;
        }
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:hearderReuseID3 forIndexPath:indexPath];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kWidth-20, 21)];
        label.text = @"搜索历史";
        label.textAlignment = NSTextAlignmentCenter;
        [header addSubview:label];
        return header;
    }
   else if (indexPath.section == 1)
   {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:hearderReuseID forIndexPath:indexPath];
          UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kWidth-20, 21)];
        label.text = @"国外热门目的地";
        label.textAlignment = NSTextAlignmentCenter;
        [header addSubview:label];
        return header;
    }
  else if (indexPath.section == 2)
    {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:hearderReuseID2 forIndexPath:indexPath];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kWidth-20, 21)];
        label.text = @"国内热门目的地";
        label.textAlignment = NSTextAlignmentCenter;
        [header addSubview:label];
        return header;
    }
    return nil;
    
}


#pragma mark searchControllerDelegate
-(void) updateSearchResultsForSearchController:(UISearchController *)searchController
{
    /*
    //[self.SearchController.searchBar resignFirstResponder];
    
//    NSString *filterString = self.SearchController.searchBar.text;
//    [self.searchArray removeAllObjects];
//    
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains [c] %@", filterString];
////    self.searchArray = [NSMutableArray arrayWithArray:[self.collectionArray filteredArrayUsingPredicate:predicate]];
//    
//    [self.searchArray addObject:filterString];
//    [self.searchResultsController.collectionView reloadData];
  */
}

-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"点击键盘搜索");
    if (searchBar.text != nil) {
        if ([self.searchArray containsObject:searchBar.text]) {
            [self.searchArray removeObject:searchBar.text];
            [self.searchArray insertObject:searchBar.text atIndex:9];
        }
        else
        {
            if (self.searchArray.count >=10) {
                [self.searchArray removeObjectsInRange:NSMakeRange(0, self.searchArray.count-9)];
                [self.searchArray addObject:searchBar.text];
            }else
            {
                [self.searchArray addObject:searchBar.text];
            }
        }
    }
    
//     NSLog(@"================%@,%@",searchBar.text,self.searchArray);
     NSArray *arra = [NSArray arrayWithArray:self.searchArray];
     self.searchArray = [NSMutableArray arrayWithArray:arra];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:arra forKey:@"lishi"];
    [defaults synchronize];
    
    SearchResultTableViewController *searchTVC = [[SearchResultTableViewController alloc] init];
    UINavigationController *unc = [[UINavigationController alloc] initWithRootViewController:searchTVC];
    searchTVC.keyString = searchBar.text;
   // unc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:unc animated:YES completion:nil];
    
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
    [self.SearchController.searchBar resignFirstResponder];
    
    SearchResultTableViewController *searchTVC = [[SearchResultTableViewController alloc] init];
    UINavigationController *unc = [[UINavigationController alloc] initWithRootViewController:searchTVC];
   // unc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    if (indexPath.section == 0) {
        if (self.searchArray.count !=0) {
            searchTVC.keyString = self.searchArray[indexPath.row];
        }
       
    }
    else if (indexPath.section == 1)
    {
        DestinationCityModel *model = self.domainArray[indexPath.row];
        searchTVC.keyString = model.name;

    }
    else
    {
        DestinationCityModel *model = self.overSeaArray[indexPath.row];
        searchTVC.keyString =model.name;
    }
    
    [self presentViewController:unc animated:YES completion:nil];
}



#pragma mark--------UICollectionViewLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
            NSString *str = self.searchArray[indexPath.row];
            CGRect rect = [str boundingRectWithSize:CGSizeMake(150, 21) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
            return CGSizeMake(rect.size.width, 21);
    }
    else if (indexPath.section == 1)
    {
            DestinationCityModel *model = self.domainArray[indexPath.row];
            CGRect rect = [model.name boundingRectWithSize:CGSizeMake(150, 21) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
        
            return CGSizeMake(rect.size.width, 21);
        }
        else
        {
            DestinationCityModel *model = self.overSeaArray[indexPath.row];
            CGRect rect = [model.name boundingRectWithSize:CGSizeMake(150, 21) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
            return CGSizeMake(rect.size.width, 21);
        }
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return  UIEdgeInsetsMake(10, 10, 10, 10);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 15;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 15;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(kWidth, 21);
}     

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
