//
//  NearbyTableViewController.m
//  TourismApp
//
//  Created by lanou3g on 16/1/23.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "NearbyTableViewController.h"
#import "MapViewController.h"
#import "NearByDetailViewController.h"
#import <math.h>
@interface NearbyTableViewController ()
@property(nonatomic,strong)DataBaseTool * tool;
@property(nonatomic,assign)NSUInteger dataIndex;
@property(nonatomic,strong)MapViewController * mapViewController;
@property(nonatomic,assign)double  meter;
//逆地理编码
@property(nonatomic,strong)NSMutableString * geoLocationStr;
@end
static NSString * const reusedNearByTableCell = @"reusedNearByTableCell";

@implementation NearbyTableViewController
-(MapViewController *)mapViewController{
    if (!_mapViewController) {
        _mapViewController = [MapViewController shareMapManagerControl];
    }return _mapViewController;
}

-(DataBaseTool *)tool{
    if (!_tool) {
        _tool = [DataBaseTool shareDataBaseTool];
    }return _tool;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setToolbarHidden:YES animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataIndex = 1;
    UINib * nib = [UINib nibWithNibName:@"NearbyTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:reusedNearByTableCell];

    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;

    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getDataWithCategory];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self getMoreDataWithCategory:self.category WithDataIndex:self.dataIndex];
    }];

    _dataDict  = [NSMutableDictionary new];
    _keyArray  = [NSMutableArray new];
    [self.tableView.mj_header beginRefreshing];

}
-(void)viewDidAppear:(BOOL)animated{
    if (self.keyArray.count==0) {
        self.tableView.mj_footer.hidden = YES;
    }else{
        self.tableView.mj_footer.hidden = NO;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat
{
    return 150;
}
//开始下载数据
-(void)startReffreshing{
    if ([self.tableView.mj_header isRefreshing]==YES) {
        [self.tableView.mj_header endRefreshing];
        
    }
    [self.tableView.mj_header beginRefreshing];
}
//根据类型获取数据,传入类型(如果定位失败那么继续定位(定位成功后自动下载数据),如果定位成功那么下载数据)
-(void)getDataWithCategory{
    
    if (self.mapViewController.mapView.userLocation.location==NULL) {
      
        NearbyMainViewController* main = (NearbyMainViewController*)self.parentViewController;
        NSLog(@"定位失败,开始定位");
        [main startLocate];
    }else{
        NSLog(@"定位成功");
        NSMutableDictionary * dic1 = [NSMutableDictionary new];
        NSMutableArray * key = [NSMutableArray new];
        [self.tool getDtaWithCategory:self.category location:self.mapViewController.mapView.userLocation.location passData:^(NSDictionary *dict,NSError*error) {
            NSArray * dataArray = dict[@"items"];
            for (NSDictionary * dic in dataArray) {
                
                NearByModel * model  = [NearByModel initWithDictionary:dic];
                
                float scale  = sqrt ( fabs ( powf(self.mapViewController.mapView.userLocation.location.coordinate.latitude - [model.location[@"lat"] floatValue], 2) -  powf(self.mapViewController.mapView.userLocation.location.coordinate.longitude - [model.location[@"lng"] floatValue] , 2)));
                
                
                model.scale = scale;
                [dic1 setValue:model forKey:model.name];
                [key addObject:model.name];
                
            }
            _dataDict = dic1;
            _keyArray = key;
            
            [self.tableView.mj_header endRefreshing];
            self.tableView.mj_footer.hidden = NO;
            [self.tableView reloadData];
        }];
        
    }
    
}
-(void)stopGetData{
    [self.tableView.mj_header endRefreshing];
    
}
//获取更多数据
-(void)getMoreDataWithCategory:(NSNumber*)category WithDataIndex:(NSInteger)dataIndex{

    if (_keyArray.count==0) {
      
        [self getDataWithCategory];
        return;
    }
    
    [self.tool getDtaWithCategory:category location:self.mapViewController.mapView.userLocation.location dataIndex:self.dataIndex passData:^(NSDictionary *dict,NSError * error) {
       
        
        NSArray * dataArray = dict[@"items"];


        for (NSDictionary * dic in dataArray) {
     
            NearByModel * model  = [NearByModel initWithDictionary:dic];
            if ([_dataDict objectForKey:model.name]==nil ) {
                [_dataDict setObject:model forKey:model.name];
                [_keyArray addObject:model.name];
                
            }
            
        }

        self.dataIndex++;
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _keyArray.count;
}

 //cell重用
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NearbyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedNearByTableCell forIndexPath:indexPath];

    NearByModel * model = [_dataDict objectForKey:_keyArray[indexPath.row]];
   [cell.imgView setImageWithURL:[NSURL URLWithString:model.cover] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];

    cell.nameLabel.text = model.name;
    cell.descripLabel.text = model.d_Description;
    NSUInteger  meter =  model.scale*111000;
    cell.popularityLabel.text = [NSString stringWithFormat:@"%@",model.popularity];
    if (meter>1000) {
         cell.instanceLabel.text = [NSString stringWithFormat:@"距我%luK米",(unsigned long)meter/1000];
    }else{
         cell.instanceLabel.text = [NSString stringWithFormat:@"距我%lu米",(unsigned long)meter];
    }
  
    return cell;
}
 //点击cell进入详情界面
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NearByModel * model = [_dataDict objectForKey:_keyArray[indexPath.row]];
    NearByDetailViewController * detail = [[NearByDetailViewController alloc]init];
    detail.model = model;
    [self.navigationController pushViewController:detail animated:YES];

}
@end
