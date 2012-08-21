//
//  SSplitViewController.h
//  SSplitControllerDemo
//
//  Created by 滕 松 on 12-8-17.
//  Copyright (c) 2012年 滕 松. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSplitContentViewController.h"

@class SSplitContentViewController;
@interface SSplitRootViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, SSPlitControllerDelegate> {
@private
    NSArray *_splitContentViewControllers;
}
@property (nonatomic, retain) NSArray *splitContentViewControllers;         // must confirm <SSplitControllerProtocol>
@property (nonatomic, readonly) UIViewController<SSplitControllerProtocol> *currentOpenningSplitController;

- (void)openSplitContentViewController:(UIViewController<SSplitControllerProtocol> *)controller Animated:(BOOL)animated;
- (void)closeSplitContentViewController:(UIViewController<SSplitControllerProtocol> *)controller Animated:(BOOL)animated;

@end


#pragma mark - Split Content Board
#import "SSplitContentDelegate.h"
@interface SSplitContentBoard : UIView <SSplitContentViewProtocol>

- (SSplitContentBoard *)defaultSplitContentBoard;

@end
