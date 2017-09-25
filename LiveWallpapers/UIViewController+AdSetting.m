//
//  UIViewController+AdSetting.m
//  LiveWallpapers
//
//  Created by zihad on 3/21/17.
//  Copyright © 2017 zihad. All rights reserved.
//

#import "UIViewController+AdSetting.h"

@implementation UIViewController (AdSetting)

-(void)bannerViewShow:(GADBannerView *)bannerView {
    
    bannerView.adUnitID = @"ca-app-pub-4643560943003002/7864273977";
    bannerView.rootViewController = self;
    
    GADRequest *request = [GADRequest request];
    //request.testDevices = @[@"2077ef9a63d2b398840261c8221a0c9a"];
    [bannerView loadRequest:request];
    
}

- (GADInterstitial *)createAndLoadInterstitial {
    GADInterstitial *interstitial = [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-4643560943003002/8143475575"];
    interstitial.delegate = self;
        
    GADRequest *request= [GADRequest request];
    request.testDevices = @[@"2077ef9a63d2b398840261c8221a0c9a"];
//    UIDevice *currentDevice = [UIDevice currentDevice];
//    
//    NSString *deviceId = [[currentDevice identifierForVendor] UUIDString];
    
    [interstitial loadRequest:request];
    return interstitial;
}




@end
