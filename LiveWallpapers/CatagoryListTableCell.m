//
//  CatagoryListTableCell.m
//  LiveWallpapers
//
//  Created by zihad on 3/15/17.
//  Copyright © 2017 zihad. All rights reserved.
//

#import "CatagoryListTableCell.h"

@implementation CatagoryListTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
}


-(void)parallexWithViewPosition:(UITableView *)tableView didScrollOnView:(UIView *)view {
    
    CGRect rectOnSuperView = [tableView convertRect:self.frame toView:view];
    float distanceFromCentre = CGRectGetHeight(view.frame)/2-CGRectGetMinY(rectOnSuperView);
    float difference = CGRectGetHeight(_catagoryImageView.frame)-CGRectGetHeight(self.frame);
    float move = (distanceFromCentre/CGRectGetHeight(view.frame))*difference;
    
    CGRect rectImage = _catagoryImageView.frame;
    rectImage.origin.y = -(difference/2)+move;
    _catagoryImageView.frame = rectImage;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
