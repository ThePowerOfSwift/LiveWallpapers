//
//  ViewController.m
//  LiveWallpapers
//
//  Created by zihad on 3/15/17.
//  Copyright © 2017 zihad. All rights reserved.
//

#import "LiveWallpaperVC.h"
#import "LiveWallpaperCVCell.h"
#import "ThumbnailCollectionViewCell.h"
#import "LiveWallpaperCatagoryVC.h"
#import <Photos/Photos.h>
#import <PhotosUI/PhotosUI.h>


@interface LiveWallpaperVC ()<UIScrollViewDelegate>
 {
    
    BOOL thumnailVShowOrNot;
    NSInteger indexPathRow;
    LiveWallpaperCVCell *liveWallpapercell;
    ThumbnailCollectionViewCell  *thumbnailCollectionViewCell;
    
}

@property (nonatomic,strong) NSArray *livePhotoMovsArray;
@property (nonatomic,strong) NSArray *livePhotoImagesArray;
@end

@implementation LiveWallpaperVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //[self settingThePositionOfButtonView];
    
    self.bannerView.delegate = self;
    [self bannerViewShow:self.bannerView];
    self.interstitialView.delegate = self;
    self.bannerViewBottomSpace.constant = -50;
    self.thumbnailContainerView.constant =  -70;
    self.thumbnailContainer.layer.borderColor = [UIColor whiteColor].CGColor;
    self.thumbnailContainer.layer.borderWidth = 2.0f;
    

    
    self.navigationController.navigationBar.hidden = true;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _livePhotoMovsArray = [NSArray arrayWithObjects:@"lively_00",@"lively_01",nil];
    
    _livePhotoImagesArray =  [NSArray arrayWithObjects:@"lively_03.JPG",@"lively_03.JPG", nil];
    
    
}

#pragma mark-collection view delegate and datasource-

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.livePhotoMovsArray count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == self.liveWallPaperCoView) {
        
        indexPathRow = indexPath.row;
        NSURL *movUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:[self.livePhotoMovsArray objectAtIndex:indexPath.row] ofType:@"MOV"]];
        
        NSURL *photoUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:[self.livePhotoMovsArray objectAtIndex:indexPath.row] ofType:@"JPG"]];
        
        NSArray *arrayUrl=@[movUrl,photoUrl];
        liveWallpapercell =
        (LiveWallpaperCVCell *)[_liveWallPaperCoView dequeueReusableCellWithReuseIdentifier:@"LiveWallpaperCell" forIndexPath:indexPath];
        liveWallpapercell.tag = indexPath.row;
        
        [PHLivePhoto requestLivePhotoWithResourceFileURLs:arrayUrl placeholderImage:nil targetSize:CGSizeZero contentMode:PHImageContentModeAspectFit resultHandler:^(PHLivePhoto *livePhoto, NSDictionary * info)
         {
             liveWallpapercell.livePhotoView.livePhoto = livePhoto;
             [liveWallpapercell.livePhotoView startPlaybackWithStyle:PHLivePhotoViewPlaybackStyleFull];
             
         }];
        
        UILongPressGestureRecognizer *gestureRecognizer = [[UILongPressGestureRecognizer alloc] init];
        [gestureRecognizer addTarget:self action:@selector(imgLongPressed:)];
        [liveWallpapercell.contentView addGestureRecognizer: gestureRecognizer];

        
    } else  {
        
        thumbnailCollectionViewCell =
        (ThumbnailCollectionViewCell *)[_thumbnailCoV dequeueReusableCellWithReuseIdentifier:@"thumbnailCollectionViewCell" forIndexPath:indexPath];
        
        thumbnailCollectionViewCell.thumbnailImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.JPG",[_livePhotoMovsArray objectAtIndex:indexPath.row]]];
        return thumbnailCollectionViewCell;
        
    }
    

    return liveWallpapercell;
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (collectionView == self.liveWallPaperCoView) {
        
        return CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);

    } else {
        
        return CGSizeMake(self.thumbnailCoV.frame.size.width-10, self.thumbnailCoV.frame.size.height/4);
        
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == _thumbnailCoV)
    {
        [_liveWallPaperCoView setContentOffset:CGPointMake(indexPath.row*CGRectGetWidth(self.view.frame), 0)];
        
       // [_liveWallPaperCoView setContentOffset:CGPointMake(indexPath.row*CGRectGetWidth(self.view.frame), 0) animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
        NSLog(@"callAfterSixtySecond");
    [self callAfterSixtySecond];
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSLog(@"2callAfterSixtySecond");

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"3callAfterSixtySecond");
}



-(void) callAfterSixtySecond {
    

    
    NSArray *visibleItems = [self.liveWallPaperCoView indexPathsForVisibleItems];
    NSIndexPath *currentItem = [visibleItems objectAtIndex:0];
    
        if (currentItem.row == liveWallpapercell.tag) {
            
        [liveWallpapercell.livePhotoView startPlaybackWithStyle:PHLivePhotoViewPlaybackStyleFull];
            
    }
}


#pragma mark-google admob delegate-

-(void)adViewDidReceiveAd:(GADBannerView *)bannerView{
    
    
    [UIView animateWithDuration:0.50f animations:^{
        self.bannerViewBottomSpace.constant = 0;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
        if (finished) {
            
            self.interstitialView = [self createAndLoadInterstitial];
            
        }
    }];
    
}


-(void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error {
    
    [self bannerViewShow:self.bannerView];
}

-(void)interstitialDidReceiveAd:(GADInterstitial *)ad{
    NSLog(@"Ad is Opening%@",ad);
    [self.interstitialView presentFromRootViewController:self];
    
}
-(void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error{
    
    
}







- (IBAction)show:(id)sender {
    
    [self performSegueWithIdentifier:@"ShowWallpaperList" sender:nil];
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"ShowWallpaperList"]) {
        
        LiveWallpaperCatagoryVC *liveWallpaperCatagoryVC = segue.destinationViewController;
        
    }
    
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

- (IBAction)showOrHideThumbnailViewButtonPress:(id)sender {
    
    if (thumnailVShowOrNot) {
        
        [UIView animateWithDuration:0.50f animations:^{
            self.thumbnailContainerView.constant = -70;
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            
            thumnailVShowOrNot = NO;
        }];
        
    } else {
        
        [UIView animateWithDuration:0.50f animations:^{
            self.thumbnailContainerView.constant = 0;
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            
            thumnailVShowOrNot = YES;
            
        }];
        
        
    }
    
}

- (IBAction)saveLivePhoto:(id)sender {
    
        
    
    
    NSURL *movUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:[self.livePhotoMovsArray objectAtIndex:indexPathRow] ofType:@"MOV"]];
    
    NSURL *photoUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:[self.livePhotoMovsArray objectAtIndex:indexPathRow] ofType:@"JPG"]];
    
    

    
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        PHAssetCreationRequest *request = [PHAssetCreationRequest creationRequestForAsset];
        [request addResourceWithType:PHAssetResourceTypePhoto fileURL:photoUrl options:nil];
        [request addResourceWithType:PHAssetResourceTypePairedVideo fileURL:movUrl options:nil];
        
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        
        
        if (success)
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:NSLocalizedString(@"LIVEPHOTOSAVESUCCESS", nil) preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:ok];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else
        {
            NSLog(@"write error : %@",error);
        }

        
        
    }];
    
}

- (IBAction)shareLivePhoto:(id)sender {
    
    NSString * message = @"Live Photo.";

    
    NSURL *photoUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:[self.livePhotoMovsArray objectAtIndex:indexPathRow] ofType:@"JPG"]];
    
    NSArray * shareItems = @[message, photoUrl];
    UIActivityViewController * avc = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
    [self presentViewController:avc animated:YES completion:nil];

}

- (void) imgLongPressed:(UILongPressGestureRecognizer*)sender
{
    if (sender.state == UIGestureRecognizerStateBegan && thumnailVShowOrNot) {
        
        [UIView animateWithDuration:0.50f animations:^{
            self.thumbnailContainerView.constant = -70;
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            
            thumnailVShowOrNot = NO;
        }];
    }
}
@end
