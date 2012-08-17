//
//  SSplitViewController.m
//  SSplitControllerDemo
//
//  Created by 滕 松 on 12-8-17.
//  Copyright (c) 2012年 滕 松. All rights reserved.
//

#import "SSplitViewController.h"

@interface SSplitViewController()
- (void)finishedOpenSplitContentViewControllerAniamtion;
- (void)finishedCloseSplitContentViewControllerAniamtion;
@end
@implementation SSplitViewController
@synthesize splitContentViewControllers, splitDelegate;

#pragma mark init & dealloc
- (id)init {
    self = [super init];
    if (self) {
        self.splitContentViewControllers = nil;
        self.splitDelegate = nil;
    }
    return self;
}
- (void)dealloc {
    self.splitContentViewControllers = nil;
    [super dealloc];
}

#pragma mark controller delegate
- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark content manager
- (void)openSplitContentViewController:(SSplitContentViewController *)contentViewController Animated:(BOOL)animated {}
- (void)closeSplitContentViewController:(SSplitContentViewController *)contentViewController Animated:(BOOL)animated {}
- (void)finishedOpenSplitContentViewControllerAniamtion {}
- (void)finishedCloseSplitContentViewControllerAniamtion {}

@end
