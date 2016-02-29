//
//  AllDestinationTableViewCell.h
//  TourismProject
//
//  Created by ShenDeju on 16/2/26.
//  Copyright © 2016年 鲁东阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllDestinationTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;
@property (strong, nonatomic) IBOutlet UIImageView *starImgView;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *commentLabel;
@property (strong, nonatomic) IBOutlet UILabel *numberLabel;

@end
