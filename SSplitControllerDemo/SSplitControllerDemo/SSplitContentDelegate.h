//
//  SSplitContentDelegate.h
//  SSplitControllerDemo
//
//  Created by 滕 松 on 12-8-17.
//  Copyright (c) 2012年 滕 松. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark -
/*
 SplitContentView Delegate
 */
@protocol SSplitContentViewProtocol;
@protocol SSplitContentViewDelegate <NSObject>
@optional
- (void)splitContentView:(UIView<SSplitContentViewProtocol> *)splitContentView beginedGesture:(UIGestureRecognizer *)gesture;
- (void)splitContentView:(UIView<SSplitContentViewProtocol> *)splitContentView endedGesture:(UIGestureRecognizer *)gesture;
- (void)splitContentView:(UIView<SSplitContentViewProtocol> *)splitContentView changedGesture:(UIGestureRecognizer *)gesture;
- (void)splitContentView:(UIView<SSplitContentViewProtocol> *)splitContentView canceledGesture:(UIGestureRecognizer *)gesture;

@end

#pragma mark -
/*
 SplitContentView Protocol
 */
typedef enum {
    SSplitContentViewStatusCover,
    SSplitContentViewStatusSplit,
}SSplitContentViewStatus;

@protocol SSplitContentViewProtocol <NSObject>
@required
@property (nonatomic, assign) id<SSplitContentViewDelegate> splitDelegate;

@optional
@property (nonatomic, assign) BOOL splitEnable;         //  default is YES
@property (nonatomic, assign) CGPoint originalPoint;
@property (nonatomic, assign) CGPoint currentPoint;
@property (nonatomic, assign) SSplitContentViewStatus status;
- (void)addGestures;
- (void)responseGesture:(UIGestureRecognizer *)gesture;

@end

/*
 SplitController Protocol
 */
@protocol SSplitViewControllerProtocol <NSObject>
@optional
@property (nonatomic, readonly) UINavigationController<SSplitViewControllerProtocol> *splitNavigationController;
@property (nonatomic, readonly) UIViewController<SSplitViewControllerProtocol> *splitViewController;

@end

#pragma mark -
/*
 SplitContentView Util
 */
@interface SSplitContentUtil : NSObject

+ (UIViewController<SSplitViewControllerProtocol> *)splitViewControllerWithSplitNavigationController:(UINavigationController<SSplitViewControllerProtocol> *)nctr;
+ (UINavigationController<SSplitViewControllerProtocol> *)splitNavigationControllerWithSplitViewController:(UIViewController<SSplitViewControllerProtocol> *)vctr;

@end
