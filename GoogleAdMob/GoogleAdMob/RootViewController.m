//
//  RootViewController.m
//  GoogleAdMob
//
//  Created by 松 滕 on 12-6-7.
//  Copyright (c) 2012年 shawnt22@gmail.com . All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
@property (nonatomic, assign) BOOL isCurrentGADBannerViewShowing;
@end

@implementation RootViewController
@synthesize theBannerView;
@synthesize isCurrentGADBannerViewShowing;

- (void)dealloc {
    self.theBannerView = nil;
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    GADBannerView *_adb = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    _adb.delegate = self;
    _adb.adUnitID = @"My AD Unit ID";
    self.theBannerView = _adb;
    [_adb release];
    
    [RootViewController requestForAdWithBannerView:self.theBannerView];
}
- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

@end


@implementation RootViewController(GAdMob)

#pragma mark GADBannerView Manager
+ (void)requestForAdWithBannerView:(GADBannerView *)bannerView {
    GADRequest *request = [GADRequest request];
    //  Test AdMob
    request.testing = YES;
    [bannerView loadRequest:request];
}
- (CGPoint)showGADBannerViewCenter {
    return CGPointMake(160.0, 435.0);
}
- (CGPoint)hideGADBannerViewCenter {
    return CGPointMake(160.0, 485.0);
}
- (NSTimeInterval)showGADBannerViewAnimationTimeInterval {
    return 0.3;
}
- (NSTimeInterval)hideGADBannerViewAnimationTimeInterval {
    return 0.3;
}
- (BOOL)isGADBannerViewShowing {
    return self.isCurrentGADBannerViewShowing;
}
- (void)showGADBannerViewWithAnimated:(BOOL)animated {
    if ([self isGADBannerViewShowing]) {
        return;
    }
    [self.view addSubview:self.theBannerView];
    self.theBannerView.center = [self hideGADBannerViewCenter];
    if (animated) {
        [GADBannerView beginAnimations:@"showGAD" context:NULL];
        [GADBannerView setAnimationDuration:[self showGADBannerViewAnimationTimeInterval]];
        [GADBannerView setAnimationDelegate:self];
        [GADBannerView setAnimationDidStopSelector:@selector(didFinishGADBannerViewShowAnimation)];
        self.theBannerView.center = [self showGADBannerViewCenter];
        [GADBannerView commitAnimations];
    } else {
        self.theBannerView.center = [self showGADBannerViewCenter];
        [self didFinishGADBannerViewShowAnimation];
    }
}
- (void)hideGADBannerViewWithAnimated:(BOOL)animated {
    if (![self isGADBannerViewShowing]) {
        return;
    }
    self.theBannerView.center = [self showGADBannerViewCenter];
    if (animated) {
        [GADBannerView beginAnimations:@"hideGAD" context:NULL];
        [GADBannerView setAnimationDuration:[self hideGADBannerViewAnimationTimeInterval]];
        [GADBannerView setAnimationDelegate:self];
        [GADBannerView setAnimationDidStopSelector:@selector(didFinishGADBannerViewHideAnimation)];
        self.theBannerView.center = [self hideGADBannerViewCenter];
        [GADBannerView commitAnimations];
    } else {
        self.theBannerView.center = [self hideGADBannerViewCenter];
        [self didFinishGADBannerViewHideAnimation];
    }
}
- (void)didFinishGADBannerViewShowAnimation {
    self.isCurrentGADBannerViewShowing = YES;
}
- (void)didFinishGADBannerViewHideAnimation {
    if (self.theBannerView.superview) {
        [self.theBannerView removeFromSuperview];
    }
    self.isCurrentGADBannerViewShowing = NO;
}

#pragma mark GADBannerView Delegate
- (void)adViewDidReceiveAd:(GADBannerView *)view {
    [self showGADBannerViewWithAnimated:YES];
}
- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"%@", error);
    [self hideGADBannerViewWithAnimated:YES];
}
- (void)adViewWillPresentScreen:(GADBannerView *)adView {}
- (void)adViewWillDismissScreen:(GADBannerView *)adView {}
- (void)adViewDidDismissScreen:(GADBannerView *)adView {}
- (void)adViewWillLeaveApplication:(GADBannerView *)adView {}

@end