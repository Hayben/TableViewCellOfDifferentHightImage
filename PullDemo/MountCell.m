//
//  MountCell.m
//  PullDemo
//
//  Created by 123 on 15/10/28.
//  Copyright © 2015年 haibin. All rights reserved.
//

#import "MountCell.h"
#import "MountCellEntity.h"
#import "UIImageView+WebCache.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
@implementation MountCell

- (void)awakeFromNib {
}

- (void)resetCellWithEntity:(MountCellEntity *)entity{
    if ([entity.imageURL isEqualToString:@""]) {
        self.nameLabel.text = @"无图";
        self.mountImageView.image = nil;
    }else{
        self.nameLabel.text = @"有图";
        
        [self.mountImageView sd_setImageWithURL:[NSURL URLWithString:entity.imageURL]];
        
        NSDictionary *dict = entity.dict;
        
        float height =[dict[@"upfile_height"] floatValue];
        float width = [dict[@"upfile_width"] floatValue];
        
        CGRect frame = self.frame;
        frame.size.height = height*SCREEN_WIDTH/width;
        self.frame = frame;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
