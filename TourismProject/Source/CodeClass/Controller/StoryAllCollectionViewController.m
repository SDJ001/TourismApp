//
//  StoryAllCollectionViewController.m
//  TourismApp
//
//  Created by lanou3g on 16/1/16.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "StoryAllCollectionViewController.h"

@interface StoryAllCollectionViewController ()
@property(nonatomic,strong)DataBaseTool * tool;
@property(nonatomic,strong)NSMutableArray * dataArr;
@property(nonatomic,strong)NSMutableDictionary * dataDict;
@property(nonatomic,strong)NSMutableArray* keyArray;
@property(nonatomic,strong)MBProgressHUD * hud;
@end
NSInteger indexStart = 1;
@implementation StoryAllCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

-(DataBaseTool *)tool{
    if (!_tool) {
        _tool = [DataBaseTool shareDataBaseTool];
    }return _tool;
}

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }return _dataArr;
}
+(instancetype)shareStoryAllController{
    static  StoryAllCollectionViewController * story = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!story) {
            UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
            story = [[StoryAllCollectionViewController alloc]initWithCollectionViewLayout:flowLayout];
        }
    });return story;
}
-(MBProgressHUD *)hud{
    if (!_hud) {
        _hud = [MBProgressHUD new];
    }return _hud;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    _dataDict = [NSMutableDictionary new];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self updataByUrlString:kStroyUrl];
    UINib * nib = [UINib nibWithNibName:@"RecommendCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreDataByIndexStart:indexStart];
    }];
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self updataByUrlString:kStroyUrl];
    }];
}

-(void)updataByUrlString:(NSString * )urlString{
    if ([self.dataDict count]==0) {
        self.hud.mode = MBProgressHUDModeAnnularDeterminate;
    }
    [self.tool getDataSourceByUrlString:urlString passData:^(NSDictionary *dict,NSError*error) {
     
        NSDictionary * dataDict = dict[@"data"];
        NSArray * dataArray = dataDict[@"hot_spot_list"];
        
        for (NSDictionary * dic in dataArray) {
            
            RecommendModel * model =[RecommendModel initWithDictionary:dic];
            if ([self.dataDict objectForKey:model.text]==nil) {
                [self.dataDict setObject:model forKey:model.text];
                [self.dataArr insertObject:model.text atIndex:0];
            }
        }
         self.hud.hidden=YES;
         [self.collectionView reloadData];
         [self.collectionView.mj_header endRefreshing];
    }];
}

-(void)loadMoreDataByIndexStart:(NSInteger)startIndex{
    
    [self.tool getdataSourceByStartIndex:startIndex passData:^(NSDictionary *dict,NSError * error) {
        NSDictionary * dataDict = dict[@"data"];
        NSArray * dataArray = dataDict[@"hot_spot_list"];
        for (NSDictionary * dic in dataArray) {
            RecommendModel * model =[RecommendModel initWithDictionary:dic];
            if ([self.dataDict objectForKey:model.text]==nil) {
                [self.dataDict setObject:model forKey:model.text];
                [self.dataArr addObject:model.text];
            }
            
        }
         [self.collectionView reloadData];
         [self.collectionView.mj_footer endRefreshing];
        indexStart ++;
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
   return CGSizeMake(kWidth*.425, kWidth/2);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(kGap/2, kWidth*0.05, kGap, kWidth*0.05);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RecommendCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    RecommendModel * model = [self.dataDict objectForKey:self.dataArr[indexPath.item]];
        [cell.ImgView  setImageWithURL:[NSURL URLWithString:model.index_cover] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
    
    cell.titleLabel.text = model.index_title;
        [cell.userImage  setImageWithURL:[NSURL URLWithString:model.user[@"avatar_s"]] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];

    cell.userLabel.text = model.user[@"name"];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
 
    StoryDetail_TableViewController * storyDetail  = [[StoryDetail_TableViewController alloc]init];
    RecommendModel * model = [self.dataDict objectForKey:self.dataArr[indexPath.item]];
    
    storyDetail.spot_id = model.spot_id;
    storyDetail.name = model.index_cover;
    
    [self.navigationController pushViewController:storyDetail animated:YES];
}


@end
