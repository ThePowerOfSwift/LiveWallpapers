//
//  UIViewController+AdSetting.h
//  LiveWallpapers
//
//  Created by zihad on 3/21/17.
//  Copyright © 2017 zihad. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMobileAds;
@class GADBannerView;
@class GADInterstitial;

@interface UIViewController (AdSetting)<GADInterstitialDelegate>

-(void)bannerViewShow:(GADBannerView *)bannerView;
- (GADInterstitial *)createAndLoadInterstitial;

@end
