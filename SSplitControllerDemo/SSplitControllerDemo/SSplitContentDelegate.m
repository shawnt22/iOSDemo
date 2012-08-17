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
+ (void)addSwipGestureWithContent:(UIView<SSplitContentViewProtocol> *)content {
    UISwipeGestureRecognizer *_leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:content action:@selector(responseSwipeGesture:)];
    _leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [content addGestureRecognizer:_leftSwipe];
    [_leftSwipe release];
    
    UISwipeGestureRecognizer *_rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:content action:@selector(responseSwipeGesture:)];
    _rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [content addGestureRecognizer:_rightSwipe];
    [_rightSwipe release];
}
+ (void)responseSwipeGesture:(UISwipeGestureRecognizer *)swipeGesture Content:(UIView<SSplitContentViewProtocol> *)content {
    if (content.splitDelegate) {
        if ([content.splitDelegate respondsToSelector:@selector(shouldSplitWithSplitContentView:)]) {
            if (![content.splitDelegate shouldSplitWithSplitContentView:content]) {
                return;
            }
        }
        if ([content.splitDelegate respondsToSelector:@selector(splitContentView:receiveSwipeGesture:)]) {
            [content.splitDelegate splitContentView:content receiveSwipeGesture:swipeGesture];
        }
    }
}
+ (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer Content:(UIView<SSplitContentViewProtocol> *)content {
    return YES;
}

#pragma mark touch
+ (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event Content:(UIView<SSplitContentViewProtocol> *)content {
    content.beginTouch = [touches anyObject];
    
    if (content.splitDelegate) {
        if ([content.splitDelegate respondsToSelector:@selector(shouldSplitWithSplitContentView:)]) {
            if (![content.splitDelegate shouldSplitWithSplitContentView:content]) {
                return;
            }
        }
        if ([content.splitDelegate respondsToSelector:@selector(splitContentView:beginTouch:)]) {
            [content.splitDelegate splitContentView:content beginTouch:content.beginTouch];
        }
    }
}
+ (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event Content:(UIView<SSplitContentViewProtocol> *)content {
    content.beginTouch = nil;
    content.moveTouch = nil;
    
    if (content.splitDelegate) {
        if ([content.splitDelegate respondsToSelector:@selector(shouldSplitWithSplitContentView:)]) {
            if (![content.splitDelegate shouldSplitWithSplitContentView:content]) {
                return;
            }
        }
        if ([content.splitDelegate respondsToSelector:@selector(splitContentView:endTouch:)]) {
            [content.splitDelegate splitContentView:content endTouch:[touches anyObject]];
        }
    }
}
+ (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event Content:(UIView<SSplitContentViewProtocol> *)content {
    content.moveTouch = [touches anyObject];
    
    if (content.splitDelegate) {
        if ([content.splitDelegate respondsToSelector:@selector(shouldSplitWithSplitContentView:)]) {
            if (![content.splitDelegate shouldSplitWithSplitContentView:content]) {
                return;
            }
        }
        if ([content.splitDelegate respondsToSelector:@selector(splitContentView:moveTouch:)]) {
            [content.splitDelegate splitContentView:content moveTouch:content.moveTouch];
        }
    }
}
+ (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event Content:(UIView<SSplitContentViewProtocol> *)content {
    content.beginTouch = nil;
    content.moveTouch = nil;
    
    if (content.splitDelegate) {
        if ([content.splitDelegate respondsToSelector:@selector(shouldSplitWithSplitContentView:)]) {
            if (![content.splitDelegate shouldSplitWithSplitContentView:content]) {
                return;
            }
        }
        if ([content.splitDelegate respondsToSelector:@selector(splitContentView:endTouch:)]) {
            [content.splitDelegate splitContentView:content endTouch:[touches anyObject]];
        }
    }
}

@end
