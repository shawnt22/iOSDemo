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
- (void)splitContentView:(id<SSplitContentViewProtocol>)splitContentView beginTouch:(UITouch *)touch;
- (void)splitContentView:(id<SSplitContentViewProtocol>)splitContentView moveTouch:(UITouch *)touch;
- (void)splitContentView:(id<SSplitContentViewProtocol>)splitContentView endTouch:(UITouch *)touch;
- (void)splitContentView:(id<SSplitContentViewProtocol>)splitContentView receiveSwipeGesture:(UISwipeGestureRecognizer *)swipeGesture;

@end

#pragma mark -
/*
 SplitContentView Protocol
 
 注意：
 1. UIView          使用 Touch、Gesture 皆可
 2. UITableView     使用 Touch、Gesture 之一效果更好
 3. UIScrollView    仅支持 Gesture
 4. UIWebView       仅支持 Gesture
 
 */
@protocol SSplitContentViewProtocol <NSObject>
@required
@property (nonatomic, assign) id<SSplitContentViewDelegate> splitDelegate;

@optional
@property (nonatomic, retain) UITouch *beginTouch;
@property (nonatomic, retain) UITouch *moveTouch;
- (void)addSwipeGesture;
- (void)responseSwipeGesture:(UISwipeGestureRecognizer *)swipeGesture;

@end

#pragma mark -
/*
 SplitContentView Util
 */
@interface SSplitContentUtil : NSObject

+ (void)addSwipGestureWithContent:(UIView<SSplitContentViewProtocol> *)content;
+ (void)responseSwipeGesture:(UISwipeGestureRecognizer *)swipeGesture Content:(UIView<SSplitContentViewProtocol> *)content;
+ (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer Content:(UIView<SSplitContentViewProtocol> *)content;

+ (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event Content:(UIView<SSplitContentViewProtocol> *)content;
+ (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event Content:(UIView<SSplitContentViewProtocol> *)content;
+ (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event Content:(UIView<SSplitContentViewProtocol> *)content;
+ (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event Content:(UIView<SSplitContentViewProtocol> *)content;

@end
