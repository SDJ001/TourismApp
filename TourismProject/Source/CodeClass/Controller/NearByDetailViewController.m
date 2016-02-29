//
//  NearByDetailViewController.m
//  TourismProject
//
//  Created by lanou3g on 16/1/30.
//  Copyright © 2016年 鲁东阳. All rights reserved.
//

#import "NearByDetailViewController.h"
#import "CExpandHeader.h"
#import "NearbyDetailTableViewCell.h"
#import "MapViewController.h"
@interface NearByDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)MapViewController * mapViewController;
@property(nonatomic,strong)UIImageView * imgView;
@property(nonatomic,strong)NSMutableArray * keyArray;
@property(nonatomic,strong)NSMutableArray * valueArray;
@end

@implementation NearByDetailViewController
{
    CExpandHeader * _header;
}
-(MapViewController *)mapViewController{
    if (!_mapViewController) {
        _mapViewController = [MapViewController shareMapManagerControl];
    }return _mapViewController;
}
-(NSMutableDictionary *)dataDict{
    if (!_dataDict) {
        _dataDict = [NSMutableDictionary dictionaryWithObjects:@[@"d_Description",@"address",@"arrival_type",@"opening_time",@"tel"] forKeys:@[@"概况",@"地址",@"到达方式",@"开放时间",@"联系方式"]];
    }return _dataDict;
}
-(NSMutableArray *)valueArray{
    if (!_valueArray) {
        _valueArray = [NSMutableArray new];
        for (int i = 0; i<self.keyArray.count; i++) {
            
            if ([[self.model valueForKey:[self.dataDict objectForKey:self.keyArray[i]]] length]!=0) {
                [_valueArray addObject:self.keyArray[i]];
            }
        }
        
    }return _valueArray;
}
-(NSMutableArray *)keyArray{
    if (!_keyArray) {
        _keyArray = [NSMutableArray arrayWithObjects:@"概况",@"地址",@"到达方式",@"开放时间",@"联系方式", nil];
    }return _keyArray;
}
-(UIImage *)imageWithBgColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}

-(void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationController.navigationBar  setBackgroundImage:[self imageWithBgColor: [ UIColor colorWithRed:1 green:1 blue:1 alpha:0]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[self imageWithBgColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0]]];
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight/3)];
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight/3)];
    
    _imgView.backgroundColor = [UIColor redColor];
    
    customView.backgroundColor = [UIColor cyanColor];
    
    //关键步骤 设置可变化背景view属性
    
    _imgView.autoresizingMask = UIViewAutoresizingFlexibleHeight| UIViewAutoresizingFlexibleWidth;
    
    _imgView.clipsToBounds = YES;
    
    _imgView.contentMode = UIViewContentModeScaleAspectFill;
        [_imgView setImageWithURL:[NSURL URLWithString:_model.cover] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
    

    
    [customView addSubview:_imgView];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NearbyDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    _header = [CExpandHeader expandWithScrollView:_tableView expandView:customView];
    
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    self.tableView.estimatedRowHeight = 10;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    [self.view addSubview:self.tableView];
    
}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView

{
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithBgColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:self.tableView.contentOffset.y / 100]] forBarMetrics:UIBarMetricsDefault];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithBgColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]] forBarMetrics:UIBarMetricsDefault];
    
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *sectionTitle=[self tableView:tableView titleForHeaderInSection:section];
    
    if (sectionTitle==nil) {
        
        return nil;
    }
    
    UIView *sectionView=[[UIView alloc] initWithFrame:CGRectMake(0, 10, kWidth, 20)];
    UILabel *label=[[UILabel alloc] init];
    label.frame=CGRectMake(10, 0, kWidth-10, 20);
    label.backgroundColor=[UIColor clearColor];
    label.font=[UIFont fontWithName:@"Helvetica-Bold" size:14];
    [sectionView addSubview:label];
    label.text=sectionTitle;
    return sectionView;
    
}


-(nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.valueArray[section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.valueArray.count;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([[self tableView:tableView titleForHeaderInSection:indexPath.section] isEqual:@"地址"]) {
        NSSet * set = [NSSet setWithObjects:self.model, nil];
        //进入地图页面
        [self.mapViewController addAnnotations:set];
        self.mapViewController.scale = self.model.scale;
        [self.navigationController pushViewController:self.mapViewController animated:YES];
    }else if ([[self tableView:tableView titleForHeaderInSection:indexPath.section] isEqual:@"联系方式"]){
     
        NearbyDetailTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        //拨打电话
        
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",cell.nameLabel.text];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];

    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NearbyDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[NearbyDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSString * key = [self.valueArray objectAtIndex:indexPath.section];
    
    NSString * value = [self.dataDict objectForKey:key];
    
    cell.nameLabel.text = [self.model valueForKey:value];
 

    return cell;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
