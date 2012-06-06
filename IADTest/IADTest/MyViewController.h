//
//  MyViewController.h
//  IADTest
//
//  Created by 松 滕 on 12-6-6.
//  Copyright (c) 2012年 shawnt22@gmail.com . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <iAd/iAd.h>

@interface MyViewController : UIViewController <ADBannerViewDelegate>

@property (nonatomic, retain) ADBannerView *bannerView;

@end

#pragma mark - ADBannerView
@interface MyViewController (ADBannerViewManager)

- (CGPoint)showBVCenter;
- (CGPoint)hideBVCenter;
- (NSTimeInterval)showBVAnimationTimeInterval;
- (NSTimeInterval)hideBVAnimationTimeInterval;
- (BOOL)isBannerViewShowing;
- (void)showBannerViewWithAnimated:(BOOL)animated;
- (void)didFinishShowBannerViewAnimation;
- (void)hideBannerViewWithAnimated:(BOOL)animated;
- (void)didFinishHideBannerViewAnimation;

@end
