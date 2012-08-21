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
- (BOOL)shouldSplitWithSplitContentView:(id<SSplitContentViewProtocol>)splitContentView;

- (void)splitContentView:(UIView<SSplitContentViewProtocol> *)splitContentView beginedGesture:(UIGestureRecognizer *)gesture;
- (void)splitContentView:(UIView<SSplitContentViewProtocol> *)splitContentView endedGesture:(UIGestureRecognizer *)gesture;
- (void)splitContentView:(UIView<SSplitContentViewProtocol> *)splitContentView changedGesture:(UIGestureRecognizer *)gesture;
- (void)splitContentView:(UIView<SSplitContentViewProtocol> *)splitContentView canceledGesture:(UIGestureRecognizer *)gesture;

@end

/*
 SplitController Delegate
 */
@protocol SSplitControllerProtocol;
@protocol SSPlitControllerDelegate <NSObject>
@optional
- (void)splitController:(UIViewController<SSplitControllerProtocol> *)splitController beginedGesutre:(UIGestureRecognizer *)gesture;
- (void)splitController:(UIViewController<SSplitControllerProtocol> *)splitController endedGesutre:(UIGestureRecognizer *)gesture;
- (void)splitController:(UIViewController<SSplitControllerProtocol> *)splitController changedGesutre:(UIGestureRecognizer *)gesture;
- (void)splitController:(UIViewController<SSplitControllerProtocol> *)splitController canceledGesutre:(UIGestureRecognizer *)gesture;

@end

#pragma mark -
/*
 SplitContentView Protocol
 */
@protocol SSplitContentViewProtocol <NSObject>
@required
@property (nonatomic, assign) id<SSplitContentViewDelegate> splitDelegate;

@optional
@property (nonatomic, assign) BOOL splitEnable;         //  default is YES
- (void)addGestures;
- (void)responseGesture:(UIGestureRecognizer *)gesture;

@end

/*
 SplitController Protocol
 */
@protocol SSplitControllerProtocol <NSObject>
@required
@property (nonatomic, assign) CGPoint beginPoint;
@property (nonatomic, assign) CGPoint movePoint;
@property (nonatomic, assign) BOOL isSplitOpenning;
@property (nonatomic, assign) BOOL splitEnable;

@optional
@property (nonatomic, assign) id<SSPlitControllerDelegate> splitControllerDelegate;
- (UINavigationController<SSplitControllerProtocol> *)splitNavigationController;

@property (nonatomic, assign) CGFloat originX;

@end

#pragma mark -
/*
 SplitContentView Util
 */
@interface SSplitContentUtil : NSObject

+ (void)addGesturesWithContent:(UIView<SSplitContentViewProtocol> *)content;
+ (void)responseGesture:(UIGestureRecognizer *)gesture Content:(UIView<SSplitContentViewProtocol> *)content;
+ (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer Content:(UIView<SSplitContentViewProtocol> *)content;
+ (UINavigationController<SSplitControllerProtocol> *)splitNavigationControllerWithSplitController:(UIViewController<SSplitControllerProtocol> *)splitController;

@end
