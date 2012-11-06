//
//  RootViewController.m
//  Flip3DDemo
//
//  Created by 滕 松 on 12-9-27.
//  Copyright (c) 2012年 shawnt22@gmail.com. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
@property (nonatomic, retain) UIView *contentView;
@end

@implementation RootViewController
@synthesize contentView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}
- (void)dealloc {
    self.contentView = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *_v = [[UIView alloc] initWithFrame:CGRectMake(110, 150, 100, 100)];
    _v.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_v];
    self.contentView = _v;
    [_v release];
    
    UIButton *_btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _btn.frame = CGRectMake(ceilf((self.view.bounds.size.width-200)/2), self.view.bounds.size.height-44-40, 200, 44);
    [_btn addTarget:self action:@selector(transitionAction:) forControlEvents:UIControlEventTouchUpInside];
    [_btn setTitle:@"transition" forState:UIControlStateNormal];
    [self.view addSubview:_btn];
}
- (void)transitionAction:(id)sender {
    NSTimeInterval _duration = 2.0;
//    CATransition *_flipAnimation = [[CATransition alloc] init];
//    _flipAnimation.delegate = self;
//    _flipAnimation.removedOnCompletion = YES;
//    _flipAnimation.type = kCATransitionMoveIn;
//    _flipAnimation.subtype = kCATransitionFromLeft;
//    _flipAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    _flipAnimation.duration = 0.75;
//    [self.contentView.layer addAnimation:_flipAnimation forKey:@"flip"];
//    [_flipAnimation release];
    NSLog(@"%@ %@", NSStringFromCGPoint(self.contentView.layer.position), NSStringFromCGRect(self.contentView.frame));
    
    
    [UIView beginAnimations:@"flip" context:NULL];
    [UIView setAnimationDuration:_duration];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.contentView cache:YES];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView commitAnimations];
    
    // create the path for the keyframe animation
    CGMutablePathRef thePath = CGPathCreateMutable();
    CGPathMoveToPoint(thePath,NULL,160.0f,200.f);
    CGPathAddCurveToPoint(thePath,NULL,
                          250.0,100.0f,
                          250.0f,100.0f,
                          160.0f,199.0f);
    
    // create an explicit keyframe animation that
    // animates the target layer's position property
    // and set the animation's path property
    CAKeyframeAnimation *theAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    theAnimation.path = thePath;
    CFRelease(thePath);
    
    // create an animation group and add the keyframe animation
    CAAnimationGroup *theGroup = [CAAnimationGroup animation];
    theGroup.animations=[NSArray arrayWithObject:theAnimation];
    theGroup.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    theGroup.duration=_duration;
    
    [self.contentView.layer addAnimation:theGroup forKey:@"move"];
    
}

#pragma mark animation delegate
- (void)animationDidStart:(CAAnimation *)anim {
    NSLog(@"animation start");
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"animation stop");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
