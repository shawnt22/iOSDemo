//
//  SSplitViewController.h
//  SSplitControllerDemo
//
//  Created by 滕 松 on 12-8-17.
//  Copyright (c) 2012年 滕 松. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSplitContentViewController.h"

@class SSplitViewController;
@protocol SSplitViewControllerDelegate <NSObject>
@optional

@end

@class SSplitContentViewController;
@interface SSplitViewController : UIViewController
@property (nonatomic, retain) NSArray *splitContentViewControllers;
@property (nonatomic, assign) id<SSplitViewControllerDelegate> splitDelegate;

- (void)openSplitContentViewController:(SSplitContentViewController *)contentViewController Animated:(BOOL)animated;
- (void)closeSplitContentViewController:(SSplitContentViewController *)contentViewController Animated:(BOOL)animated;

@end
