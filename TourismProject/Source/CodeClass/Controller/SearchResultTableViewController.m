//
//  SearchResultTableViewController.m
//  TourismApp
//
//  Created by ShenDeju on 16/1/25.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "SearchResultTableViewController.h"
#import "SearchTripTableViewController.h"
@interface SearchResultTableViewController () <UISearchBarDelegate>
@property(strong,nonatomic) UISearchBar *searchBar;
@property(strong,nonatomic) NSMutableDictionary *dataDcit;
@property(strong,nonatomic) NSMutableArray *placesArr;
@property(strong,nonatomic) NSMutableArray *tripsArr;
@property(strong,nonatomic) NSMutableArray *usersArr;

@end
static NSString *const searchPID = @"searchPIdentifier";
static NSString *const searchTID = @"searchTIdentifier";
static NSString *const searchUID = @"searchUIdentifier";

@implementation SearchResultTableViewController
-(instancetype)initWithStyle:(UITableViewStyle)style{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
     [self getAllData];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 50, 30)];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:button];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(60, 0, kWidth-80, 44)];
    self.searchBar.delegate = self;
    self.searchBar.text = self.keyString;
    [_searchBar setBackgroundColor:[UIColor clearColor]];
    _searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    _searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [[[_searchBar.subviews objectAtIndex:0].subviews objectAtIndex:0] removeFromSuperview];
    [self.navigationController.navigationBar addSubview:self.searchBar];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor cyanColor]];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"searchPTableViewCell" bundle:nil] forCellReuseIdentifier:searchPID];
    [self.tableView registerNib:[UINib nibWithNibName:@"searchTTableViewCell" bundle:nil] forCellReuseIdentifier:searchTID];
    [self.tableView registerNib:[UINib nibWithNibName:@"searchUTableViewCell" bundle:nil] forCellReuseIdentifier:searchUID];
}

-(void) getAllData
{
    self.placesArr = [NSMutableArray array];
    self.tripsArr = [NSMutableArray array];
    self.usersArr = [NSMutableArray array];
    NSString *str = [self.keyString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *strr = [NSString stringWithFormat:@"http://api.breadtrip.com/v2/search/?key=%@&start=0&count=20&data_type=",str];
    self.dataDcit = [NSMutableDictionary dictionary];
    
     [[getSearchData shareGetSearchData] getSearchDataWithUrl:strr Data:^(NSMutableDictionary *dataDict) {
         self.dataDcit = dataDict;
         
         for (NSDictionary *dict in self.dataDcit[@"data"][@"places"]) {
             placeModel *model = [placeModel initWithDictionary:dict];
             [self.placesArr addObject:model];
         }
         for (NSDictionary *dict in self.dataDcit[@"data"][@"trips"]) {
             tripModel *model = [tripModel initWithDictionary:dict];
             [self.tripsArr addObject:model];
         }
         for (NSDictionary *dict in self.dataDcit[@"data"][@"users"]) {
             userModel *model = [userModel initWithDictionary:dict];
             [self.usersArr addObject:model];
         }
         
        
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.tableView reloadData];
         });
     }];
    
}

-(void) backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.placesArr.count;
    }else if (section == 1)
    {
        return self.tripsArr.count;
    }
    else
    {
        return self.usersArr.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        searchPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:searchPID forIndexPath:indexPath];
        placeModel *model = self.placesArr[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:@"destination_64px_1088389_easyicon.net"];
    
        cell.titleLabel.text = model.name;
        NSString *str = model.country[@"name"];
        str = [str stringByAppendingString:model.name];
        cell.addressLabel.text = str;
        return cell;
    }else if (indexPath.section == 1)
    {
        searchTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:searchTID forIndexPath:indexPath];
        tripModel *model = self.tripsArr[indexPath.row];
        [cell.timgView sd_setImageWithURL:[NSURL URLWithString:model.cover_image_1600]];

        cell.ttitleLabel.text = model.name;
        NSString *ways = [model.waypoints stringValue];
        ways = [ways stringByAppendingString:@"足迹"];
        cell.twayLabel.text = ways;
        NSString *str = [model.view_count stringValue];
        NSString *commentS = [model.total_comments_count stringValue];
        str = [str stringByAppendingString:[NSString stringWithFormat:@" 次浏览 / %@喜欢 / %@品论",model.liked_count,commentS]];
        cell.tlikeLabel.text = str;
        return cell;
    }
    else
    {
        searchUTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:searchUID forIndexPath:indexPath];
        userModel *model = self.usersArr[indexPath.row];
        //[cell.uimgView sd_setImageWithURL:[NSURL URLWithString:model.avatar_m]];
        

         [cell.uimgView setImageWithURL:[NSURL URLWithString:model.avatar_m] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
        
        cell.utitleLabel.text = model.name;
        cell.utitleLabel.text = model.name;
        cell.uaddressLabel.text = model.bio;
        return cell;
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 80;
    }else if (indexPath.section == 1)
    {
        return 180;
    }
    else
    {
        return 80;
    }

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kWidth-20, 21)];
        label.text = @"相关地区";
        label.textAlignment = NSTextAlignmentCenter;
        return label;
    }else if (section == 1)
    {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, kWidth-20, 21)];
        [button setTitle:@"相关游记 & 故事集 〉" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        return button;
    }
    else
    {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, kWidth-20, 21)];
        [button setTitle:@"相关面粉 〉" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        return button;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  30;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    self.keyString = searchBar.text;
    [self getAllData];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.tableView endEditing:YES];
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        AllDestinationViewController *destinationVC = [[AllDestinationViewController alloc] init];
        
        placeModel *model = self.placesArr[indexPath.row];
        NSString *str = [model.province[@"url"] substringFromIndex:8];
        destinationVC.urlStr = str;
        destinationVC.locationDict = model.province[@"location"];
        
        destinationVC.title =@"按热门排序";
        UINavigationController *destinationNC = [[UINavigationController alloc] initWithRootViewController:destinationVC];
        
        [self presentViewController:destinationNC animated:YES completion:nil];
    }
    else if (indexPath.section == 1) {
        SearchTripTableViewController * tourism = [SearchTripTableViewController new];
        tripModel *model = self.tripsArr[indexPath.row];
        tourism.Tourism_id = model.tid;
        UINavigationController *tourismNC = [[UINavigationController alloc] initWithRootViewController:tourism];
        [self presentViewController:tourismNC animated:YES completion:nil];
    }
}

@end
