//
//  AllDestinationTableViewController.m
//  TourismProject
//
//  Created by ShenDeju on 16/2/26.
//  Copyright © 2016年 鲁东阳. All rights reserved.
//

#import "AllDestinationTableViewController.h"

@interface AllDestinationTableViewController ()
@property(nonatomic,strong) CWStarRateView *starRateView;
@property(nonatomic,strong) NSMutableArray *dataArray;
@property(nonatomic,strong) NSMutableArray *moreData;
@end
static NSString *const tableViewID = @"allDestinationTableViewCellIdentifier";
NSInteger numbers = 1;
@implementation AllDestinationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"AllDestinationTableViewCell" bundle:nil] forCellReuseIdentifier:tableViewID];
    [self getdata];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getNewData];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self getMoreData];
    }];
    [self.tableView.mj_header beginRefreshing];
}

-(void)viewWillAppear:(BOOL)animated
{
//    [self getdata];
  
}
-(void) getdata
{
    if (self.dataArray.count !=0) {
        
    }else
    {
        self.dataArray = [NSMutableArray array];
        [[getMoreCityTools shareGetMoreCityTools]getAllCityWithUrl:self.category CityData:^(NSMutableArray *AllCity) {
            self.dataArray = AllCity;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }];
    }
}

-(void) getNewData
{
    self.dataArray = [NSMutableArray array];
    [[getMoreCityTools shareGetMoreCityTools]getAllCityWithUrl:self.category CityData:^(NSMutableArray *AllCity) {
        self.dataArray = AllCity;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        });
    }];

}
-(void) getMoreData
{
    NSString *str = self.category;
    NSString *numberStr = [NSString stringWithFormat:@"start=%ld",numbers*20];
    str = [str stringByReplacingOccurrencesOfString:@"start=0" withString:numberStr];
    self.moreData = [NSMutableArray array];
    
    [[getMoreCityTools shareGetMoreCityTools] getAllCityWithUrl:str CityData:^(NSMutableArray *AllCity) {
        self.moreData = AllCity;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.dataArray addObjectsFromArray:self.moreData];
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
        });
    }];
    numbers++;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AllDestinationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewID forIndexPath:indexPath];
    NearByModel *model = self.dataArray[indexPath.row];
    [cell.imgView yy_setImageWithURL:[NSURL URLWithString:model.cover] options:YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation ];
    cell.cityLabel.text = model.name;
    
    self.starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(0, 0, 100, 18) numberOfStars:5];
    self.starRateView.scorePercent=[model.rating doubleValue]/5.0;
    self.starRateView.allowIncompleteStar = YES;
    self.starRateView.hasAnimation = YES;
    [cell.starImgView addSubview:self.starRateView];
    cell.scoreLabel.text = [NSString stringWithFormat:@"%@ 点评",model.tips_count];
    cell.commentLabel.text = model.recommended_reason;
    NSString *strr = [NSString stringWithFormat:@"%@ 人去过",model.visited_count];
    cell.numberLabel.text =strr;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  150;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
