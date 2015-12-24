//
//  MountCell.h
//  PullDemo
//
//  Created by 123 on 15/10/28.
//  Copyright © 2015年 haibin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MountCellEntity;

@interface MountCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mountImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;


- (void)resetCellWithEntity:(MountCellEntity *)entity;

@end
