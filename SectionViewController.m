//
//  SectionViewController.m
//  TourismProject
//
//  Created by 鲁东阳 on 16/1/17.
//  Copyright © 2016年 鲁东阳. All rights reserved.
//

#import "SectionViewController.h"
#import "NSDictionary-DeepMutableCopy.h"
@interface SectionViewController ()

@end

@implementation SectionViewController
@synthesize names;
@synthesize keys;
@synthesize tableView;
@synthesize search;
@synthesize allNames;

- (void)resetSearch
{
    NSMutableDictionary * allNamesCopy = [self.allNames mutableDeepCopy];
    self.names = allNamesCopy;
    NSMutableArray * keyArray = [[NSMutableArray alloc] init];
    [keyArray addObject:UITableViewIndexSearch];
    [keyArray addObjectsFromArray:[[self.allNames allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    self.keys = keyArray;
    
    
}
- (void)handleSearchForTerm:(NSString *)searchTerm
{
//    NSMutableArray * sectionsToremove = [[NSMutableArray alloc] init];
//    [self resetSearch];
//    for (NSString * key in self.keys) {
//        NSMutableArray * array = [self.names valueForKey:key];
//        NSMutableArray * toremove = [NSMutableArray array];
//        
//        for (NSString * name in array) {
//            if ([name rangeOfString:searchTerm options:NSCaseInsensitiveSearch].location == NSNotFound) {
//                [toremove addObject:name];
//            }
//            if ([array count]== [toremove count]) {
//                [sectionsToremove addObject:key];
//                [array removeObjectsInArray:sectionsToremove];
//            }
//            [self.keys removeObjectsInArray:sectionsToremove];
//            [self.tableView reloadData];
//        }
//    }
    
    NSMutableArray *sectionsToRemove = [[NSMutableArray alloc] init];
    [self resetSearch];
    
    for (NSString *key in self.keys) {
        NSMutableArray *array = [names valueForKey:key];
        NSMutableArray *toRemove = [[NSMutableArray alloc] init];
        for (NSString *name in array) {
            if ([name rangeOfString:searchTerm
                            options:NSCaseInsensitiveSearch].location == NSNotFound)
                [toRemove addObject:name];
        }
        if ([array count] == [toRemove count])
            [sectionsToRemove addObject:key];
        [array removeObjectsInArray:toRemove];
    }
    [self.keys removeObjectsInArray:sectionsToRemove];
    [self.tableView reloadData];
    
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat statusBarHeight = 0;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
    {
        statusBarHeight = 20;
    }
    
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0,0+statusBarHeight, self.view.frame.size.width, 44)];
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:@""];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(LeftButton)];
    
    [navigationItem setTitle:@"选取国家"];
    [navigationBar pushNavigationItem:navigationItem animated:NO];
    [navigationItem setLeftBarButtonItem:leftButton];
    [self.view addSubview:navigationBar];
   
    self.search = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 44+statusBarHeight, self.view.frame.size.width, 44)];
    [self.view addSubview:self.search];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 88+statusBarHeight, self.view.frame.size.width, self.view.bounds.size.height - (statusBarHeight+88)) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.search.delegate = self;
    
    [self.view addSubview:self.tableView];
    NSString * path = [[NSBundle mainBundle] pathForResource:@"country" ofType:@"plist"];
    NSDictionary * dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    self.allNames = dict;
    
    [self resetSearch];
    [self.tableView reloadData];
    
    
    
    
}

//左button
- (void)LeftButton
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
 
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return [self.keys count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ([self.keys count] == 0)
        return 0;
    
    NSString *key = [self.keys objectAtIndex:section];
    NSArray *nameSection = [self.names objectForKey:key];
    return [nameSection count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = [indexPath section];
    NSString *key = [self.keys objectAtIndex:section];
    NSArray *nameSection = [self.names objectForKey:key];
    
    static NSString *SectionsTableIdentifier = @"SectionsTableIdentifier";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:
                             SectionsTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier: SectionsTableIdentifier ];
    }
    
    NSString* str1 = [nameSection objectAtIndex:indexPath.row];
    NSRange range = [str1 rangeOfString:@"+"];
    NSString* str2 = [str1 substringFromIndex:range.location];
    NSString* areaCode = [str2 stringByReplacingOccurrencesOfString:@"+" withString:@""];
    NSString* countryName = [str1 substringToIndex:range.location];
    
    cell.textLabel.text = countryName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"+%@",areaCode];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([self.keys count]==0)
        return nil;
        NSString * key = [self.keys objectAtIndex:section];
        if (key == UITableViewIndexSearch)
            return nil;
      
        return key;
        

}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
       return self.keys;
    
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.search resignFirstResponder];
    self.search.text = @"";
    self.isSearching = NO;
    [self.tableView reloadData];
    return indexPath;
}

#pragma mark --- SearchBar Delegate
//搜索事件
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString * search = [searchBar text];
    [self handleSearchForTerm:search];
  
}
//点击搜索框时调用
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.isSearching = YES;
    [self.tableView reloadData];
    
}
//输入文本时更新时调用
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    if ([searchText length] ==0) {
        [self resetSearch];
        [self.tableView reloadData];
        return;
    }
    [self handleSearchForTerm:searchText];
    NSLog(@"%@",searchText);
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
