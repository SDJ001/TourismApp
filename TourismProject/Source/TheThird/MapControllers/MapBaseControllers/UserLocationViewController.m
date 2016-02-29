//
//  UserLocationViewController.m
//  Category_demo
//
//  Created by songjian on 13-3-21.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import "UserLocationViewController.h"

@interface UserLocationViewController ()

@property (nonatomic, retain)UISegmentedControl *showSegment;

@property (nonatomic, retain)UISegmentedControl *modeSegment;

@end

@implementation UserLocationViewController
@synthesize showSegment, modeSegment;

#pragma mark - MAMapViewDelegate

- (void)mapView:(MAMapView *)mapView didChangeUserTrackingMode:(MAUserTrackingMode)mode animated:(BOOL)animated
{
    self.modeSegment.selectedSegmentIndex = mode;
}

#pragma mark - Action Handle

- (void)showsSegmentAction:(UISegmentedControl *)sender
{
    self.mapView.showsUserLocation = !sender.selectedSegmentIndex;
}

- (void)modeAction:(UISegmentedControl *)sender
{
    self.mapView.userTrackingMode = sender.selectedSegmentIndex;
}

#pragma mark - NSKeyValueObservering

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"showsUserLocation"])
    {
        NSNumber *showsNum = [change objectForKey:NSKeyValueChangeNewKey];
        
        self.showSegment.selectedSegmentIndex = ![showsNum boolValue];
    }
}

#pragma mark - Initialization

- (void)initToolBar
{
    UIBarButtonItem *flexble = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                             target:nil
                                                                             action:nil];
    
    self.showSegment = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Start", @"Stop", nil]];

    [self.showSegment addTarget:self action:@selector(showsSegmentAction:) forControlEvents:UIControlEventValueChanged];
    self.showSegment.selectedSegmentIndex = 0;
    UIBarButtonItem *showItem = [[UIBarButtonItem alloc] initWithCustomView:self.showSegment];
    
    self.modeSegment = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"None", @"Follow", @"Head", nil]];
 
    [self.modeSegment addTarget:self action:@selector(modeAction:) forControlEvents:UIControlEventValueChanged];
    self.modeSegment.selectedSegmentIndex = 1;
    UIBarButtonItem *modeItem = [[UIBarButtonItem alloc] initWithCustomView:self.modeSegment];
    
    self.toolbarItems = [NSArray arrayWithObjects:flexble, showItem, flexble, modeItem, flexble, nil];
}

- (void)initObservers
{
    /* Add observer for showsUserLocation. */
    [self.mapView addObserver:self forKeyPath:@"showsUserLocation" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)returnAction
{
    [super returnAction];
    
 
}

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];

}
+(instancetype)shareUserLocation{
    static UserLocationViewController * location = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!location) {
            location = [[UserLocationViewController alloc]init];
        }
    });return location;
}
-(instancetype)init{
    if (self = [super init]) {
        self.mapView.showsUserLocation = YES;
        [self initToolBar];
        [self initObservers];
        [self.mapView setCompassImage:[UIImage imageNamed:@"compass"]];
        self.modeSegment.selectedSegmentIndex = 1;
        
    }return self;
}

-(void)viewDidAppear:(BOOL)animated{
      self.mapView.userTrackingMode = MAUserTrackingModeFollow;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.toolbar.barStyle      = UIBarStyleBlack;
    self.navigationController.toolbar.translucent   = YES;
    [self.navigationController setToolbarHidden:NO animated:animated];

}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.mapView setCompassImage:nil];
}

@end
