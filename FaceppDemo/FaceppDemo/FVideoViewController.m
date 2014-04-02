//
//  FVideoViewController.m
//  FaceppDemo
//
//  Created by 佳佑 on 14-4-1.
//  Copyright (c) 2014年 shawnt22@gmail.com. All rights reserved.
//

#import "FVideoViewController.h"

@interface FVideoViewController () <AVCaptureVideoDataOutputSampleBufferDelegate>
@property (nonatomic, strong) SVideoCaptureManager *videoCaptureManager;
@end

@implementation FVideoViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.videoCaptureManager = [[SVideoCaptureManager alloc] init];
        self.videoCaptureManager.supportedOutput = SVideoCaptureManagerVideoDataOutput;
    }
    return self;
}
- (void)dealloc
{
    [self.videoCaptureManager setVideoDataOutputSampleBufferDelegate:nil];
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
    
    [self.videoCaptureManager setVideoDataOutputSampleBufferDelegate:self];
    
    [self.videoCaptureManager.session startRunning];
}
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    return;
    NSData *data = [NSData dataFromCMSampleBufferRef:sampleBuffer];
    FaceppResult *result = [[FaceppAPI detection] detectWithURL:nil orImageData:data mode:FaceppDetectionModeNormal attribute:FaceppDetectionAttributeRace|FaceppDetectionAttributeSmiling tag:nil async:NO];
    if (result.success) {
        
    }
}
- (void)captureOutput:(AVCaptureOutput *)captureOutput didDropSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{}

@end
