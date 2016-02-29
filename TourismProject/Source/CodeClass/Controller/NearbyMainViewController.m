//
//  NearbyMainViewController.m
//  TourismApp
//
//  Created by lanou3g on 16/1/23.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "NearbyMainViewController.h"
#import "MapViewController.h"

#import "NearbyTableViewController.h"
@interface NearbyMainViewController ()
@property(nonatomic,strong)NSDictionary      * dataDict;
@property(nonatomic,strong)MapViewController * mapController;
@property(nonatomic,strong)NSMutableString   * geoLocationStr;//逆地理编码

@end

@implementation NearbyMainViewController


+(instancetype)shareNerbyMainViewController{
    
    static NearbyMainViewController * main = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!main) {
            main = [NearbyMainViewController new];
            
        }
    });return main;
    
}
-(MapViewController *)mapController{
    if (!_mapController) {
        _mapController = [MapViewController shareMapManagerControl];
    }return _mapController;
}


- (instancetype)init{
    if (self = [super init]) {
        self.titles = [NSMutableArray arrayWithObjects:@"全部",@"景点",@"住宿",@"餐厅",@"休闲娱乐",@"购物", nil];
        self.viewControllerClasses  = [NSMutableArray arrayWithObjects:[NearbyTableViewController class],[NearbyTableViewController class],[NearbyTableViewController class],[NearbyTableViewController class],[NearbyTableViewController class],[NearbyTableViewController class], nil];

        self.keys = [NSMutableArray arrayWithObjects:@"category",@"category",@"category",@"category",@"category",@"category", nil];
        self.values =[NSMutableArray arrayWithObjects:kAllCategory,kScenic,kStay,kRestaurant,kLeisure,kShoping, nil];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"地图" style:(UIBarButtonItemStylePlain) target:self action:@selector(toMapView:)];
    }return self;
}

 //进入地图页面
-(void)toMapView:(UIBarButtonItem*)sender{


    [self.navigationController pushViewController:self.mapController animated:YES];
    
}
 //定位动作

- (void)startLocate{
    
    [self.mapController startLocationWithAccuracy:(kCLLocationAccuracyHundredMeters) MapBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error) {
         

            [(NearbyTableViewController*)self.currentViewController stopGetData];
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"定位失败" message:@"请检查定位权限是否打开" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction * toSetting = [UIAlertAction actionWithTitle:@"去设置" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                
                if([[UIApplication sharedApplication] canOpenURL:url]) {
                    
                    NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    [[UIApplication sharedApplication] openURL:url];
                    
                }
                
            }];
            [alert addAction:cancel];
            [alert addAction:toSetting];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
        if (regeocode) {
            
            if (regeocode.city==NULL) {
                self.geoLocationStr = [NSMutableString stringWithFormat:@"%@%@%@",regeocode.province,regeocode.district,regeocode.township];
                
            }else{
                self.geoLocationStr = [NSMutableString stringWithFormat:@"%@%@%@%@",regeocode.province,regeocode.city,regeocode.district,regeocode.township];
            }
            
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"定位成功" message:self.geoLocationStr preferredStyle:(UIAlertControllerStyleAlert)];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [alert dismissViewControllerAnimated:YES completion:nil];
                
                [UIView animateWithDuration:1 animations:^{
                    self.navigationItem.titleView.alpha = 1;
                    self.navigationItem.title = self.geoLocationStr;
                } completion:^(BOOL finished) {
                    NearbyTableViewController * near = (NearbyTableViewController*)self.currentViewController;
                    [near startReffreshing];

                }];
                
            });
            
            [self presentViewController:alert animated:YES completion:nil];

        }
    }];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getDa:) name:@"statusChange" object:nil];
   
}

-(void)getDa:(NSNotification*)sender{

    if ([[sender.userInfo objectForKey:@"CLAuthorizationStatus"] intValue]==4|[[sender.userInfo objectForKey:@"CLAuthorizationStatus"] intValue]==3) {
      
        [self startLocate];
    }
}
- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"statusChange" object:nil];
}

@end
