//
//  TourismTableViewController.m
//  TourismApp
//
//  Created by lanou3g on 16/1/19.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "TourismTableViewController.h"

@interface TourismTableViewController ()
@property(nonatomic,strong)DataBaseTool * tool;
@property(nonatomic,strong)NSMutableDictionary * dataDict;
@property(nonatomic,strong)NSMutableArray * keyArray;
@end
static NSString * const tourismDetailReuseIdentifier = @"tourismDetailReuseIdentifier";
@implementation TourismTableViewController
-(DataBaseTool *)tool{
    if (!_tool) {
        _tool = [DataBaseTool shareDataBaseTool];
    }return _tool;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UINib * nib = [UINib nibWithNibName:@"TourismTableViewCell" bundle:nil];
     [self updata];
    [self.tableView registerNib:nib forCellReuseIdentifier:tourismDetailReuseIdentifier];
    _dataDict = [NSMutableDictionary new];
    _keyArray = [NSMutableArray new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 150;
    self.tableView.rowHeight =UITableViewAutomaticDimension;

}
-(void)updata{
    [self.tool getdataSourceByTourism_id:self.Tourism_id passData:^(NSDictionary *dict,NSError*error) {
        NSArray * array = dict[@"days"];
        NSInteger i = 0;
        for (NSDictionary * dic in array) {
            NSArray * arr = dic[@"waypoints"];
            NSMutableArray * dayArray = [NSMutableArray new];
            for (NSDictionary *waypointsDict in arr) {
                TourismModel * model = [TourismModel initWithDictionary:waypointsDict];
                [dayArray addObject:model];
            }[_dataDict setObject:dayArray forKey:[NSString stringWithFormat:@"%ld",i]];
        
            [_keyArray addObject:[NSString stringWithFormat:@"%ld",i]];
                i++;
        }[self.tableView reloadData];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TourismModel * model = [_dataDict objectForKey:_keyArray[indexPath.section]][indexPath.row];

    
    CGRect  rect = [model.text boundingRectWithSize:CGSizeMake(kWidth-20, 10000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    
    CGFloat scale = [model.photo_info[@"h"]floatValue]/[model.photo_info[@"w"]floatValue];

    if (!isnan(scale)) {
       
        return  rect.size.height+(kWidth-20)*scale+20;
    }
    return rect.size.height+30;
   
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return _keyArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [[_dataDict objectForKey:_keyArray[section]] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     TourismTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:tourismDetailReuseIdentifier forIndexPath:indexPath];
    TourismModel * model = [_dataDict objectForKey:_keyArray[indexPath.section]][indexPath.row];
    ;
    cell.model = model;
    
    return cell;
}



@end
