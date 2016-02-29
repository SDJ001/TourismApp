//
//  StoryDetailTableViewCell.h
//  TourismApp
//
//  Created by lanou3g on 16/1/25.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoryDetailModel.h"
@interface StoryDetailTableViewCell : UITableViewCell
@property (strong, nonatomic) StoryDetailModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *descripLabel;

@end
