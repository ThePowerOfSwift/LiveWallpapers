//
//  ViewController.h
//  LiveWallpapers
//
//  Created by zihad on 3/15/17.
//  Copyright © 2017 zihad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+AdSetting.h"
#import "LiveWallpaperCatagoryVC.h"

@import GoogleMobileAds;
@class GADBannerView;
@class GADInterstitial;

@interface LiveWallpaperVC : UIViewController <GADBannerViewDelegate,UIScrollViewDelegate,DelegateForTransferData>

@property (strong, nonatomic) IBOutlet GADBannerView *bannerView;
@property (strong, nonatomic) IBOutlet GADInterstitial *interstitialView;

@property (strong, nonatomic) IBOutlet UIView *thumbnailContainer;

@property (strong, nonatomic) IBOutlet UICollectionView *thumbnailCoV;
@property (strong, nonatomic) IBOutlet UILabel *catagoryNameLabel;
@property (strong, nonatomic) IBOutlet UICollectionView *liveWallPaperCoView;

- (IBAction)show:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *buttonContainerView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bannerViewBottomSpace;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *thumbnailContainerView;
- (IBAction)showOrHideThumbnailViewButtonPress:(id)sender;
- (IBAction)saveLivePhoto:(id)sender;
- (IBAction)shareLivePhoto:(id)sender;


@end

