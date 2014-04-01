//
//  FVideoViewController.m
//  FaceppDemo
//
//  Created by 佳佑 on 14-4-1.
//  Copyright (c) 2014年 shawnt22@gmail.com. All rights reserved.
//

#import "FVideoViewController.h"

@interface FVideoViewController ()
@property (nonatomic, strong) SVideoCaptureManager *videoCaptureManager;
@end

@implementation FVideoViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.videoCaptureManager = [[SVideoCaptureManager alloc] init];
    }
    return self;
}
- (void)dealloc
{
    if ([self.videoCaptureManager.session isRunning]) {
        [self.videoCaptureManager.session stopRunning];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AVCaptureVideoPreviewLayer *previewLayer = [self.videoCaptureManager videoPreviewLayerWithDevicePosition:AVCaptureDevicePositionBack];
    previewLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:previewLayer];
    self.view.layer.masksToBounds = YES;
    
    [self.videoCaptureManager.session startRunning];
}

@end
