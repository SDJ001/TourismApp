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
@property(nonatomic,strong)MBProgressHUD * hud;
@end
static NSString * const tourismDetailReuseIdentifier = @"tourismDetailReuseIdentifier";
@implementation TourismTableViewController
-(DataBaseTool *)tool{
    if (!_tool) {
        _tool = [DataBaseTool shareDataBaseTool];
    }return _tool;
}
-(MBProgressHUD *)hud{
    if (!_hud) {
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
    }return _hud;
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
    if ([self performSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeBottom;
    }

}
-(void)updata{
    if ([self.dataDict count]==0) {
        self.hud.mode = MBProgressHUDModeIndeterminate;
        self.hud.backgroundColor = [UIColor whiteColor];
        self.hud.backgroundView.style = MBProgressHUDBackgroundStyleBlur;
    }
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
        }self.hud.hidden=YES;
        [self.tableView reloadData];
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
    return rect.size.height+20;
   
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIView *fromView = nil;
    NSMutableArray *items = [NSMutableArray new];
    UIView *imgView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    TourismModel * model = [_dataDict objectForKey:_keyArray[indexPath.section]][indexPath.row];
    
    YYPhotoGroupItem *item = [YYPhotoGroupItem new];
    item.thumbView = imgView;
    item.largeImageURL =[NSURL URLWithString:model.photo_1600];
    [items addObject:item];
    YYPhotoGroupView *v = [[YYPhotoGroupView alloc] initWithGroupItems:items];
    
    [v presentFromImageView:fromView toContainer:self.navigationController.view animated:YES completion:nil];

}


@end
