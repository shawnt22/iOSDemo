//
//  SVideoCaptureManager.h
//  FaceppDemo
//
//  Created by 佳佑 on 14-4-1.
//  Copyright (c) 2014年 shawnt22@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>

typedef enum : NSUInteger {
    SVideoCaptureManagerVideoDataOutput = 1 << 0,
    SVideoCaptureManagerStillImageOutput = 1 << 1,
} SVideoCaptureManagerOutput;

@interface SVideoCaptureManager : NSObject
@property (nonatomic, readonly) AVCaptureSession *session;
@property (nonatomic, readonly) AVCaptureStillImageOutput *stillImageOutput;
@property (nonatomic, readonly) AVCaptureVideoDataOutput *videoDataOutput;
@property (nonatomic, unsafe_unretained) SVideoCaptureManagerOutput supportedOutput;

- (AVCaptureVideoPreviewLayer *)videoPreviewLayerWithDevicePosition:(AVCaptureDevicePosition)position;
- (BOOL)setVideoDataOutputSampleBufferDelegate:(id<AVCaptureVideoDataOutputSampleBufferDelegate>)delegate;  //  do not call before videoPreviewLayerWithDevicePosition:

@end
