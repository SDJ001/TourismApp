//
//  AllDestinationViewController.m
//  TourismProject
//
//  Created by ShenDeju on 16/2/26.
//  Copyright © 2016年 鲁东阳. All rights reserved.
//

#import "AllDestinationViewController.h"

@interface AllDestinationViewController ()
//@property(strong,nonatomic) NSArray *controllerClasses;
//@property(nonatomic,strong) NSArray *titleArray;
@end

@implementation AllDestinationViewController
-(instancetype) init
{
    if (self = [super init]) {
        
        self.titles = @[@"全部",@"景点",@"住宿",@"餐厅",@"休闲娱乐",@"购物"];
        self.viewControllerClasses = @[[AllDestinationTableViewController class],[AllDestinationTableViewController class],[AllDestinationTableViewController class],[AllDestinationTableViewController class],[AllDestinationTableViewController class],[AllDestinationTableViewController class]];

        self.menuViewStyle = WMMenuViewStyleLine;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *urlStrr = [NSString stringWithFormat:@"http://api.breadtrip.com/destination/place/%@pois/all/?start=0&count=20&sort=default&shift=false&latitude=%@&longitude=%@",self.urlStr,self.locationDict[@"lat"],self.locationDict[@"lng"]];

    NSString *all = [NSString stringWithString:urlStrr];
    NSString *secencey = [NSString stringWithString:urlStrr];
    NSString *hotel = [urlStrr stringByReplacingOccurrencesOfString:@"all" withString:@"hotel"];
    NSString *restaurant = [urlStrr stringByReplacingOccurrencesOfString:@"all" withString:@"restaurant"];
    NSString *experience = [urlStrr stringByReplacingOccurrencesOfString:@"all" withString:@"experience"];
    NSString *mall = [urlStrr stringByReplacingOccurrencesOfString:@"all" withString:@"mall111"];
    
   
    self.keys = [NSMutableArray arrayWithObjects:@"category",@"category",@"category",@"category",@"category",@"category", nil];
  
    self.values = [NSMutableArray arrayWithObjects:all,secencey,hotel,restaurant,experience,mall, nil];
    [self.currentViewController setValue:all forKey:@"category"];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return_30.521739130435px_1157313_easyicon.net"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];

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

@end
