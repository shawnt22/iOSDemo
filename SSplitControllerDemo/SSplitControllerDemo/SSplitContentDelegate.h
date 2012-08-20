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
//- (BOOL)shouldSplitWithSplitContentView:(id<SSplitContentViewProtocol>)splitContentView;

- (void)splitContentView:(id<SSplitContentViewProtocol>)splitContentView beginedGesture:(UIGestureRecognizer *)gesture;
- (void)splitContentView:(id<SSplitContentViewProtocol>)splitContentView endedGesture:(UIGestureRecognizer *)gesture;
- (void)splitContentView:(id<SSplitContentViewProtocol>)splitContentView changedGesture:(UIGestureRecognizer *)gesture;
- (void)splitContentView:(id<SSplitContentViewProtocol>)splitContentView canceledGesture:(UIGestureRecognizer *)gesture;

@end

#pragma mark -
/*
 SplitContentView Protocol
 */
@protocol SSplitContentViewProtocol <NSObject>
@required
@property (nonatomic, assign) id<SSplitContentViewDelegate> splitDelegate;
@property (nonatomic, retain) UIGestureRecognizer *beginGesture;
@property (nonatomic, retain) UIGestureRecognizer *moveGesture;

@optional
@property (nonatomic, assign) BOOL shouldSplit;         //  default is YES
- (void)addGestures;
- (void)responseGesture:(UIGestureRecognizer *)gesture;

@end

#pragma mark -
/*
 SplitContentView Util
 */
@interface SSplitContentUtil : NSObject

+ (void)addGesturesWithContent:(UIView<SSplitContentViewProtocol> *)content;
+ (void)responseGesture:(UIGestureRecognizer *)gesture Content:(UIView<SSplitContentViewProtocol> *)content;
+ (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer Content:(UIView<SSplitContentViewProtocol> *)content;

@end
