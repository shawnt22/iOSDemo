//
//  AppDelegate.m
//  TCustomCellBGViewDemo
//
//  Created by 滕 松 on 12-8-22.
//  Copyright (c) 2012年 shawnt22@gmail.com. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize rootNavigationController;

- (void)dealloc
{
    self.rootNavigationController = nil;
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    RootViewController *_root = [[RootViewController alloc] init];
    UINavigationController *_rnctr = [[UINavigationController alloc] initWithRootViewController:_root];
    [_root release];
    self.rootNavigationController = _rnctr;
    [_rnctr release];
    
    [self.window addSubview:self.rootNavigationController.view];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {}
- (void)applicationDidEnterBackground:(UIApplication *)application {}
- (void)applicationWillEnterForeground:(UIApplication *)application {}
- (void)applicationDidBecomeActive:(UIApplication *)application {}
- (void)applicationWillTerminate:(UIApplication *)application {}

@end
