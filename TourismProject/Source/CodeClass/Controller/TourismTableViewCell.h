//
//  TourismTableViewCell.h
//  TourismApp
//
//  Created by lanou3g on 16/1/19.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TourismModel.h"
@interface TourismTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property(nonatomic,strong) TourismModel * model;

@end
