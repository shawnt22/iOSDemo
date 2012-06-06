//
//  MyViewController.m
//  IADTest
//
//  Created by 松 滕 on 12-6-6.
//  Copyright (c) 2012年 shawnt22@gmail.com . All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController()
@property (nonatomic, assign) BOOL isADbannerViewShowing;
@end
@implementation MyViewController
@synthesize bannerView;
@synthesize isADbannerViewShowing;

- (id)init {
    self = [super init];
    if (self) {
        self.isADbannerViewShowing = NO;
        
        ADBannerView *_bv = [[ADBannerView alloc] initWithFrame:CGRectZero];
        _bv.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
        _bv.delegate = self;
        self.bannerView = _bv;
        [_bv release];
    }
    return self;
}
- (void)dealloc {
    self.bannerView.delegate = nil;
    self.bannerView = nil;
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    UIButton *_show = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _show.frame = CGRectMake(60, 100, 200, 44);
    [_show setTitle:@"AD BannerView" forState:UIControlStateNormal];
    [_show addTarget:self action:@selector(showAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_show];
}
- (void)showAction:(id)sender {
    if ([self isBannerViewShowing]) {
        [self hideBannerViewWithAnimated:YES];
    } else {
        [self showBannerViewWithAnimated:YES];
    }
}

@end

#pragma mark - ADBannerView
@implementation MyViewController (ADBannerViewManager)

#pragma mark ADBannerView Delegate
- (void)bannerViewWillLoadAd:(ADBannerView *)banner {
    NSLog(@"bannerViewWillLoadAd");
}
- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    NSLog(@"bannerViewDidLoadAd");
    [self showBannerViewWithAnimated:YES];
}
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    NSLog(@"didFailToReceiveAdWithError : %@", error);
    [self hideBannerViewWithAnimated:YES];
}
- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave {
    NSLog(@"bannerViewActionShouldBegin : %d", willLeave);
    return YES;
}
- (void)bannerViewActionDidFinish:(ADBannerView *)banner {
    NSLog(@"bannerViewActionDidFinish");
}

#pragma mark show & hide
- (CGPoint)showBVCenter {
    return CGPointMake(160.0, 435.0);
}
- (CGPoint)hideBVCenter {
    return CGPointMake(160.0, 485.0);
}
- (NSTimeInterval)showBVAnimationTimeInterval {
    return 0.3f;
}
- (NSTimeInterval)hideBVAnimationTimeInterval {
    return 0.3f;
}
- (BOOL)isBannerViewShowing {
    return self.isADbannerViewShowing;
}
- (void)showBannerViewWithAnimated:(BOOL)animated {
    if ([self isBannerViewShowing]) {
        return;
    }
    [self.view addSubview:self.bannerView];
    self.bannerView.center = [self hideBVCenter];
    if (animated) {
        [ADBannerView beginAnimations:@"showADBV" context:NULL];
        [ADBannerView setAnimationDelegate:self];
        [ADBannerView setAnimationDuration:[self showBVAnimationTimeInterval]];
        [ADBannerView setAnimationDidStopSelector:@selector(didFinishShowBannerViewAnimation)];
        self.bannerView.center = [self showBVCenter];
        [ADBannerView commitAnimations];
    } else {
        self.bannerView.center = [self showBVCenter];
        [self didFinishShowBannerViewAnimation];
    }
}
- (void)didFinishShowBannerViewAnimation {
    self.isADbannerViewShowing = YES;
}
- (void)hideBannerViewWithAnimated:(BOOL)animated {
    if (![self isBannerViewShowing]) {
        return;
    }
    self.bannerView.center = [self showBVCenter];
    if (animated) {
        [ADBannerView beginAnimations:@"hideADBV" context:NULL];
        [ADBannerView setAnimationDelegate:self];
        [ADBannerView setAnimationDuration:[self hideBVAnimationTimeInterval]];
        [ADBannerView setAnimationDidStopSelector:@selector(didFinishHideBannerViewAnimation)];
        self.bannerView.center = [self hideBVCenter];
        [ADBannerView commitAnimations];
    } else {
        self.bannerView.center = [self hideBVCenter];
        [self didFinishHideBannerViewAnimation];
    }
}
- (void)didFinishHideBannerViewAnimation {
    self.isADbannerViewShowing = NO;
    
    if (self.bannerView.superview) {
        [self.bannerView removeFromSuperview];
    }
}

@end
