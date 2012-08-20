//
//  SSplitContentViewController.h
//  SSplitControllerDemo
//
//  Created by 滕 松 on 12-8-17.
//  Copyright (c) 2012年 滕 松. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSplitContentDelegate.h"

#pragma mark - Content View Controller
@interface SSplitContentViewController : UIViewController <SSplitContentViewDelegate, SSplitControllerProtocol>

@end

@interface SSplitNavigationContentViewController : UINavigationController <SSplitControllerProtocol>
@property (nonatomic, readonly) UIViewController<SSplitControllerProtocol, SSplitContentViewDelegate> *splitRootViewController;

@end

#pragma mark - tset views
@interface TestView : UIView <SSplitContentViewProtocol>

@end

@interface TestTableView : UITableView <UITableViewDelegate, UITableViewDataSource, SSplitContentViewProtocol>

@end

@interface TestWebView : UIWebView <SSplitContentViewProtocol>

@end

@interface TestScrolView : UIScrollView <SSplitContentViewProtocol>

@end