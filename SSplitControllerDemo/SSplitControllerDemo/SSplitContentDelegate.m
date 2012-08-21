//
//  SSplitContentDelegate.m
//  SSplitControllerDemo
//
//  Created by 滕 松 on 12-8-17.
//  Copyright (c) 2012年 滕 松. All rights reserved.
//

#import "SSplitContentDelegate.h"

@implementation SSplitContentUtil


+ (UIViewController<SSplitViewControllerProtocol> *)splitViewControllerWithSplitNavigationController:(UINavigationController<SSplitViewControllerProtocol> *)nctr {
    if ([nctr.viewControllers count] > 0) {
        UIViewController *_root = [nctr.viewControllers objectAtIndex:0];
        if ([_root conformsToProtocol:@protocol(SSplitViewControllerProtocol)]) {
            return (UIViewController<SSplitViewControllerProtocol> *)_root;
        }
    }
    return nil;
}
+ (UINavigationController<SSplitViewControllerProtocol> *)splitNavigationControllerWithSplitViewController:(UIViewController<SSplitViewControllerProtocol> *)vctr {
    UINavigationController *snctr = vctr.navigationController;
    if ([snctr conformsToProtocol:@protocol(SSplitViewControllerProtocol)]) {
        return (UINavigationController<SSplitViewControllerProtocol> *)snctr;
    } else {
        return nil;
    }
}

@end
