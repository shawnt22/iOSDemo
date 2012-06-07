//
//  RootViewController.h
//  GoogleAdMob
//
//  Created by 松 滕 on 12-6-7.
//  Copyright (c) 2012年 shawnt22@gmail.com . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GADBannerView.h"

@interface RootViewController : UIViewController <GADBannerViewDelegate>

@property (nonatomic, retain) GADBannerView *theBannerView;

@end


@interface RootViewController(GAdMob)

+ (void)requestForAdWithBannerView:(GADBannerView *)bannerView;

- (CGPoint)showGADBannerViewCenter;
- (CGPoint)hideGADBannerViewCenter;
- (NSTimeInterval)showGADBannerViewAnimationTimeInterval;
- (NSTimeInterval)hideGADBannerViewAnimationTimeInterval;

- (BOOL)isGADBannerViewShowing;
- (void)showGADBannerViewWithAnimated:(BOOL)animated;
- (void)hideGADBannerViewWithAnimated:(BOOL)animated;
- (void)didFinishGADBannerViewShowAnimation;
- (void)didFinishGADBannerViewHideAnimation;

@end