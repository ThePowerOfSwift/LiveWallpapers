//
//  CatagoryListTableCell.h
//  LiveWallpapers
//
//  Created by zihad on 3/15/17.
//  Copyright © 2017 zihad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CatagoryListTableCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *catagoryImageView;

-(void)parallexWithViewPosition:(UITableView *)tableView didScrollOnView:(UIView *)view;

@end
