//
//  LiveWallpaperCatagoryVC.h
//  LiveWallpapers
//
//  Created by zihad on 3/15/17.
//  Copyright © 2017 zihad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+AdSetting.h"
@protocol DelegateForTransferData <NSObject>

@optional

-(void) catagoryName:(NSString *)catagoryName withItemList:(NSArray *)itemList;

@end


@interface LiveWallpaperCatagoryVC : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *catagoryListTableview;
@property (strong, nonatomic) IBOutlet GADInterstitial *interstitialView;
@property(nonatomic,weak) id<DelegateForTransferData> delegate;

- (IBAction)backButtonPress:(id)sender;

@end
