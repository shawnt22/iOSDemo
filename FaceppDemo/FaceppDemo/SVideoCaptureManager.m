//
//  SVideoCaptureManager.m
//  FaceppDemo
//
//  Created by 佳佑 on 14-4-1.
//  Copyright (c) 2014年 shawnt22@gmail.com. All rights reserved.
//

#import "SVideoCaptureManager.h"

@interface SVideoCaptureManager ()
@property (nonatomic, strong) AVCaptureDevice *device;
@property (nonatomic, strong) AVCaptureSession *session;
@end

@implementation SVideoCaptureManager

- (void)dealloc
{
    [self.session beginConfiguration];
    NSArray *inputs = self.session.inputs;
    for (AVCaptureInput *input in inputs) {
        [self.session removeInput:input];
    }
    NSArray *outputs = self.session.outputs;
    for (AVCaptureOutput *output in outputs) {
        [self.session removeOutput:output];
    }
    [self.session commitConfiguration];
}
- (AVCaptureVideoPreviewLayer *)videoPreviewLayerWithDevicePosition:(AVCaptureDevicePosition)position
{
    AVCaptureVideoPreviewLayer *prelayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:[self videoSessionWithPosition:position]];
    prelayer.backgroundColor = [UIColor clearColor].CGColor;
    prelayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    return prelayer;
}
- (AVCaptureSession *)videoSessionWithPosition:(AVCaptureDevicePosition)position
{
    //  input
    NSError *error = nil;
    AVCaptureDevice *device = [SVideoCaptureManager videoCaptureDeviceWithPosition:position];
    if (!device) {
        return nil;
    }
    AVCaptureInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (error) {
        return nil;
    }
    
    //  output
    AVCaptureVideoDataOutput *videoOutput = [[AVCaptureVideoDataOutput alloc] init];
    videoOutput.alwaysDiscardsLateVideoFrames = YES;
    videoOutput.videoSettings = @{(id)kCVPixelBufferPixelFormatTypeKey : @(kCVPixelFormatType_32BGRA)}; //  kCMPixelFormat_32BGRA
    
    //  session
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    if ([session canAddInput:deviceInput]) {
        [session addInput:deviceInput];
    } else {
        return nil;
    }
    if ([session canAddOutput:videoOutput]) {
        [session addOutput:videoOutput];
    } else {
        return nil;
    }
    [self setSessionPreset:AVAssetExportPresetMediumQuality];
    
    self.device = device;
    self.session = session;
    return session;
}
+ (AVCaptureDevice *)videoCaptureDeviceWithPosition:(AVCaptureDevicePosition)position
{
    AVCaptureDevice *result = nil;
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if (device.position == position) {
            result = device;
            break;
        }
    }
    return result;
}
- (BOOL)setVideoDataOutputSampleBufferDelegate:(id<AVCaptureVideoDataOutputSampleBufferDelegate>)delegate
{
    BOOL result = NO;
    for (AVCaptureOutput *output in self.session.outputs) {
        if ([output isKindOfClass:[AVCaptureVideoDataOutput class]]) {
            AVCaptureVideoDataOutput *dataOutput = (AVCaptureVideoDataOutput *)output;
            [dataOutput setSampleBufferDelegate:delegate queue:dispatch_get_main_queue()];
            result = YES;
        }
    }
    return result;
}

#pragma mark - session setup
- (void)setSessionPreset:(NSString *)sessionPreset
{
    [self.session beginConfiguration];
    self.session.sessionPreset = sessionPreset;
    [self.session commitConfiguration];
}

#pragma mark - device setup
/*
 NSError *error = nil;
 [self.session beginConfiguration];
 if ([self.device lockForConfiguration:&error]) {
 
    ...
 
    [self.device unlockForConfiguration];
 }
 [self.session commitConfiguration];
 */
#define SDeviceBeginConfiguration NSError *error = nil;[self.session beginConfiguration];if ([self.device lockForConfiguration:&error]) {
#define SDeviceCommitConfiguration [self.device unlockForConfiguration];}[self.session commitConfiguration];
#define SDeviceProcessConfiguration(configuration) SDeviceBeginConfiguration configuration SDeviceCommitConfiguration
//  FlashMode
- (BOOL)setFlashMode:(AVCaptureFlashMode)flashMode
{
    BOOL result = NO;
    SDeviceProcessConfiguration(
        if ([self.device isFlashModeSupported:flashMode]) {
            self.device.flashMode = flashMode;
            result = YES;
        }
        [self.device unlockForConfiguration];
    )
    return result;
}
//  TorchMode
- (BOOL)setTorchMode:(AVCaptureTorchMode)torchMode
{
    BOOL result = NO;
    SDeviceProcessConfiguration(
        if ([self.device isTorchModeSupported:torchMode]) {
            self.device.torchMode = torchMode;
            result = YES;
        }
    )
    return result;
}
- (BOOL)setTorchLevel:(float)torchLevel
{
    BOOL result = NO;
    SDeviceProcessConfiguration(
        if ([self.device setTorchModeOnWithLevel:torchLevel error:&error]) {
            result = YES;
        }
    )
    return result;
}
//  FocusMode
- (BOOL)setFocusMode:(AVCaptureFocusMode)focusMode
{
    BOOL result = NO;
    SDeviceProcessConfiguration(
        if ([self.device isFocusModeSupported:focusMode]) {
            self.device.focusMode = focusMode;
            result = YES;
        }
    )
    return result;
}

@end
