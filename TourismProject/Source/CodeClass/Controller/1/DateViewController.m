//
//  DateViewController.m
//  TourismProject
//
//  Created by 鲁东阳 on 16/1/27.
//  Copyright © 2016年 鲁东阳. All rights reserved.
//

#import "DateViewController.h"
#import <Foundation/Foundation.h>
@interface DateViewController ()
@property (nonatomic,strong) UIDatePicker * datepicker;
@end

@implementation DateViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
   self.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-30, 180);
    self.view.backgroundColor = [UIColor whiteColor];
    self.datepicker = [[UIDatePicker alloc] init];
    self.datepicker.datePickerMode = UIDatePickerModeDate;
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文
    self.datepicker.locale = locale;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];//设置输出的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    
    
    [self.datepicker addTarget:self action:@selector(dickerAction:) forControlEvents:(UIControlEventValueChanged)];
    
    
    
    
    [self.view addSubview:self.datepicker];
    
    self.view.layer.masksToBounds = YES;
    self.view.layer.cornerRadius = 10;
}
- (void)dickerAction:(UIDatePicker *)sender{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(selectDate:)]) {
        [self.delegate selectDate:sender.date];
        
    }
   
    
  
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
