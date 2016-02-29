//
//  StoryDetail_TableViewController.m
//  TourismApp
//
//  Created by lanou3g on 16/1/25.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "StoryDetail_TableViewController.h"

@interface StoryDetail_TableViewController ()
@property(nonatomic,strong)DataBaseTool * tool;
@property(nonatomic,strong)NSDictionary * dataDict;
@property(nonatomic,strong)NSDictionary * scaleDict;
@property(nonatomic,strong)UICollectionViewFlowLayout * flowLayout;
@property(nonatomic,strong)NSMutableDictionary * footerDict;
@end
static NSString * const reuseStoryDetailIdentifier = @"reuseStoryDetailIdentifier";
@implementation StoryDetail_TableViewController
-(NSDictionary *)dataDict{
    if (!_dataDict) {
        _dataDict = [NSMutableDictionary new];
    }return _dataDict;
}
-(DataBaseTool *)tool{
    if (!_tool) {
        _tool = [DataBaseTool shareDataBaseTool];
    }return _tool;
}
// !!!:下载数据
- (void)updata{
    NSMutableArray * detailArr = [NSMutableArray new];
    [self.tool getdataSourceBySpot_id:self.spot_id passData:^(NSDictionary *dict,NSError * error) {
        
        NSDictionary * storyDict = dict[@"data"];
        [_footerDict setValue:storyDict[@"trip"][@"name"] forKey:@"name"];
        [_footerDict setValue:storyDict[@"trip"][@"date_added"] forKey:@"date"];
        NSDictionary * spotDict = storyDict[@"spot"];
        NSArray * detail_listArray = spotDict[@"detail_list"];
        
        for (NSDictionary * dic in detail_listArray) {
            StoryDetailModel * model = [StoryDetailModel initWithDictionary:dic];
            
            [detailArr addObject:model];
        }
        [self.dataDict setValue:detailArr forKey:@"detail_list"];
        
        StoryTripModel * model = [StoryTripModel initWithDictionary:storyDict[@"trip"]];
        model.text = spotDict[@"text"];
        [self.dataDict setValue:model forKey:@"trip"];
        
        
        _flowLayout.headerReferenceSize = CGSizeMake(10, 10);
        [self.tableView reloadData];
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UINib * nib = [UINib nibWithNibName:@"StoryDetailTableViewCell" bundle:nil];
    [self updata];
    [self.tableView registerNib:nib forCellReuseIdentifier:reuseStoryDetailIdentifier];
    _dataDict = [NSMutableDictionary new];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 10;
    self.tableView.rowHeight =UITableViewAutomaticDimension;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    StoryDetailModel * model = [self.dataDict objectForKey:@"detail_list"][indexPath.item];
    
    
    CGFloat scale  = [model.photo_width floatValue]/[model.photo_height floatValue];
    CGRect  rect = [model.text boundingRectWithSize:CGSizeMake(kWidth-2*kGap, 10000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    
    
    if (!isnan(scale)) {
        
        return (kWidth-kGap)/scale+rect.size.height;
        
    }
    return rect.size.height+30;
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[self.dataDict objectForKey:@"detail_list"] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StoryDetailTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:reuseStoryDetailIdentifier forIndexPath:indexPath];
    StoryDetailModel * model = [self.dataDict objectForKey:@"detail_list"][indexPath.item];
   
    cell.model = model;
    
    return cell;
}

@end
