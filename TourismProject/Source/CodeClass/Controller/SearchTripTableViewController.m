//
//  SearchTripTableViewController.m
//  TourismProject
//
//  Created by ShenDeju on 16/2/29.
//  Copyright © 2016年 鲁东阳. All rights reserved.
//

#import "SearchTripTableViewController.h"

@interface SearchTripTableViewController ()
@property(nonatomic,strong)DataBaseTool * tool;
@property(nonatomic,strong)NSMutableDictionary * dataDict;
@property(nonatomic,strong)NSMutableArray * keyArray;
@end
static NSString * const tourismDetailReuseIdentifier = @"tourismDetailReuseIdentifier";
@implementation SearchTripTableViewController

-(DataBaseTool *)tool{
    if (!_tool) {
        _tool = [DataBaseTool shareDataBaseTool];
    }return _tool;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    
    UINib * nib = [UINib nibWithNibName:@"TourismTableViewCell" bundle:nil];
    [self updata];
    [self.tableView registerNib:nib forCellReuseIdentifier:tourismDetailReuseIdentifier];
    _dataDict = [NSMutableDictionary new];
    _keyArray = [NSMutableArray new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 150;
    self.tableView.rowHeight =UITableViewAutomaticDimension;
    
}

-(void)backAction
{
    [self dismissViewControllerAnimated:NO completion:nil];
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

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
