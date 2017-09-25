//
//  LiveWallpaperCatagoryVC.m
//  LiveWallpapers
//
//  Created by zihad on 3/15/17.
//  Copyright © 2017 zihad. All rights reserved.
//

#import "LiveWallpaperCatagoryVC.h"
#import "CatagoryListTableCell.h"


@interface LiveWallpaperCatagoryVC ()

@property (strong,nonatomic) NSArray *photosArray;

@property(nonatomic,strong) UIView *selectedCellView;

@property(nonatomic,strong) UIImageView *selectedCellImageView;


@end

@implementation LiveWallpaperCatagoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
  //  self.navigationController.navigationBar.hidden = NO;

    //self.automaticallyAdjustsScrollViewInsets = NO;

    
    NSDictionary *photosDict = [NSDictionary dictionaryWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"Photos" withExtension:@"plist"]];
   // self.photosArray = photosDict[@"photos"];
    
     _photosArray = [NSArray arrayWithObjects:@"w1.jpg",@"w2.jpg",@"w4.jpg",@"w5.jpg",@"w6.jpg",@"w7.jpg",@"w9.jpg",@"w10.jpg" ,nil];
    
    
    _selectedCellView=[[UIView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width,self.view.frame.size.height)];
    _selectedCellView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_selectedCellView];
    _selectedCellView.hidden=YES;
    self.interstitialView = [self createAndLoadInterstitial];

}


-(void)interstitialDidReceiveAd:(GADInterstitial *)ad{
    NSLog(@"Ad is Opening%@",ad);
    [self.interstitialView presentFromRootViewController:self];
    
}
-(void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error{
    
    
    // NSLog(@"%@",error.localizedDescription);
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.photosArray count];
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CatagoryListTableCell *cell=(CatagoryListTableCell *)[_catagoryListTableview dequeueReusableCellWithIdentifier:@"CatagoryListCell"];
    
   // NSDictionary *photo = self.photosArray[indexPath.item];
   // NSString *photoFilename = photo[@"photosname"];
   // NSString *title=photo[@"title"];
   // NSInteger numberofimage=[photo[@"imageArray"] count];
    
   // cell.CatagoryName.text=title;
   // cell.numberOfImageInCatagory.text=[NSString stringWithFormat:@"%ld", (long)numberofimage];
    cell.catagoryImageView.image = [UIImage imageNamed:[_photosArray objectAtIndex:indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.frame.size.height/3;
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSArray *visibleCells=[self.catagoryListTableview visibleCells];
    //    for (CatagoryTableCellTableViewCell *cell in visibleCells) {
    //        [cell adjust:(cell.frame.origin.y - scrollView.contentOffset.y)];
    //
    //    }
    for (CatagoryListTableCell *cell in visibleCells) {
        [cell parallexWithViewPosition:_catagoryListTableview didScrollOnView:self.view];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *photo = self.photosArray[indexPath.item];
    NSLog(@"%@",photo);
  //  [self.delegate didSelectedItemInCatagory:photo];
    _selectedCellView.hidden=NO;

    _selectedCellImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width,self.view.frame.size.height)];
    // _selectedCellImageView.image=cell.liveWallpaperCategoryImageView.image;//[UIImage imageNamed:[thunbnailCategoriesArray objectAtIndex:indexPath.row]];
   // [_selectedCellImageView sd_setImageWithURL:[NSURL URLWithString:[thumbnailsUrlArray objectAtIndex:indexPath.row]]];
    
    _selectedCellImageView.image = [UIImage imageNamed:[_photosArray objectAtIndex:indexPath.row]];
    
    [UIView transitionWithView:_selectedCellView
                      duration:2.50
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [_selectedCellView addSubview:_selectedCellImageView];
                    }
                    completion:^(BOOL finished){
                       // [self dismissViewControllerAnimated:YES completion:nil];
                            [self.navigationController popViewControllerAnimated:YES];
                        
                    }];
    
    

    

    
    
}


- (IBAction)backButtonPress:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
