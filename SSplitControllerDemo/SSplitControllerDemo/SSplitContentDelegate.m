//
//  SSplitContentDelegate.m
//  SSplitControllerDemo
//
//  Created by 滕 松 on 12-8-17.
//  Copyright (c) 2012年 滕 松. All rights reserved.
//

#import "SSplitContentDelegate.h"

@implementation SSplitContentUtil

#pragma mark gesture
+ (void)addGesturesWithContent:(UIView<SSplitContentViewProtocol> *)content {
    UIPanGestureRecognizer *_pan = [[UIPanGestureRecognizer alloc] initWithTarget:content action:@selector(responseGesture:)];
    [content addGestureRecognizer:_pan];
    [_pan release];
    
//    UISwipeGestureRecognizer *_leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:content action:@selector(responseSwipeGesture:)];
//    _leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
//    [content addGestureRecognizer:_leftSwipe];
//    [_leftSwipe release];
//    
//    UISwipeGestureRecognizer *_rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:content action:@selector(responseSwipeGesture:)];
//    _rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
//    [content addGestureRecognizer:_rightSwipe];
//    [_rightSwipe release];
}
+ (void)responseGesture:(UIGestureRecognizer *)gesture Content:(UIView<SSplitContentViewProtocol> *)content {
    if (content.splitDelegate) {
        if ([content respondsToSelector:@selector(shouldSplit)] && !content.shouldSplit) {
            return;
        }
        switch (gesture.state) {
            case UIGestureRecognizerStatePossible:
                break;
            case UIGestureRecognizerStateBegan:
            {
                content.beginGesture = gesture;
                if ([content.splitDelegate respondsToSelector:@selector(splitContentView:beginedGesture:)]) {
                    [content.splitDelegate splitContentView:content beginedGesture:gesture];
                }
            }
                break;
            case UIGestureRecognizerStateChanged:
            {
                content.moveGesture = gesture;
                if ([content.splitDelegate respondsToSelector:@selector(splitContentView:changedGesture:)]) {
                    [content.splitDelegate splitContentView:content changedGesture:gesture];
                }
            }
                break;
            case UIGestureRecognizerStateEnded:
            {
                if ([content.splitDelegate respondsToSelector:@selector(splitContentView:endedGesture:)]) {
                    [content.splitDelegate splitContentView:content endedGesture:gesture];
                }
                content.beginGesture = nil;
                content.moveGesture = nil;
            }
                break;
            case UIGestureRecognizerStateCancelled:
            {
                if ([content.splitDelegate respondsToSelector:@selector(splitContentView:canceledGesture:)]) {
                    [content.splitDelegate splitContentView:content canceledGesture:gesture];
                }
                content.beginGesture = nil;
                content.moveGesture = nil;
            }
                break;
            default:
            {
                if ([content.splitDelegate respondsToSelector:@selector(splitContentView:canceledGesture:)]) {
                    [content.splitDelegate splitContentView:content canceledGesture:gesture];
                }
                content.beginGesture = nil;
                content.moveGesture = nil;
            }
                break;
        }
    }
}
+ (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer Content:(UIView<SSplitContentViewProtocol> *)content {
    return YES;
}
+ (UINavigationController<SSplitControllerProtocol> *)splitNavigationControllerWithSplitController:(UIViewController<SSplitControllerProtocol> *)splitController {
    UINavigationController *nctr = splitController.navigationController;
    if ([nctr conformsToProtocol:@protocol(SSplitControllerProtocol)]) {
        return (UINavigationController<SSplitControllerProtocol> *)nctr;
    } else {
        return nil;
    }
}

@end
