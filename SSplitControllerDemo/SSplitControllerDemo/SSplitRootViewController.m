//
//  SSplitViewController.m
//  SSplitControllerDemo
//
//  Created by 滕 松 on 12-8-17.
//  Copyright (c) 2012年 滕 松. All rights reserved.
//

#import "SSplitViewController.h"

@interface SSplitViewController()
@property (nonatomic, assign) UITableView *menuTableView;
@property (nonatomic, assign) UIViewController<SSplitControllerProtocol> *submittingSplitController;

- (void)finishedOpenContentViewControllerAniamtion;
- (void)finishedCloseContentViewControllerAniamtion;

- (UIViewController<SSplitControllerProtocol> *)splitControllerWithViewController:(UIViewController<SSplitControllerProtocol> *)controller;
- (void)resetContentViewController;

@end
@implementation SSplitViewController
@synthesize splitContentViewControllers = _splitContentViewControllers;
@synthesize menuTableView;
@synthesize submittingSplitController;
@synthesize currentOpenningSplitController;

#define kSplitContentControllerCenterXOpen       0
#define kSplitContentControllerCenterXClose      0

#pragma mark init & dealloc
- (id)init {
    self = [super init];
    if (self) {
        self.submittingSplitController = nil;
        self.splitContentViewControllers = nil;
    }
    return self;
}
- (void)dealloc {
    self.submittingSplitController = nil;
    self.splitContentViewControllers = nil;
    [super dealloc];
}
- (void)setSplitContentViewControllers:(NSArray *)splitContentViewControllers {
    [_splitContentViewControllers release];
    _splitContentViewControllers = [splitContentViewControllers retain];
    
    for (UIViewController<SSplitControllerProtocol> *content in self.splitContentViewControllers) {
        CGRect _f = content.view.frame;
        _f.origin.y = -20;
        content.view.frame = _f;
        
        if ([content conformsToProtocol:@protocol(SSplitControllerProtocol)]) {
            UIViewController<SSplitControllerProtocol> *_splitCtr = (UIViewController<SSplitControllerProtocol> *)content;
            _splitCtr.splitControllerDelegate = self;
        }
    }
}

#pragma mark controller delegate
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
}

#pragma mark split controller delegate
- (void)splitController:(UIViewController<SSplitControllerProtocol> *)splitController beginedGesutre:(UIGestureRecognizer *)gesture {}
- (void)splitController:(UIViewController<SSplitControllerProtocol> *)splitController endedGesutre:(UIGestureRecognizer *)gesture {}
- (void)splitController:(UIViewController<SSplitControllerProtocol> *)splitController changedGesutre:(UIGestureRecognizer *)gesture {
    if ([gesture isKindOfClass:[UIPanGestureRecognizer class]]) {
        CGPoint begin = [(UIPanGestureRecognizer *)splitController.beginGesture translationInView:self.view];
        CGPoint move = [(UIPanGestureRecognizer *)splitController.moveGesture translationInView:self.view];
        CGPoint velocity = [(UIPanGestureRecognizer *)splitController.moveGesture velocityInView:self.view];
        NSLog(@"move from : %@ to : %@ at : %@", NSStringFromCGPoint(begin), NSStringFromCGPoint(move), NSStringFromCGPoint(velocity));
        
        
    }
}
- (void)splitController:(UIViewController<SSplitControllerProtocol> *)splitController canceledGesutre:(UIGestureRecognizer *)gesture {}

#pragma mark table delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.splitContentViewControllers count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *_identifier = @"cell";
    UITableViewCell *_cell = [tableView dequeueReusableCellWithIdentifier:_identifier];
    if (!_cell) {
        _cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_identifier] autorelease];
    }
    _cell.textLabel.text = [NSString stringWithFormat:@"Controller %d", indexPath.row];
    return _cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark content manager
- (UIViewController<SSplitControllerProtocol> *)currentOpenningSplitController {
    for (UIViewController<SSplitControllerProtocol> *controller in self.splitContentViewControllers) {
        if (controller.isSplitOpenning) {
            return controller;
        }
    }
    return nil;
}
- (UIViewController<SSplitControllerProtocol> *)splitControllerWithViewController:(UIViewController<SSplitControllerProtocol> *)controller {
    UIViewController<SSplitControllerProtocol> *target = controller.splitNavigationController;
    target = target ? target : controller;
    for (UIViewController<SSplitControllerProtocol> *ctr in self.splitContentViewControllers) {
        if (target == ctr) {
            return ctr;
        }
    }
    return nil;
}
- (void)openSplitContentViewController:(UIViewController<SSplitControllerProtocol> *)controller Animated:(BOOL)animated {
    controller = [self splitControllerWithViewController:controller];
    if (controller.isSplitOpenning) {
        return;
    }
    self.submittingSplitController = controller;
    [self resetContentViewController];
    [self.view addSubview:self.submittingSplitController.view];
    CGRect _f = self.submittingSplitController.view.frame;
    _f.origin.x = 240.0;
    if (animated) {
        [UIView beginAnimations:@"open" context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDidStopSelector:@selector(finishedOpenContentViewControllerAniamtion)];
        controller.view.frame = _f;
        [UIView commitAnimations];
    } else {
        controller.view.frame = _f;
        [self finishedOpenContentViewControllerAniamtion];
    }
}
- (void)closeSplitContentViewController:(UIViewController<SSplitControllerProtocol> *)controller Animated:(BOOL)animated {
    controller = [self splitControllerWithViewController:controller];
    if (!controller.isSplitOpenning) {
        return;
    }
    self.submittingSplitController = controller;
    CGPoint _center = controller.view.center;
    _center.x = kSplitContentControllerCenterXClose;
    if (animated) {
        [UIView beginAnimations:@"close" context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDidStopSelector:@selector(finishedCloseContentViewControllerAniamtion)];
        controller.view.center = _center;
        [UIView commitAnimations];
    } else {
        controller.view.center = _center;
        [self finishedCloseContentViewControllerAniamtion];
    }
}
- (void)finishedOpenContentViewControllerAniamtion {
    self.submittingSplitController.isSplitOpenning = YES;
}
- (void)finishedCloseContentViewControllerAniamtion {
    self.submittingSplitController.isSplitOpenning = NO;
}
- (void)resetContentViewController {
    UIViewController<SSplitControllerProtocol> *openning = self.currentOpenningSplitController;
    if (openning) {
        self.submittingSplitController.view.frame = openning.view.frame;
    }
    for (UIViewController *cvctr in self.splitContentViewControllers) {
        if (cvctr.view.superview) {
            [cvctr.view removeFromSuperview];
        }
    }
}


@end
