//
//  AppDelegate.h
//  SSplitControllerDemo
//
//  Created by 滕 松 on 12-8-17.
//  Copyright (c) 2012年 滕 松. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSplitContentViewController.h"
#import "SSplitRootViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) SSplitRootViewController *splitViewController;

+ (AppDelegate *)shareAppDelegate;
+ (SSplitRootViewController *)shareSplitRootViewController;

@end
