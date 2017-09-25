//
//  LiveWallpaperCVCell.h
//  LiveWallpapers
//
//  Created by zihad on 3/15/17.
//  Copyright © 2017 zihad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import <PhotosUI/PhotosUI.h>

@interface LiveWallpaperCVCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet PHLivePhotoView *livePhotoView;


@end
