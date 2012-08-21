//
//  AppDelegate.m
//  SSplitControllerDemo
//
//  Created by 滕 松 on 12-8-17.
//  Copyright (c) 2012年 滕 松. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate()
@property (nonatomic, retain) SSplitContentViewController *aSplitContentViewController;
@property (nonatomic, retain) SSplitContentViewController *bSplitContentViewController;
@property (nonatomic, retain) SSplitContentViewController *cSplitContentViewController;
@property (nonatomic, retain) SSplitContentViewController *dSplitContentViewController;

@end

@implementation AppDelegate
@synthesize splitViewController, aSplitContentViewController, bSplitContentViewController, cSplitContentViewController, dSplitContentViewController;

+ (AppDelegate *)shareAppDelegate {
    return (AppDelegate *)([UIApplication sharedApplication].delegate);
}
+ (SSplitRootViewController *)shareSplitRootViewController {
    return [AppDelegate shareAppDelegate].splitViewController;
}

- (void)dealloc
{
    self.splitViewController = nil;
    self.aSplitContentViewController = nil;
    self.bSplitContentViewController = nil;
    self.cSplitContentViewController = nil;
    self.dSplitContentViewController = nil;
    
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    SSplitContentViewController *_a = [[SSplitContentViewController alloc] init];
    _a.title = @"A Controller";
    self.aSplitContentViewController = _a;
    SSplitNavigationContentViewController *_anv = [[SSplitNavigationContentViewController alloc] initWithRootViewController:_a];
    [_a release];
    
    SSplitContentViewController *_b = [[SSplitContentViewController alloc] init];
    _b.title = @"B Controller";
    self.bSplitContentViewController = _b;
    SSplitNavigationContentViewController *_bnv = [[SSplitNavigationContentViewController alloc] initWithRootViewController:_b];
    [_b release];
    
    SSplitContentViewController *_c = [[SSplitContentViewController alloc] init];
    _c.title = @"C Controller";
    self.cSplitContentViewController = _c;
    SSplitNavigationContentViewController *_cnv = [[SSplitNavigationContentViewController alloc] initWithRootViewController:_c];
    [_c release];
    
    SSplitContentViewController *_d = [[SSplitContentViewController alloc] init];
    _d.title = @"D Controller";
    self.dSplitContentViewController = _d;
    SSplitNavigationContentViewController *_dnv = [[SSplitNavigationContentViewController alloc] initWithRootViewController:_d];
    [_d release];
    
    SSplitRootViewController *_splitVctr = [[SSplitRootViewController alloc] init];
    _splitVctr.splitContentViewControllers = [NSArray arrayWithObjects:_anv, _bnv, _cnv, _dnv, nil];
    [_anv release];
    [_bnv release];
    [_cnv release];
    [_dnv release];
    self.splitViewController = _splitVctr;
    [self.window addSubview:self.splitViewController.view];
    [_splitVctr release];
    
    [self.splitViewController splitContentViewController:self.aSplitContentViewController Animated:YES];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {}
- (void)applicationDidEnterBackground:(UIApplication *)application {}
- (void)applicationWillEnterForeground:(UIApplication *)application {}
- (void)applicationDidBecomeActive:(UIApplication *)application {}
- (void)applicationWillTerminate:(UIApplication *)application {}

@end
