//
//  RecommandCollectionViewController.m
//  TourismApp
//
//  Created by lanou3g on 16/1/15.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "RecommandCollectionViewController.h"
#import "DataBaseTool.h"
@interface RecommandCollectionViewController ()<UICollectionViewDelegateFlowLayout,SDCycleScrollViewDelegate,UICollectionViewDataSource,AlertDelegate>
@property(nonatomic,strong) NSMutableDictionary * dataDict;
@property(nonatomic,strong) DataBaseTool        *  tool;
@property(nonatomic,strong) SDCycleScrollView   * cycleScrollView;
@property(nonatomic,strong) NSMutableArray      * keyAarr;
@property(nonatomic,strong) NSMutableDictionary * next_starDcit;
@property(nonatomic,strong) MBProgressHUD       * hud;//加载弹窗


@end
BOOL reachNet = YES;
@implementation RecommandCollectionViewController

static NSString * const reuseIdentifier = @"Cell";
static NSString * const reuseTravelIdentifier = @"reuseTravelIdentifier";
static NSString * const reuseFirstSectionIdentifier = @"reuseFirstSectionIdentifier";
static NSString * const reuseHeaderViewIndentifier = @"reuseHeaderViewIndentifier";

-(NSMutableArray *)keyAarr{
    if (!_keyAarr) {
        _keyAarr = [NSMutableArray arrayWithObjects:@"carousel",@"story",@"travel", nil];
    }return _keyAarr;
}
-(DataBaseTool *)tool{
    if (!_tool) {
        
        _tool = [DataBaseTool shareDataBaseTool];
    }return _tool;
}
-(NSMutableDictionary *)dataDict{
    if (!_dataDict) {
        _dataDict = [NSMutableDictionary new];
    }return _dataDict;
}
-(void)viewWillAppear:(BOOL)animated{
    if ([self.dataDict count]==0) {
        self.collectionView.mj_footer.hidden = YES;
    }else{
        self.collectionView.mj_footer.hidden = NO;
    }
}
//加载弹窗
-(MBProgressHUD *)hud{
    if (!_hud) {
        _hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    }return _hud;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UINib * nib = [UINib nibWithNibName:@"RecommendCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    UINib * travelNib = [UINib nibWithNibName:@"TravelNoteCollectionViewCell" bundle:nil];
   
    [self.collectionView registerNib:travelNib forCellWithReuseIdentifier:reuseTravelIdentifier];

    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeaderViewIndentifier];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseFirstSectionIdentifier];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"附近" style:(UIBarButtonItemStyleDone) target:self action:@selector(neaybyController)];
    
    _next_starDcit = [NSMutableDictionary new];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.cycleScrollView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight/3.2)];
    self.cycleScrollView.delegate = self;
    //添加检测网络状态的通知中心
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(netWorkingChange:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self updata]; 
    }];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self toloadMoreData];
    }];
    [self.collectionView.mj_header beginRefreshing];
}
 //监测到网络变化以后执行此事件
-(void)netWorkingChange:(NSNotification*)sender{
    
    NSNumber * net = [sender.userInfo objectForKey:AFNetworkingReachabilityNotificationStatusItem];
    AlertType type = AlertTypeSuccess;
    
    NSString * message = @"网络检测";
    if ([net isEqual:@0]) {
        message = @"网络断开";
        NSLog(@"网络断开");
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        reachNet = NO;
        type = AlertTypeError;
    }else if ([net isEqual:@1]){
        NSLog(@"wwan");
        type =AlertTypeWarning;
        ;
        message = @"当前网络为wwan";
        if (reachNet==NO) {
             [self willNetReachabilityToGetData];
            message = @"网络恢复正常,当前网络为WWAN";
            reachNet=YES;
            
        }
        
    }else if ([net isEqual:@2]){
        type = AlertTypeSuccess;
        message = @"当前网络为wifi";
        if (reachNet==NO) {
             [self willNetReachabilityToGetData];
            message = @"网络恢复正常,当前网络为WIFI";
            reachNet=YES;
        }
    }else if ([net isEqual:@3]){
        NSLog(@"未知");
        type = AlertTypeWarning;
        message = @"当前网络未知";
        if (reachNet==NO) {
            message = @"网络恢复正常,当前网络未知";
            [self willNetReachabilityToGetData];
            reachNet=YES;
        }
    
    }
    Alert * alert = [[Alert alloc]initWithTitle:message duration:2 completion:^{
       
        [alert setDelegate:self];
        [alert setShowStatusBar:NO];
        [alert setAlertType:type];
        [alert setIncomingTransition:AlertIncomingTransitionTypeGrowFromCenter];
        [alert setOutgoingTransition:AlertOutgoingTransitionTypeFadeAway];
        [alert setBounces:YES];
        
    }];
    [alert showAlert];
}
//网络恢复以后判断页面是否有数据,如果没有那么开始下载
-(void)willNetReachabilityToGetData{

    if ([self.dataDict count]==0) {
        if ([self.collectionView.mj_header isRefreshing]) {
            [self.collectionView.mj_header endRefreshing];
        }
            [self.collectionView.mj_header beginRefreshing];
    }
}
//进入附近页面
-(void)neaybyController{


    NearbyMainViewController * nearby = [NearbyMainViewController shareNerbyMainViewController];
    [self.navigationController pushViewController:nearby animated:YES];
    
}
//下载数据
- (void)updata{
    if ([self.dataDict count] == 0) {
        self.hud.mode = MBProgressHUDModeIndeterminate;
        self.hud.backgroundColor = [UIColor whiteColor];
    }
    [self.tool getDataSourceByUrlString:kUrl passData:^(NSDictionary *dict,NSError * error) {
       
        if (error!=NULL) {
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView.mj_footer endRefreshing];
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"网络连接失败" message:[error.userInfo objectForKey:NSLocalizedDescriptionKey] preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction * cancle = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction * setting = [UIAlertAction actionWithTitle:@"去设置" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                NSURL*url=[NSURL URLWithString:@"prefs:root==WIFI"];
                [[UIApplication sharedApplication] openURL:url];
            }];
            [alert addAction:cancle];
            [alert addAction:setting];
            
            [_hud hideAnimated:YES];
            [self presentViewController:alert animated:YES completion:nil];
            
        }else{
            
            
            NSDictionary * dataDict = dict[@"data"];
            
            NSArray * elementArray = dataDict[@"elements"];
            
            NSMutableArray * storyArr    = [NSMutableArray new];
            NSMutableArray * carouselArr = [NSMutableArray new];
            NSMutableArray * travelArr   = [NSMutableArray new];
            //解析数据
            for (NSDictionary * dic in elementArray) {
                NSArray * arr = [dic[@"data"] firstObject];
                if ([dic[@"type"] intValue]==1) {
                    for (NSDictionary * dict in arr) {
                        carouselModel * model = [carouselModel initWithDictionary:dict];
                        [carouselArr addObject:model];
                    }
                }else if ([dic[@"type"] intValue]==10){
                    NSDictionary * dict = (NSDictionary*)arr;
                    RecommendModel  *  model = [RecommendModel initWithDictionary:dict];
                    [storyArr addObject:model];
                }else {
                    NSDictionary * dict = (NSDictionary*)arr;
                    if ([dic[@"type"] intValue]==4){
                        
                        
                        travelNoteModel * model = [travelNoteModel initWithDictionary:dict];
                        [travelArr addObject:model];
                    }else if ([dic[@"type"]intValue]==7){
                        
                        ProductModel * model = [ProductModel initWithDictionary:dict];
                        
                        [travelArr addObject:model];
                    }
                }
            }
            
            
            [self.dataDict setObject:carouselArr forKeyedSubscript:@"carousel"];
            [self.dataDict setObject:storyArr forKey:@"story"];
            [self.dataDict setObject:travelArr forKey:@"travel"];
            [self.collectionView reloadData];
            [_next_starDcit setValue:dataDict[@"next_start"] forKey:@"nextStart"];
            self.hud.hidden = YES;
            [self.collectionView.mj_header endRefreshing];
            self.collectionView.mj_footer.hidden = NO;
        }
    }];
 
}
//上拉加载更多数据
- (void)toloadMoreData{

    [self.tool getDataSourceByNestStart:_next_starDcit[@"nextStart"] passData:^(NSDictionary *dict,NSError*error) {
        NSMutableArray * array =  _dataDict[@"travel"];
        for (NSDictionary * dic in dict[@"data"][@"elements"])
        {
        
            
            if ([dic[@"type"] intValue]==4){
                
                
                travelNoteModel * model = [travelNoteModel initWithDictionary:[dic[@"data"] firstObject]];
                [array addObject:model];
            }else if ([dic[@"type"]intValue]==7){
                
                ProductModel * model = [ProductModel initWithDictionary:[dic[@"data"] firstObject]];
                
                [array addObject:model];
            }
            
        }
        [self.dataDict setObject:array forKey:@"travel"];
        [self.next_starDcit setValue:dict[@"data"][@"next_start"] forKey:@"nextStart"];
        [self.collectionView reloadData];
        [self.collectionView.mj_footer endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark <UICollectionViewDataSource>
//分区个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return  self.keyAarr.count;
}

//根据字典对应的key值找到对应的数组,根据数组个数确定item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section==0) {
        return 0;
    }

    return [[self.dataDict objectForKey:self.keyAarr[section]] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        TravelNoteCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseTravelIdentifier forIndexPath:indexPath];
        
        return cell;
    }
    else if (indexPath.section == 1)
    {
        RecommendCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        RecommendModel *  model = [[self.dataDict objectForKey:self.keyAarr[indexPath.section]] objectAtIndex:indexPath.item];
        cell.titleLabel.text = model.index_title;

        cell.userLabel.text = model.user[@"name"];


         [cell.ImgView setImageWithURL:[NSURL URLWithString:model.index_cover] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
        
        [cell.userImage setImageWithURL:[NSURL URLWithString:model.user[@"avatar_s"]] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
      
        

        return cell;
    }else {
        TravelNoteCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseTravelIdentifier forIndexPath:indexPath];
        NSURL * url = nil;
        if ([[[self.dataDict objectForKey:self.keyAarr[indexPath.section]] objectAtIndex:indexPath.item]isKindOfClass:[travelNoteModel class]]) {
              travelNoteModel * model = [[self.dataDict objectForKey:self.keyAarr[indexPath.section]] objectAtIndex:indexPath.item];
            url = [NSURL URLWithString:model.cover_image];
            cell.nameLabel.text = model.name;
           [cell.nameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
            cell.first_Day.text = model.first_day;
            cell.popular_place_str.text = model.popular_place_str;
            cell.viewCount.text = [NSString stringWithFormat:@"%@次浏览",model.view_count];
            cell.dayCount.text = [NSString stringWithFormat:@"%@天",model.day_count];
            cell.userName.text = model.user[@"name"];
            
            [cell.userImgView setImageWithURL:[NSURL URLWithString:model.user[@"avatar_l"]] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];

            

            
        }else{
              ProductModel * model = [[self.dataDict objectForKey:self.keyAarr[indexPath.section]] objectAtIndex:indexPath.item];
            url = [NSURL URLWithString:model.cover];
        }

      [cell.imgView setImageWithURL:url options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
        

        return cell;
    }

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return CGSizeMake(kWidth, kHeight/3.5);
    }else if(indexPath.section==1){
        return CGSizeMake(kWidth*.425, kWidth/2);
    }
    else
    {
        return CGSizeMake(kWidth-1.5*kGap, kHeight/3);

    }
    
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section==0) {
        return UIEdgeInsetsMake(kGap/2, 0, 0, kGap/2);
    } else if (section==1) {
        return UIEdgeInsetsMake(kGap/2, kWidth*0.05, kGap, kWidth*0.05);
    }else{
        return UIEdgeInsetsMake(kGap*.75, kGap*.75, kGap*.75, kGap*.75);
    }
}

#pragma mark <UICollectionViewDelegate>
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return CGSizeMake(kWidth, kHeight/3.2);
    }else if (section == 1){
        return CGSizeMake(kWidth-kGap , kHeight/20);
    }
    return CGSizeZero;
    
}
-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UICollectionReusableView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeaderViewIndentifier forIndexPath:indexPath];
        
        [headerView addSubview:self.cycleScrollView];
        
        NSMutableArray * array = [NSMutableArray new];
        for (carouselModel * model in _dataDict[@"carousel"]) {
            [array addObject:model.image_url];
        }
        
       
        self.cycleScrollView.imageURLStringsGroup = array;
        return headerView;
    }else if (indexPath.section == 1){
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(kGap, 0, kWidth, kHeight/20)];
        UICollectionReusableView * firstView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseFirstSectionIdentifier forIndexPath:indexPath];
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kWidth/2, kHeight/20)];
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(kWidth-5*kGap, 0, 40, kHeight/20)];
        [button setTitle:@"全部" forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [button addTarget:self action:@selector(toStoryAll:) forControlEvents:(UIControlEventTouchUpInside)];
        [view addSubview:button];
        label.text = @"每日精选故事";
        [view addSubview:label];
        [firstView addSubview:view];
        return firstView;
    }
   
    return nil;

}

-(void)toStoryAll:(UIButton*)sender{
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    StoryAllCollectionViewController * story= [StoryAllCollectionViewController shareStoryAllController];
    flowLayout = (UICollectionViewFlowLayout*)story.collectionViewLayout;

    [self.navigationController pushViewController:story animated:YES];
}


// !!!:cell点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        StoryDetail_TableViewController * detail = [[StoryDetail_TableViewController alloc]init];
        
        RecommendModel *  model = [[self.dataDict objectForKey:self.keyAarr[indexPath.section]] objectAtIndex:indexPath.item];
        detail.spot_id = model.spot_id;
        [self.navigationController pushViewController:detail animated:YES];
        
    }else if (indexPath.section ==2){
        
        id obj =[[self.dataDict objectForKey:self.keyAarr[indexPath.section]] objectAtIndex:indexPath.item];
        
        if ([obj isKindOfClass:[travelNoteModel class]]) {
            TourismTableViewController * tourism = [TourismTableViewController new];
            
            tourism.Tourism_id = ((travelNoteModel*)obj).d_Id;
            
            [self.navigationController pushViewController:tourism animated:YES];
        }else{
            ProductWebView * webView = [ProductWebView new];
            webView.urlString = ((ProductModel*)obj).url;
            [self.navigationController pushViewController:webView animated:YES];
        }
    }
}


@end
